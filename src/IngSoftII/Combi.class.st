Class {
	#name : #Combi,
	#superclass : #Object,
	#instVars : [
		'patente',
		'tipo',
		'chofer',
		'cantidadAsientos'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Combi class >> newWithPatente:unaPatente andTipo:unTipo andCantAsientos: unaCantidad [
^ self new
		initializeWithPatente:unaPatente andTipo:unTipo andCantAsientos: unaCantidad
]

{ #category : #accessing }
Combi >> cantidadAsientos [
	^ cantidadAsientos
]

{ #category : #accessing }
Combi >> chofer [
	^ chofer
]

{ #category : #initialization }
Combi >> initializeWithPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantidad [
patente:=unaPatente.
tipo:=unTipo.
cantidadAsientos :=unaCantidad 
	
]

{ #category : #'as yet unclassified' }
Combi >> modificarWithPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantidad [
	patente := unaPatente.
	tipo := unTipo.
	cantidadAsientos  := unaCantidad
]

{ #category : #accessing }
Combi >> patente [
	^ patente
]

{ #category : #accessing }
Combi >> tipo [
	^ tipo
]
