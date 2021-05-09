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

{ #category : #accessing }
Chofer >> nombreCompleto [
^nombre,' ',apellido,': ',nombreUsuario 
]

{ #category : #'as yet unclassified' }
Chofer >> soy [
^'chofer'
]

{ #category : #accessing }
Chofer >> telefono [ 
^telefono 
]
