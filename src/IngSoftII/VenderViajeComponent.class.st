Class {
	#name : #VenderViajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'mensaje',
		'usuario',
		'nombreUsuario',
		'precio',
		'sintomas'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
VenderViajeComponent class >> newWithViaje: unViaje [
	^ self new initializeWithViaje: unViaje
]

{ #category : #initialization }
VenderViajeComponent >> initializeWithViaje: unViaje [
	super initialize.
	viaje := unViaje.
	sintomas:=''
]

{ #category : #'as yet unclassified' }
VenderViajeComponent >> registrarVenta [
	viaje venderPasaje: 1.
	usuario 
		agregarPasaje:
			(Pasaje
				newWithViaje: viaje
				andCantidad: 1
				andPrecio: precio
				andInsumos: nil).
]

{ #category : #rendering }
VenderViajeComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese nombre de usuario: '.
			aCanvas textArea on: #nombreUsuario of: self.
			aCanvas break.
			aCanvas submitButton
				callback: [ self renderVentaPasaje: aCanvas ];
				with: 'Aceptar' ].
	aCanvas horizontalRule.
	aCanvas heading
		level: 4;
		with: mensaje.
	
]

{ #category : #rendering }
VenderViajeComponent >> renderVentaPasaje: aCanvas [
	self validarUsuario
		ifTrue: [ mensaje := 'Usuario Valido' , nombreUsuario printString ]
		ifFalse: [ mensaje := 'Se creo el usuario:' , nombreUsuario printString
				, ' con contraseña:123456' ].
	sintomas == '' | (sintomas = 'Cancelado')
		ifTrue: [ aCanvas button
				callback: [ "" ];
				with: 'Registrar Sintomas' ]
		ifFalse: [ usuario membresia nombre = 'basico'
				ifTrue: [ precio := viaje precio asInteger printString ]
				ifFalse: [ (sintomas includesSubstring: 'Rechazado' caseSensitive: false)
						ifTrue: [ aCanvas big: 'El pasajero es sospechoso de covid, no puede viajar'.
							usuario rechazar ]
						ifFalse: [ precio := (10 * viaje precio asInteger / 100) printString ].
					aCanvas paragraph: [ 'Total: ' , precio asInteger printString ].
					aCanvas button
						callback: [ self registrarVenta ];
						with: 'Registrar Venta' ] ]
]

{ #category : #'as yet unclassified' }
VenderViajeComponent >> validarUsuario [
	(Sistema soleInstance existeUsuario: nombreUsuario)
		ifTrue: [ usuario := Sistema soleInstance obtenerUsuarioConNU: nombreUsuario.
			^ true ]
		ifFalse: [ Sistema soleInstance
				crearUsuarioPasajeroWithNombreDeUsuario: nombreUsuario
				andContraseña: '123456'
				andFechaNacimiento: ''
				andNombre: ''
				andApellido: ''
				andDni: ''
				andMembresia: 'basica'.
				usuario := Sistema soleInstance obtenerUsuarioConNU: nombreUsuario.
			^ false ]
]
