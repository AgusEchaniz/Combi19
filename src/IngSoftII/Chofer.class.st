Class {
	#name : #Chofer,
	#superclass : #Usuario,
	#instVars : [
		'telefono',
		'asignado'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Chofer class >> newWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña  andNombre: unNombre andApellido: unApellido andTelefono:unTelefono [
	^ self new
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido
		andTelefono:unTelefono
]

{ #category : #'as yet unclassified' }
Chofer >> asignar [
asignado:=true
]

{ #category : #'as yet unclassified' }
Chofer >> desasignar [
	asignado := false
]

{ #category : #'as yet unclassified' }
Chofer >> estaAsignado [
^asignado
]

{ #category : #initialization }
Chofer >> initializeWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andNombre: unNombre andApellido: unApellido andTelefono: unTelefono [
	self initialize
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido.
	telefono := unTelefono.
	asignado:=false.
]

{ #category : #modificar }
Chofer >> modificarWithNombre: unNombre andApellido: unApellido andTelefono: unTelefono andContraseña:unaContraseña [ 
	nombre := unNombre.
	apellido := unApellido.
	telefono := unTelefono.
	contraseña :=unaContraseña 
]

{ #category : #modificar }
Chofer >> modificarWithNombreUsuario: unNombreUsuario andNombre: unNombre andApellido: unApellido andTelefono: unTelefono andContraseña:unaContra [
	self
		modificarWithNombre: unNombre
		andApellido: unApellido
		andTelefono: unTelefono
		andContraseña:unaContra.
	nombreUsuario := unNombreUsuario
	"	nombre := unNombre.
	apellido := unApellido.
	telefono := unTelefono"
]

{ #category : #accessing }
Chofer >> nombreCompleto [
^nombre,' ',apellido,': ',nombreUsuario 
]

{ #category : #accessing }
Chofer >> pertenezcoAlViaje: unviaje [
	^ false
]

{ #category : #'as yet unclassified' }
Chofer >> soy [
^'chofer'
]

{ #category : #accessing }
Chofer >> telefono [ 
^telefono 
]
