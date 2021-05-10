Class {
	#name : #Combi,
	#superclass : #Object,
	#instVars : [
		'patente',
		'tipo',
		'chofer',
		'cantidadAsientos'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Combi class >> newWithPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantidad andChofer:unChofer [
	^ self new
		initializeWithPatente: unaPatente
		andTipo: unTipo
		andCantAsientos: unaCantidad
		andChofer:unChofer 
]

{ #category : #'as yet unclassified' }
Combi >> asignarChofer [
	chofer asignar
]

{ #category : #accessing }
Combi >> cantidadAsientos [
	^ cantidadAsientos
]

{ #category : #accessing }
Combi >> chofer [
	^ chofer
]

{ #category : #'as yet unclassified' }
Combi >> desasignarChofer [
	chofer desasignar 
]

{ #category : #initialization }
Combi >> initializeWithPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantidad andChofer: unChofer [
	patente := unaPatente.
	tipo := unTipo.
	cantidadAsientos := unaCantidad.
	chofer := unChofer.
	chofer asignar.

]

{ #category : #'as yet unclassified' }
Combi >> modificarWithPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantidad andChofer: unChofer [
	self
		modificarWithTipo: unTipo
		andCantAsientos: unaCantidad
		andChofer: unChofer.
	patente := unaPatente.

]

{ #category : #'as yet unclassified' }
Combi >> modificarWithTipo: unTipo andCantAsientos: unaCantidad andChofer: unChofer [
	chofer desasignar.
	tipo := unTipo.
	cantidadAsientos := unaCantidad.
	chofer:=unChofer.
	unChofer asignar
]

{ #category : #accessing }
Combi >> nombre [
	^ patente , ' - ' , tipo , ' - Cantidad de asientos:' , cantidadAsientos
]

{ #category : #accessing }
Combi >> patente [
	^ patente
]

{ #category : #'as yet unclassified' }
Combi >> tieneChofer: unChofer [
^chofer=unChofer
]

{ #category : #accessing }
Combi >> tipo [
	^ tipo
]
