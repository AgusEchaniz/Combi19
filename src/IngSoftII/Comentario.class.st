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

{ #category : #initialization }
Comentario >> initializeWithUsuario: unUsuario andContenido: unContenido [

usuario:=unUsuario .
contenido:=unContenido

]
