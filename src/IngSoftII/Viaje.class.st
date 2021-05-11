Class {
	#name : #Viaje,
	#superclass : #Object,
	#instVars : [
		'ruta',
		'fecha',
		'cantidadAsientos',
		'cantidadVendidos',
		'pasajeros',
		'precio'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Viaje class >> newWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos andPrecio:unPrecio [
	^ self new
		initializeWithRuta: unaRuta
		andFecha: unaFecha
		andCantidadAsientos: unaCantidadAsientos andPrecio:unPrecio
]

{ #category : #accessing }
Viaje >> cantidadAsientos [
^cantidadAsientos
]

{ #category : #'as yet unclassified' }
Viaje >> cantidadVendidos [
	^cantidadVendidos 
]

{ #category : #rendering }
Viaje >> eliminarPasajero: unUsuario [ 
pasajeros remove:unUsuario ifAbsent:[]
]

{ #category : #accessing }
Viaje >> fecha [ ^fecha
]

{ #category : #'as yet unclassified' }
Viaje >> incluyeRuta: unaRuta [
	^(ruta = unaRuta)
]

{ #category : #'as yet unclassified' }
Viaje >> incluyenPasajero: unUsuario [
	^pasajeros includes: unUsuario
]

{ #category : #initialization }
Viaje >> initialize [ 
super initialize.
cantidadVendidos :=0.

]

{ #category : #'as yet unclassified' }
Viaje >> initializeWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos andPrecio:unPrecio [
	ruta := unaRuta.
	fecha := unaFecha.
	cantidadAsientos := unaCantidadAsientos.
	cantidadVendidos := 0.
	pasajeros := OrderedCollection new.
	precio:=unPrecio 
]

{ #category : #'as yet unclassified' }
Viaje >> modificarViajeWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos andPrecio: unPrecio [
	ruta := unaRuta.
	fecha := unaFecha.
	cantidadAsientos := unaCantidadAsientos.

	precio := unPrecio
]

{ #category : #'as yet unclassified' }
Viaje >> modificarWithCantidadAsientos: unaCantidadAsientos andPrecio:unPrecio [
	cantidadAsientos := unaCantidadAsientos.
	precio:=unPrecio
]

{ #category : #accessing }
Viaje >> nombre [
	^ ruta nombre , ' - ' , fecha asString
		, ' - Cantidad de pasajes vendidos: ' , cantidadVendidos asString
]

{ #category : #'as yet unclassified' }
Viaje >> obtenerNombreRuta [
^ruta nombre
]

{ #category : #accessing }
Viaje >> precio [ 
^precio
]

{ #category : #accessing }
Viaje >> ruta [
^ruta
]

{ #category : #'as yet unclassified' }
Viaje >> tieneFecha:unaFecha [ 
^fecha=unaFecha 
]

{ #category : #'as yet unclassified' }
Viaje >> tieneRuta: unaRuta enFecha: unaFecha [
	^ ((ruta = unaRuta )& (fecha = unaFecha))
]
