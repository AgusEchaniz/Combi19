Class {
	#name : #Chofer,
	#superclass : #Usuario,
	#instVars : [
		'telefono'
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

{ #category : #initialization }
Chofer >> initializeWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andNombre: unNombre andApellido: unApellido andTelefono:unTelefono [
	self initialize
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido.
	telefono :=unTelefono 
]

{ #category : #modificar }
Chofer >> modificarWithNombre: unNombre
		andApellido: unApellido
		andTelefono: unTelefono [
	
	nombre := unNombre.
	apellido := unApellido.
	telefono := unTelefono
]

{ #category : #modificar }
Chofer >> modificarWithNombreUsuario: unNombreUsuario andNombre: unNombre andApellido: unApellido andTelefono: unTelefono [
	self modificarWithNombre: unNombre andApellido: unApellido  andTelefono: unTelefono .
	nombreUsuario := unNombreUsuario.
"	nombre := unNombre.
	apellido := unApellido.
	telefono := unTelefono"
]

{ #category : #'as yet unclassified' }
Chofer >> soy [
^'chofer'
]

{ #category : #accessing }
Chofer >> telefono [ 
^telefono 
]
