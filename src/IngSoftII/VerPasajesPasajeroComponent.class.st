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
VerPasajesPasajeroComponent >> calcularDevolucion: unPasaje [
	(unPasaje viaje fecha - Date today) asDays >= 2
		ifTrue: [ ^ 'Se devolverá el 100% del valor del pasaje: $'
				, unPasaje precio asString ]
		ifFalse: [ ^ 'Se devolverá el 50% del valor del pasaje: $'
				, (unPasaje precio / 2) asString ]
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
	| cancelados pendientes |
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
	"	self renderPasajesOn: aCanvas"
	pasajes
		ifNotEmpty:
			[ "((pasajes reject: [ :pasaje | pasaje estado = 'pendiente' ])
				sort: [ :pasajeA :pasajeB | pasajeA viaje fecha < pasajeB viaje fecha ])"
			aCanvas heading
				level: 4;
				with: 'Pendientes: '.
			pendientes := (pasajes
				reject: [ :pasaje | pasaje estado = 'cancelado' ])
				sort: [ :pasajeA :pasajeB | pasajeA viaje fecha < pasajeB viaje fecha ].
			pendientes ifEmpty: [ aCanvas text: 'No hay pasajes pendientes.' ].
			self renderOn: aCanvas pasajes: pendientes.
			aCanvas heading
				level: 4;
				with: 'Cancelados: '.
			cancelados := (pasajes
				reject: [ :pasaje | pasaje estado = 'pendiente' ])
				sort: [ :pasajeA :pasajeB | pasajeA viaje fecha < pasajeB viaje fecha ].
			cancelados ifEmpty: [ aCanvas text: 'No hay pasajes cancelados.' ].
			self renderOn: aCanvas pasajes: cancelados ] .aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]

{ #category : #rendering }
VerPasajesPasajeroComponent >> renderOn: aCanvas pasajes: unosPasajes [
	| insumosSinRepetir |
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ unosPasajes
						do: [ :each | 
							"aCanvas horizontalRule."
							"
					aCanvas submitButton
						callback: [ self answer ];
						with: 'Volver' ] "
							aCanvas
								listItem: [ aCanvas
										paragraph: [ "aCanvas strong: each estado.
											aCanvas space."
											aCanvas
												big:
													each viaje ruta lugarOrigen nombre , ' a '
														, each viaje ruta lugarDestino nombre.
											aCanvas break.
											aCanvas
												text: 'El dia: ' , each fecha printString , ', ' , each viaje horario printString.
											aCanvas break.
											aCanvas
												text: 'Cantidad de pasajes comprados: ' , each cantidad printString.
											aCanvas break.
											aCanvas text: 'Insumos comprados: '.
											each insumos
												ifEmpty: [ insumosSinRepetir := OrderedCollection new.
													aCanvas text: 'No se compraron insumos'.
													aCanvas break ]
												ifNotEmpty: [ " insumosSinRepetir := each insumos asSet."
													aCanvas
														unorderedList: [ each insumos
																do: [ :insumo | 
																	aCanvas
																		listItem: [ aCanvas text: insumo nombre , ' x' , insumo cantidad asString ].
																	aCanvas break ] ] ].
											aCanvas text: 'Precio total: $' , each precio asString.
											aCanvas space.
											each estado = 'pendiente'
												ifTrue: [ aCanvas break.
													aCanvas submitButton
														callback: [ self cancelarPasaje: each ];
														with: 'Cancelar pasaje'.
													aCanvas space.
													aCanvas small: (self calcularDevolucion: each) ].
											aCanvas break.
											aCanvas horizontalRule ] ] ] ] ]
]

{ #category : #rendering }
VerPasajesPasajeroComponent >> renderPasajesOn: aCanvas [
	| insumosSinRepetir |
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
											aCanvas
												text: 'Cantidad de pasajes:' , each cantidad printString.
											aCanvas break.
											aCanvas text: 'Insumos comprados: '.
											each insumos
												ifNil: [ insumosSinRepetir:=OrderedCollection new.aCanvas text: 'No se compraron insumos'.
													aCanvas break ]
												ifNotNil: [ insumosSinRepetir := each insumos asSet.
													aCanvas
														unorderedList: [ insumosSinRepetir
																do: [ :insumo | 
																	aCanvas
																		listItem: [ aCanvas
																				text:
																					insumo nombre , ' x'
																						, (each insumos occurrencesOf: insumo) printString ].
																	aCanvas break ] ] ].
											aCanvas text: 'Precio total: $' , each precio asString.
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
