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
VenderViajeComponent class >> newWithViaje: unViaje andPasajero:unPasajero andEstado:estado [
	^ self new initializeWithViaje: unViaje andPasajero:unPasajero andEstado:estado
]

{ #category : #initialization }
VenderViajeComponent >> initializeWithViaje: unViaje andPasajero: unPasajero andEstado: estado [
	viaje:=unViaje .
	usuario:=unPasajero .
	sintomas:=estado.
]

{ #category : #'as yet unclassified' }
VenderViajeComponent >> registrarVenta [
	viaje venderPasaje: 1.
	viaje agregarPresencial: usuario.
	usuario
		agregarPasaje:
			(Pasaje
				newWithViaje: viaje
				andCantidad: 1
				andPrecio: precio
				andInsumos: nil).
	self call: (DetalleViajeChoferComponent newWithViaje: viaje)
]

{ #category : #rendering }
VenderViajeComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas
		form: [ aCanvas heading
				level: 3;
				with: viaje nombre.
			aCanvas heading
				level: 4;
				with: 'Pasajero: ' , usuario nombreUsuario.
			usuario membresia nombre = 'basico'
				ifTrue: [ precio := viaje precio asInteger ]
				ifFalse: [ precio :=  viaje precio asInteger -(10 * viaje precio asInteger / 100) ].
			aCanvas text: 'Total: ' , precio printString.
			aCanvas break.
			aCanvas break.
			aCanvas submitButton
				callback: [ self registrarVenta ];
				with: 'Vender pasaje' ]
]
