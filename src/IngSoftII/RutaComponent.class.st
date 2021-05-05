Class {
	#name : #RutaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'ruta'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #initialization }
RutaComponent >> initializeWithRuta: unaRuta [
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
