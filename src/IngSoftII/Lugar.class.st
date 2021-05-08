Class {
	#name : #Lugar,
	#superclass : #Object,
	#instVars : [
		'localidad',
		'provincia'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Lugar class >> newWithLocalidad: unaLocalidad andProvincia: unaProvincia [
 ^self new initializeWithLocalidad: unaLocalidad andProvincia: unaProvincia
]

{ #category : #initialization }
Lugar >> initializeWithLocalidad: unaLocalidad andProvincia: unaProvincia [
localidad :=unaLocalidad .
provincia :=unaProvincia 
]

{ #category : #accessing }
Lugar >> localidad [
^localidad 
]

{ #category : #accessing }
Lugar >> localidad:unaLocalidad [
localidad:=unaLocalidad
]

{ #category : #'as yet unclassified' }
Lugar >> localidadEs:unaLocalidad [
	^localidad = unaLocalidad 
]

{ #category : #'as yet unclassified' }
Lugar >> modificarWithLocalidad: unaLocalidad andProvincia: unaProvincia [
	localidad := unaLocalidad .
	provincia:= unaProvincia .

]

{ #category : #'as yet unclassified' }
Lugar >> modificarWithProvincia: unaProvincia [
	provincia := unaProvincia
]

{ #category : #accessing }
Lugar >> nombre [
	^self localidad,' ',self provincia
]

{ #category : #accessing }
Lugar >> provincia [
	^ provincia
]

{ #category : #accessing }
Lugar >> provincia:unaProvincia [
provincia:=unaProvincia
]

{ #category : #'as yet unclassified' }
Lugar >> provinciaEs: unaProvincia [
	^ provincia  = unaProvincia 
]
