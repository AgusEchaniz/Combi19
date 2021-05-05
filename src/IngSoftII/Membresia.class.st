Class {
	#name : #Membresia,
	#superclass : #Object,
	#instVars : [
		'nombre'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'as yet unclassified' }
Membresia >> descuento [
self subclassResponsibility 
]

{ #category : #accessing }
Membresia >> nombre [
^nombre
]
