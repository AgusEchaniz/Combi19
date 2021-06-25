Class {
	#name : #VerViajesChoferComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viajes',
		'mensaje',
		'pendientes',
		'enCurso',
		'cancelados',
		'finalizados'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
VerViajesChoferComponent class >> newWithViajes: pasajes [
	^ self new initializeWithViajes: pasajes
]

{ #category : #'as yet unclassified' }
VerViajesChoferComponent >> cancelarViaje: unViaje [
	mensaje := 'Se ha devuelto el 100% del valor del pasaje a los pasajeros'.
	unViaje cancelar.
]

{ #category : #initialization }
VerViajesChoferComponent >> chequearVacio [
	viajes ifEmpty: [ mensaje := 'No se asignaron viajes.' ]
]

{ #category : #initialization }
VerViajesChoferComponent >> initializeWithViajes: unosViajes [
	super initialize.
	viajes := unosViajes.
	pendientes := unosViajes
		select: [ :viaje | viaje estado = 'pendiente' ].
	enCurso := unosViajes select: [ :viaje | viaje estado = 'en curso' ].
	cancelados := unosViajes
		select: [ :viaje | viaje estado = 'Cancelado' ].
	finalizados := unosViajes
		select: [ :viaje | viaje estado = 'finalizado' ]
]

{ #category : #initialization }
VerViajesChoferComponent >> ordenarViajesPorFecha: unosViajes [
	^ unosViajes sort: [ :viaje1 :viaje2 | viaje1 fecha <= viaje2 fecha ]
]

{ #category : #initialization }
VerViajesChoferComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas heading
		level: 2;
		with: 'Viajes: '.
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	viajes
		ifNotEmpty: [ aCanvas heading
				level: 4;
				with: 'En Curso: '.
			enCurso ifEmpty: [ aCanvas text: 'No hay viajes en curso.' ].
			self
				renderOn: aCanvas
				viajes: (self ordenarViajesPorFecha: enCurso).
			aCanvas heading
				level: 4;
				with: 'Pendientes: '.
			pendientes ifEmpty: [ aCanvas text: 'No hay viajes pendientes.' ].
			self
				renderOn: aCanvas
				viajes: (self ordenarViajesPorFecha: pendientes).
			aCanvas heading
				level: 4;
				with: 'Finalizados: '.
			finalizados ifEmpty: [ aCanvas text: 'No hay viajes finalizados.' ].
			self
				renderOn: aCanvas
				viajes: (self ordenarViajesPorFecha: finalizados).
			aCanvas heading
				level: 4;
				with: 'Cancelados: '.
			cancelados ifEmpty: [ aCanvas text: 'No hay viajes cancelados.' ].
			self
				renderOn: aCanvas
				viajes: (self ordenarViajesPorFecha: cancelados) ].
	aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]

{ #category : #initialization }
VerViajesChoferComponent >> renderOn: aCanvas viajes: unosViajes [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ unosViajes
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas
												big: each ruta lugarOrigen nombre , ' a ' , each ruta lugarDestino nombre.
											aCanvas break.
											aCanvas
												text: 'El dia: ' , each fecha printString , ', ' , each horario printString.
											aCanvas break.
											aCanvas
												text: 'Cantidad de pasajeros: ' , each cantidadVendidos printString.
											aCanvas break.
											aCanvas space.
											each estado = 'pendiente'
												ifTrue: [ aCanvas break.
													aCanvas submitButton
														callback: [ self call: (DetalleViajeChoferComponent newWithViaje: each) ];
														with: 'ver viaje'.
													aCanvas space.
													(each fechaCompleta - DateAndTime now) asHours <= 24
														ifTrue: [ aCanvas submitButton
																callback: [ self cancelarViaje: each ];
																with: 'Cancelar viaje' ]ifFalse:[aCanvas small:'Si desea cancelar el viaje contacte al administrador'].
													aCanvas space ].
											aCanvas break.
											aCanvas horizontalRule ] ] ] ] ]
]
