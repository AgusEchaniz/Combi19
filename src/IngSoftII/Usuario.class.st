Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombreUsuario',
		'contraseña',
		'nombre',
		'apellido'
	],
	#category : #'IngSoftII-model'
}

{ #category : #accessing }
Usuario >> contraseña [
	^ contraseña
]

{ #category : #'as yet unclassified' }
Usuario >> es: unNombreDeUsuario [
^nombreUsuario includesSubstring: unNombreDeUsuario  caseSensitive: false
]

{ #category : #initialization }
Usuario >> initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido [
		
	nombreUsuario :=unNombreDeUsuario .
	contraseña :=unaContraseña .
	nombre :=unNombre .
	apellido:=unApellido 
]

{ #category : #accessing }
Usuario >> nombreUsuario [
^nombreUsuario
]
