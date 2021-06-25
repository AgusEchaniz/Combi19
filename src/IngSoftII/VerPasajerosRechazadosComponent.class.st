Class {
	#name : #VerPasajerosRechazadosComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje'
	],
	#category : #'IngSoftII-ui-Admin'
}

{ #category : #'instance creation' }
VerPasajerosRechazadosComponent class >> newWithViaje:unViaje [
^self new initializeWithViaje:unViaje
]

{ #category : #initialization }
VerPasajerosRechazadosComponent >> initializeWithViaje: unViaje [
	super initialize.
	viaje := unViaje
]

{ #category : #rendering }
VerPasajerosRechazadosComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentAdmin new).
	aCanvas heading
		level: 5;
		with: viaje nombre.
	aCanvas horizontalRule.
	aCanvas heading
		level: 2;
		with: 'Pasajeros rechazados del viaje: '.
	"	aCanvas horizontalRule."
	aCanvas break.
	viaje rechazados
		ifEmpty: [ aCanvas space.
			aCanvas big: 'No se rechazaron pasajeros en este viaje'.
			aCanvas break ]
		ifNotEmpty: [ self renderPasajerosOn: aCanvas ].
	aCanvas break.
	aCanvas horizontalRule.
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button: 'Volver' ]
]

{ #category : #rendering }
VerPasajerosRechazadosComponent >> renderPasajerosOn: aCanvas [
	^ aCanvas
		unorderedList: [ viaje rechazados
				do: [ :each | 
					aCanvas
								listItem: [ aCanvas text: each nombreCompleto.
									aCanvas space.	
									
									aCanvas break.
									aCanvas break.
									aCanvas break ] ] ] 
]
