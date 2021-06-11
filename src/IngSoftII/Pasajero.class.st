Class {
	#name : #Pasajero,
	#superclass : #Usuario,
	#instVars : [
		'fechaNac',
		'dni',
		'membresia',
		'tarjeta',
		'nombreCompleto',
		'pasajes'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Pasajero class >> newWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni andMembresia:unaMembresia [
	^ self new
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andFechaNacimiento: unaFecha
		andNombre: unNombre
		andApellido: unApellido
		andDni: unDni andMembresia:unaMembresia
]

{ #category : #'as yet unclassified' }
Pasajero >> agregarPasaje:unPasaje [
pasajes add:unPasaje
]

{ #category : #'as yet unclassified' }
Pasajero >> cargarTarjetaWithNumero: unNumero andCodigoSeguridad: unCodigo andFechaVencimiento: unaFecha andNombre: unNombre [
	(self
		puedeSerTarjetaWithNumero: unNumero
		andFechaVencimiento: unaFecha)
		ifTrue: [ tarjeta:= Tarjeta
				newWithNumero: unNumero
				andCodigoSeguridad: unCodigo
				andFechaVencimiento: unaFecha
				andNombre: unNombre. ^tarjeta].
	^ nil
]

{ #category : #accessing }
Pasajero >> dni [
	^ dni
]

{ #category : #'as yet unclassified' }
Pasajero >> esNumeroValido: unNumero [
	^ unNumero asInteger asString size = 16
]

{ #category : #'as yet unclassified' }
Pasajero >> estaVigente: unaFecha [
	^ unaFecha  isOnOrAfter: Date today
]

{ #category : #accessing }
Pasajero >> fechaNac [
	^ fechaNac
]

{ #category : #initialization }
Pasajero >> initializeWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni andMembresia: unaMembresia [
	self initialize
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido.
	fechaNac := unaFecha.
	dni := unDni.
	membresia := unaMembresia.
	pasajes:=OrderedCollection new.
]

{ #category : #accessing }
Pasajero >> membresia [
	^ membresia
]

{ #category : #accessing }
Pasajero >> membresia: unaMembresia [
membresia := unaMembresia 
]

{ #category : #'as yet unclassified' }
Pasajero >> modificarWithNombre: unNombre
				andApellido: unApellido
				andContraseña: unaContraseña
				andFechaNacimiento: unaFechaNac
				andDNI: unDNI [
	nombre := unNombre.
	apellido := unApellido.
	contraseña := unaContraseña.
	fechaNac := unaFechaNac.
	dni := unDNI
]

{ #category : #'as yet unclassified' }
Pasajero >> modificarWithNombreUsuario: unNombreUsuario andNombre: unNombre andApellido: unApellido andContraseña: unaContraseña andFechaNacimiento: unaFechaNac andDNI: unDNI [
	nombreUsuario := unNombreUsuario.
	nombre := unNombre.
	apellido:= unApellido.
	contraseña := unaContraseña .
	fechaNac := unaFechaNac .
	dni := unDNI
]

{ #category : #accessing }
Pasajero >> nombreCompleto [
^nombre,' ',apellido
]

{ #category : #accessing }
Pasajero >> pasajes [
 ^pasajes 
]

{ #category : #'as yet unclassified' }
Pasajero >> puedeSerTarjetaWithNumero: unNumero andFechaVencimiento: unaFecha [
	(self esNumeroValido: unNumero)
		ifTrue: [ (self estaVigente: unaFecha)
				ifTrue: [ ^ true ] ].
	^ false
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

{ #category : #'as yet unclassified' }
Pasajero >> soy [ 
^'pasajero'
]

{ #category : #accessing }
Pasajero >> tarjeta [
	^ tarjeta
]
