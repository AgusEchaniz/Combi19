Class {
	#name : #VerViajesPasajeroComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viajes',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
VerViajesPasajeroComponent class >> newWithViajes: viajes [
	^ self new initializeWithViajes: viajes
]

{ #category : #'as yet unclassified' }
VerViajesPasajeroComponent >> chequearVacio [
	viajes
		ifEmpty: [ mensaje := 'No existen viajes cargados en el sistema.' ]
]

{ #category : #initialization }
VerViajesPasajeroComponent >> initializeWithViajes: unosViajes [
	super initialize.
	viajes := unosViajes
]

{ #category : #rendering }
VerViajesPasajeroComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas heading
		level: 2;
		with: 'Viajes: '.
	"aCanvas big: 'Viajes: '."
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	self renderViajesOn: aCanvas
]

{ #category : #rendering }
VerViajesPasajeroComponent >> renderViajesOn: aCanvas [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ viajes
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas
												strong: each ruta lugarOrigen nombre , ' a ' , each ruta lugarDestino nombre.
											aCanvas break.
											aCanvas text: 'El dia: ' , each fecha printString.
											aCanvas break.
											aCanvas
												text:
													'Asientos disponibles: '
														, each cantidadAsientosDisponibles printString.
											aCanvas break.
											aCanvas text: 'Precio: $' , each precio.
											aCanvas space.
											aCanvas submitButton
												callback: [ self call: (ComprarPasajeComponent newWithViaje: each) ];
												with: 'Comprar pasaje'.
											aCanvas break.
											aCanvas horizontalRule.
											aCanvas break ] ] ].
"					aCanvas horizontalRule."
					aCanvas submitButton
						callback: [ self answer ];
						with: 'Volver' ] ]
]
