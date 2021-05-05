Class {
	#name : #Administrador,
	#superclass : #Usuario,
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Administrador class >> newWithNombreUsuario: unNombreDeUsuario andContraseña: unaContraseña andNombre: unNombre andApellido: unApellido [
	^ self new
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido
]

{ #category : #'as yet unclassified' }
Administrador >> soy [
	^'admin'
]
