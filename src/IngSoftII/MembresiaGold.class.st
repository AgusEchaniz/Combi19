Class {
	#name : #MembresiaGold,
	#superclass : #Membresia,
	#instVars : [
		'fechaInicio'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'as yet unclassified' }
MembresiaGold >> descuento [
]

{ #category : #accessing }
MembresiaGold >> fechaInicio [
^fechaInicio 
]

{ #category : #initialization }
MembresiaGold >> initialize [
	nombre := 'gold'.
	fechaInicio :=Date today.
]
