Class {
	#name : #BuscarPasajeroComponent,
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
BuscarPasajeroComponent class >> newWithViaje: unViaje [
	^ self new initializeWithViaje: unViaje
]

{ #category : #initialization }
BuscarPasajeroComponent >> initializeWithViaje: unViaje [
	super initialize.
	viaje := unViaje.
	sintomas := ''.
	precio:=0.
]

{ #category : #accessing }
BuscarPasajeroComponent >> nombreUsuario [
^nombreUsuario 
]

{ #category : #accessing }
BuscarPasajeroComponent >> nombreUsuario:unNombre [
nombreUsuario :=unNombre 
]

{ #category : #rendering }
BuscarPasajeroComponent >> renderContentOn: aCanvas [
	| msj |
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese nombre de usuario: '.
			aCanvas textArea on: #nombreUsuario of: self.
			aCanvas break.
			aCanvas submitButton
				callback: [ self renderPasajeroOn: aCanvas ];
				with: 'Buscar'.
							aCanvas submitButton
				callback: [ self answer ];
				with: 'Cancelar'.

			aCanvas horizontalRule.
			aCanvas heading
				level: 4;
				with: mensaje.
			usuario ifNotNil:[
			aCanvas submitButton
				callback: [ msj := self
						call:
							(RegistrarSintomasComponent
								newWithUser: usuario
								andViaje: viaje
								objetivo: 'presencial').
					mensaje := 'Usuario: ' , nombreUsuario , msj asString ];
				with: 'Registrar síntomas' ]]
]

{ #category : #rendering }
BuscarPasajeroComponent >> renderPasajeroOn: aCanvas [
	nombreUsuario = ' ' | nombreUsuario isEmpty
		ifTrue: [ mensaje := 'Ingrese un nombre de usuario'.
			^ self ].
	self validarUsuario
		ifTrue: [ mensaje := 'Usuario Valido' , nombreUsuario printString ]
		ifFalse: [ mensaje := 'Se creo el usuario: ' , nombreUsuario printString
				, ' con contraseña: 123456' ]
]

{ #category : #'as yet unclassified' }
BuscarPasajeroComponent >> validarUsuario [
	
	nombreUsuario
		ifNotEmpty: [ (Sistema soleInstance existeUsuario: nombreUsuario)
				ifTrue: [ usuario := Sistema soleInstance obtenerUsuarioConNU: nombreUsuario.
					^ true ]
				ifFalse: [ Sistema soleInstance
						crearUsuarioPasajeroWithNombreDeUsuario: nombreUsuario.	"crearUsuarioPasajeroWithNombreDeUsuario: nombreUsuario
				andContraseña: '123456'
				andFechaNacimiento: ''
				andNombre: ''
				andApellido: ''
				andDni: ''
				andMembresia: MembresiaBasica new."
					usuario := Sistema soleInstance
						obtenerUsuarioConNU: nombreUsuario.
					^ false ] ]
]
