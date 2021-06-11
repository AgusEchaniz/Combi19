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

{ #category : #accessing }
Pasaje >> cantidad [ ^cantidad
]

{ #category : #accessing }
Pasaje >> estado [
 ^estado
]

{ #category : #accessing }
Pasaje >> fecha [
	^viaje fecha
]

{ #category : #initialization }
Pasaje >> initializeWithViaje: unViaje andCantidad: unaCantidad [
viaje:=unViaje .
cantidad:=unaCantidad .
estado:='pendiente'.
]

{ #category : #accessing }
Pasaje >> precio [
	^ cantidad * viaje precio asInteger
]

{ #category : #accessing }
Pasaje >> viaje [
	^viaje
]
