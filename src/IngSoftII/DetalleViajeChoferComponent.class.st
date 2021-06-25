Class {
	#name : #DetalleViajeChoferComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'mensaje',
		'pasajeros'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
DetalleViajeChoferComponent class >> newWithViaje: unViaje [
	^self new initializeWithViaje: unViaje
]

{ #category : #initialization }
DetalleViajeChoferComponent >> initializeWithViaje: unViaje [
	super initialize.
	viaje := unViaje.
	pasajeros := Sistema soleInstance obtenerPasajerosViaje: unViaje.
	mensaje := ' '
]

{ #category : #initialization }
DetalleViajeChoferComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
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
	viaje cantidadAsientosDisponibles > 0
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
		form: [ aCanvas submitButton
				callback: [  ];
				with: 'Iniciar Viaje'.
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
										paragraph: [ aCanvas
												big: each nombreCompleto.
											aCanvas break.
											aCanvas
												text: 'DNI: ' , each dni.
											aCanvas break.
											aCanvas space.
											aCanvas break.
											aCanvas submitButton
												callback: [  ];
												with: 'Registrar síntomas'.
											aCanvas space.
											aCanvas submitButton
												callback: [  ];
												with: 'Registrar ausente'.
											aCanvas space.
											aCanvas break.
											aCanvas horizontalRule ] ] ] ] ]
]
