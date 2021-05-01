Class {
	#name : #Pasajero,
	#superclass : #Usuario,
	#instVars : [
		'fechaNac',
		'dni',
		'membresia',
		'tarjeta'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Pasajero class >> newWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni [
	^ self new
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andFechaNacimiento: unaFecha
		andNombre: unNombre
		andApellido: unApellido
		andDni: unDni
]

{ #category : #'as yet unclassified' }
Pasajero >> cargarTarjetaWithNumero: unNumero andCodigoSeguridad: unCodigo andFechaVencimiento: unaFecha andNombre: unNombre [
|tarjetaCreada|
 (tarjetaCreada :=Tarjeta newWithNumero: unNumero andCodigoSeguridad: unCodigo andFechaVencimiento: unaFecha andNombre: unNombre)ifNotNil: [tarjeta:=tarjetaCreada]
]

{ #category : #initialization }
Pasajero >> initializeWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni [
	 self initialize
				initializeWithNombreDeUsuario: unNombreDeUsuario
				andContraseña: unaContraseña
				andNombre: unNombre
				andApellido: unApellido.
			fechaNac := unaFecha.
			dni := unDni 
]

{ #category : #'as yet unclassified' }
Pasajero >> puedeSerUsuario: unNombreDeUsuario conContraseña: unaContraseña conFechaNac: unaFecha [
	self
		existeUsuario: unNombreDeUsuario
		ifFalse: [ self
				esValidaContraseña: unaContraseña
				ifTrue: [ self esMayorDeEdad: unaFecha ifTrue: [ ^ true ] ] ].
	^ false
]
