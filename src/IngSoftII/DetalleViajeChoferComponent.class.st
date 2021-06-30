Class {
	#name : #DetalleViajeChoferComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'mensaje',
		'pasajeros',
		'estados'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
DetalleViajeChoferComponent class >> newWithViaje: unViaje [
	^self new initializeWithViaje: unViaje
]

{ #category : #initialization }
DetalleViajeChoferComponent >> habilitadoAViajar [
	estados
		detect: [ :estado | estado = ' ' or: (estado = 'Cancelado') ]
		ifFound: [ ^ false ]
		ifNone: [ ^ true ]
]

{ #category : #initialization }
DetalleViajeChoferComponent >> iniciarViaje [
	pasajeros
		do: [ :pasajero | 
			pasajero
				conCondicion: (estados at: (pasajeros indexOf: pasajero))
				viajarA: viaje ].
	viaje iniciar.
	self answer."
	self
		call:
			(VerViajesChoferComponent
				newWithViajes: (Sistema soleInstance obtenerViajesChofer: self session user))"
]

{ #category : #initialization }
DetalleViajeChoferComponent >> initializeVector [
	1 to: estados size do: [ :index | estados at: index put: ' ' ]
]

{ #category : #initialization }
DetalleViajeChoferComponent >> initializeWithViaje: unViaje [
	super initialize.
	viaje := unViaje.
	pasajeros := Sistema soleInstance obtenerPasajerosViaje: unViaje.
	mensaje := ' '.
	estados := Array new: pasajeros size.
	self initializeVector
]

{ #category : #initialization }
DetalleViajeChoferComponent >> registrarAusente: unPasajero [
	estados at: (pasajeros indexOf: unPasajero) put: 'Ausente'.
	unPasajero conCondicion: 'Ausente'  viajarA: viaje
]

{ #category : #initialization }
DetalleViajeChoferComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas heading
		level: 2;
		with:
			'Viaje: ' , viaje ruta lugarOrigen nombre , ' - '
				, viaje ruta lugarDestino nombre , ' ' , viaje horario asString.
	aCanvas heading
		level: 3;
		with:
			'Total pasajeros: ' , viaje cantidadVendidos asString
				, ' pasajes disponibles: '
				, viaje cantidadAsientosDisponibles asString.
	viaje cantidadAsientosDisponibles > 0 & (viaje estado = 'pendiente')&
													((DateAndTime now - viaje fechaCompleta) abs
														<=
															(Duration
																days: 0
																hours: 0
																minutes: 15
																seconds: 0))
		ifTrue: [ aCanvas
				form: [ aCanvas submitButton
						callback: [  ];
						with: 'Vender pasaje' ] ].
	aCanvas heading
		level: 4;
		with: mensaje.
	pasajeros
		ifEmpty: [ aCanvas heading
				level: 4;
				with: 'No hay pasajeros en este viaje' ]
		ifNotEmpty: [ aCanvas heading
				level: 4;
				with: 'Pasajeros: '.
			self renderOn: aCanvas Pasajeros: pasajeros ].
	aCanvas
		form: [ self habilitadoAViajar
				ifTrue: [ aCanvas submitButton
						callback: [ self iniciarViaje ];
						with: 'Iniciar Viaje' ].
			aCanvas space.
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]

{ #category : #initialization }
DetalleViajeChoferComponent >> renderOn: aCanvas Pasajeros: unosPasajeros [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ pasajeros
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas big: each nombreCompleto.
											aCanvas space.
											'Cancelado' = (estados at: (pasajeros indexOf: each))
												ifFalse: [ aCanvas space.aCanvas strong: (estados at: (pasajeros indexOf: each)) asString.
													((estados at: (pasajeros indexOf: each))
														includesSubstring: 'Rechazado'
														caseSensitive: false)
														ifTrue: [ aCanvas space.
															aCanvas
																small: 'Se le devolvera el 100% del valor del pasaje' ] ].
											aCanvas break.
											aCanvas text: 'DNI: ' , each dni.
											aCanvas space.
											"aCanvas break."
											viaje estado = 'pendiente'
												&
													((DateAndTime now - viaje fechaCompleta) abs
														<=
															(Duration
																days: 0
																hours: 0
																minutes: 15
																seconds: 0))
												ifTrue: [ aCanvas break.
													aCanvas submitButton
														callback: [ estados
																at: (pasajeros indexOf: each)
																put: (self call: (RegistrarSintomasComponent newWithUser: each)) ];
														with: 'Registrar síntomas'.
													aCanvas space.
													aCanvas submitButton
														callback: [ self registrarAusente: each ];
														with: 'Registrar ausente'.
													aCanvas break ].
											aCanvas space.
											aCanvas horizontalRule ] ] ] ] ]
]
