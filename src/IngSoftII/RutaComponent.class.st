Class {
	#name : #RutaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'ruta',
		'objetivo'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
RutaComponent class >> newWithObjetivo:unObjetivo andRuta: unaRuta [
^self new initializeWithObjetivo:unObjetivo andRuta: unaRuta
]

{ #category : #initialization }
RutaComponent >> initializeWithObjetivo: unObjetivo andRuta: unaRuta [
objetivo:=unObjetivo .
ruta:=unaRuta
]

{ #category : #initialization }
RutaComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas paragraph: ruta lugarOrigen.
	aCanvas paragraph: ruta lugarDestino.
	aCanvas paragraph: ruta distancia.
	aCanvas paragraph: ruta horario.
	aCanvas paragraph: ruta combi patente
]
