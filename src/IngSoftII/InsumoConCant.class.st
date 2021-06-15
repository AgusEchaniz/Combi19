Class {
	#name : #InsumoConCant,
	#superclass : #Object,
	#instVars : [
		'insumo',
		'cant'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
InsumoConCant class >> newWithInsumo:unInsumo andUnaCantidad:unaCant [
^self new initializeWithInsumo:unInsumo andUnaCantidad:unaCant.
]

{ #category : #'as yet unclassified' }
InsumoConCant >> agregar: unaCant [
	cant := cant asInteger + unaCant asInteger
]

{ #category : #accessing }
InsumoConCant >> cantidad [ ^cant
]

{ #category : #initialization }
InsumoConCant >> initializeWithInsumo: unInsumo andUnaCantidad: unaCant [

insumo:=unInsumo .
cant:=unaCant
]

{ #category : #accessing }
InsumoConCant >> nombre [
^insumo nombre
]

{ #category : #accessing }
InsumoConCant >> precio [
^insumo precio
]
