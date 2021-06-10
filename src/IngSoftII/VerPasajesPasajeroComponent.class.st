Class {
	#name : #VerPasajesPasajeroComponent,
	#superclass : #WAComponent,
	#instVars : [
		'pasajes',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
VerPasajesPasajeroComponent class >> newWithPasajes: pasajes [
	^ self new initializeWithPasajes: pasajes
]

{ #category : #utility }
VerPasajesPasajeroComponent >> chequearVacio [
	pasajes
		ifEmpty: [ mensaje := 'No se compraron pasajes.' ]
]

{ #category : #initialization }
VerPasajesPasajeroComponent >> initializeWithPasajes: unosPasajes [
super initialize.
	pasajes  := unosPasajes
]

{ #category : #rendering }
VerPasajesPasajeroComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas heading
		level: 2;
		with: 'Pasajes: '.
	"aCanvas big: 'Viajes: '."
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	self renderPasajesOn: aCanvas
]

{ #category : #rendering }
VerPasajesPasajeroComponent >> renderPasajesOn: aCanvas [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ pasajes
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas strong: each estado.
											aCanvas space.
											aCanvas
												text: each ruta lugarOrigen nombre , ' a ' , each ruta lugarDestino nombre.
											aCanvas break.
											aCanvas text: 'El dia: ' , each fecha printString.
											aCanvas break.
											aCanvas text: 'Precio: $' , each precio.
											aCanvas break.
											aCanvas horizontalRule.
											aCanvas break ] ] ].
					"aCanvas horizontalRule."
					aCanvas submitButton
						callback: [ self answer ];
						with: 'Volver' ] ]
]
