Class {
	#name : #Tarjeta,
	#superclass : #Object,
	#instVars : [
		'numero',
		'codigoSeguridad',
		'fechaVencimiento',
		'nombre'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Tarjeta class >> newWithNumero:unNumero andCodigoSeguridad:unCodigo andFechaVencimiento:unaFecha andNombre:unNombre [
^self new initializeWithNumero:unNumero andCodigoSeguridad:unCodigo andFechaVencimiento:unaFecha andNombre:unNombre
]

{ #category : #'as yet unclassified' }
Tarjeta >> esNumeroValido: unNumero [
	^ (unNumero asInteger)asString size = 16
]

{ #category : #'as yet unclassified' }
Tarjeta >> estaVigente: unaFecha [
	^ unaFecha asDate isAfter: Date today
]

{ #category : #initialization }
Tarjeta >> initializeWithNumero: unNumero andCodigoSeguridad: unCodigo andFechaVencimiento: unaFecha andNombre: unNombre [
	(self
		puedeSerTarjetaWithNumero: unNumero
		andFechaVencimiento: unaFecha)
		ifTrue: [ numero := unNumero.
			codigoSeguridad := unCodigo.
			fechaVencimiento := unaFecha.
			nombre := unNombre ]
]

{ #category : #'as yet unclassified' }
Tarjeta >> puedeSerTarjetaWithNumero: unNumero andFechaVencimiento: unaFecha [
	(self esNumeroValido: unNumero)
		ifTrue: [ (self estaVigente: unaFecha) ifTrue: [ ^ true ] ].
	^ false
]
