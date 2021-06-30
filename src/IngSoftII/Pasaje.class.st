Class {
	#name : #Pasaje,
	#superclass : #Object,
	#instVars : [
		'viaje',
		'cantidad',
		'estado',
		'precio',
		'insumos'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Pasaje class >> newWithViaje:unViaje andCantidad:unaCantidad [
^self new initializeWithViaje:unViaje andCantidad:unaCantidad
]

{ #category : #'instance creation' }
Pasaje class >> newWithViaje: unViaje andCantidad: unaCantidad  andPrecio: unPrecio [
	^ self new initializeWithViaje: unViaje andCantidad: unaCantidad  andPrecio: unPrecio
]

{ #category : #'instance creation' }
Pasaje class >> newWithViaje: unViaje andCantidad: unaCantidad andPrecio: unPrecio andInsumos:unosInsumos [
	^ self new
		initializeWithViaje: unViaje
		andCantidad: unaCantidad
		andPrecio: unPrecio
		andInsumos:unosInsumos
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
Pasaje >> iniciarPasaje [
	estado := 'En curso'
]

{ #category : #initialization }
Pasaje >> initializeWithViaje: unViaje andCantidad: unaCantidad [
viaje:=unViaje .
cantidad:=unaCantidad .
estado:='pendiente'.
]

{ #category : #initialization }
Pasaje >> initializeWithViaje: unViaje andCantidad: unaCantidad andPrecio:unPrecio [
	viaje := unViaje.
	cantidad := unaCantidad.
	estado := 'pendiente'.
	precio:=unPrecio
]

{ #category : #initialization }
Pasaje >> initializeWithViaje: unViaje andCantidad: unaCantidad andPrecio: unPrecio andInsumos:unosInsumos [
	viaje := unViaje.
	cantidad := unaCantidad.
	estado := 'pendiente'.
	precio := unPrecio.
	insumos :=unosInsumos
]

{ #category : #'as yet unclassified' }
Pasaje >> insumos [
^insumos
]

{ #category : #accessing }
Pasaje >> precio [
	^ precio
]

{ #category : #accessing }
Pasaje >> tieneViaje: unViaje [
	^self viaje = unViaje
]

{ #category : #accessing }
Pasaje >> viaje [
	^viaje
]
