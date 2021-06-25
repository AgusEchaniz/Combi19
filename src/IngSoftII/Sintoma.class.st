Class {
	#name : #Sintoma,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'estado'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
Sintoma class >> newWithNombre:unNombre [ 
^self new initializeWithNombre:unNombre
]

{ #category : #'as yet unclassified' }
Sintoma >> cambiarEstado:aValue [
estado:=aValue.
]

{ #category : #'as yet unclassified' }
Sintoma >> es:unNombre [
^nombre=unNombre
]

{ #category : #accessing }
Sintoma >> estado [
^estado
]

{ #category : #initialization }
Sintoma >> initializeWithNombre: unNombre [

nombre:=unNombre .
estado:=false
]
