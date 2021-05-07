Class {
	#name : #Insumo,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'tipo',
		'precio'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Insumo class >> newWithNombre:unNombre andTipo:unTipo andPrecio:unPrecio [
^self new initializeWithNombre:unNombre andTipo:unTipo andPrecio:unPrecio
]

{ #category : #'as yet unclassified' }
Insumo >> es: unNombre [
^nombre includesSubstring: unNombre caseSensitive: false
]

{ #category : #initialization }
Insumo >> initializeWithNombre: unNombre
		andTipo: unTipo
		andPrecio: unPrecio [
		
	nombre:= unNombre .
	tipo:=unTipo .
	precio:= unPrecio 
]

{ #category : #'as yet unclassified' }
Insumo >> modificarWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio [
	self modificarWithTipo: unTipo andPrecio: unPrecio.
	nombre := unNombre.
"	tipo := unTipo.
	precio := unPrecio"
]

{ #category : #'as yet unclassified' }
Insumo >> modificarWithTipo: unTipo andPrecio: unPrecio [

	tipo := unTipo.
	precio := unPrecio
]

{ #category : #accessing }
Insumo >> nombre [
^nombre
]

{ #category : #accessing }
Insumo >> precio [ ^precio
]

{ #category : #accessing }
Insumo >> tipo [ ^tipo
]
