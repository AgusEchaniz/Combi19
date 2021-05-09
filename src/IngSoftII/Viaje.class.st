Class {
	#name : #Viaje,
	#superclass : #Object,
	#instVars : [
		'ruta',
		'fecha',
		'cantidadAsientos',
		'cantidadVendidos'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Viaje class >> newWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos [
	^ self new initializeWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos
]

{ #category : #'as yet unclassified' }
Viaje >> cantidadVendidos [
	^cantidadVendidos 
]

{ #category : #accessing }
Viaje >> fecha [ ^fecha
]

{ #category : #'as yet unclassified' }
Viaje >> incluyeRuta: unaRuta [
	^(ruta = unaRuta)
]

{ #category : #'as yet unclassified' }
Viaje >> initializeWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos [
	ruta := unaRuta.
	fecha := unaFecha.
	cantidadAsientos := unaCantidadAsientos.
	cantidadVendidos := 0
]

{ #category : #accessing }
Viaje >> nombre [
	^ ruta nombre , ' - ' , fecha asString
]

{ #category : #'as yet unclassified' }
Viaje >> obtenerNombreRuta [
^ruta nombre
]

{ #category : #'as yet unclassified' }
Viaje >> tieneFecha:unaFecha [ 
^fecha=unaFecha 
]

{ #category : #'as yet unclassified' }
Viaje >> tieneRuta: unaRuta enFecha: unaFecha [
^ruta=unaRuta & fecha=unaFecha
]
