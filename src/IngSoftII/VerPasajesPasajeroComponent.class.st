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

{ #category : #'as yet unclassified' }
VerPasajesPasajeroComponent >> cancelarPasaje: unPasaje [
	unPasaje viaje devolverPasaje: unPasaje cantidad.
	unPasaje cancelarPasaje.
	(( unPasaje viaje fecha-Date today) ) asDays >= 2
		ifTrue: [ mensaje := 'Se ha devuelto el 100% del valor del pasaje' ]
		ifFalse: [ mensaje := 'Se ha devuelto el 50% del valor del pasaje' ]
]

{ #category : #utility }
VerPasajesPasajeroComponent >> chequearVacio [
	pasajes
		ifEmpty: [ mensaje := 'No se compraron pasajes.' ]
]

{ #category : #initialization }
VerPasajesPasajeroComponent >> initializeWithPasajes: unosPasajes [
	super initialize.
	pasajes := unosPasajes.
	mensaje:=''
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
												text:
													each viaje ruta lugarOrigen nombre , ' a '
														, each viaje ruta lugarDestino nombre.
											aCanvas break.
											aCanvas text: 'El dia: ' , each fecha printString.
											aCanvas break.
											aCanvas text: 'Precio: $' , each precio asString.
											aCanvas space.
											each estado = 'pendiente'
												ifTrue: [ aCanvas submitButton
														callback: [ self cancelarPasaje: each ];
														with: 'Cancelar pasaje' ].
											aCanvas break.
											aCanvas horizontalRule.
											aCanvas break ] ] ].
					"aCanvas horizontalRule."
					aCanvas submitButton
						callback: [ self answer ];
						with: 'Volver' ] ]
]
