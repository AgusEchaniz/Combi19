Class {
	#name : #Pasaje,
	#superclass : #Object,
	#instVars : [
		'viaje',
		'cantidad',
		'estado'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Pasaje class >> newWithViaje:unViaje andCantidad:unaCantidad [
^self new initializeWithViaje:unViaje andCantidad:unaCantidad
]

{ #category : #initialization }
Pasaje >> cancelarPasaje [
estado:='cancelado'
]

{ #category : #initialization }
Pasaje >> initializeWithViaje: unViaje andCantidad: unaCantidad [
viaje:=unViaje .
cantidad:=unaCantidad .
estado:='pendiente'.
]
