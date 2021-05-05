Class {
	#name : #Viaje,
	#superclass : #Object,
	#instVars : [
		'ruta',
		'fecha',
		'cantidadAsientos'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'as yet unclassified' }
Viaje >> tieneRuta: unaRuta enFecha: unaFecha [
^ruta=unaRuta and fecha=unaFecha
]
