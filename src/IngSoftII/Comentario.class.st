Class {
	#name : #Comentario,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'contenido'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Comentario class >> newWithUsuario:unUsuario andContenido:unContenido [
^self new initializeWithUsuario:unUsuario andContenido:unContenido
]

{ #category : #usuario }
Comentario >> contenido [
	^ contenido
]

{ #category : #initialization }
Comentario >> initializeWithUsuario: unUsuario andContenido: unContenido [

usuario:=unUsuario .
contenido:=unContenido

]

{ #category : #usuario }
Comentario >> usuario [
	^ usuario
]
