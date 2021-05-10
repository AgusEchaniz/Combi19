Class {
	#name : #RutaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'ruta',
		'objetivo',
		'mensaje',
		'lugarOrigen',
		'lugarDestino',
		'hora',
		'minuto',
		'combi',
		'distancia',
		'horario',
		'usarCombiActual'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
RutaComponent class >> newWithObjetivo:unObjetivo andRuta: unaRuta [
^self new initializeWithObjetivo:unObjetivo andRuta: unaRuta
]

{ #category : #initialization }
RutaComponent >> agregarRuta [
	lugarOrigen ifNil: [ ^ self ].
	lugarDestino ifNil: [ ^ self ].
	hora ifNil: [ ^ self ].
	minuto ifNil: [ ^ self ].
	combi
		ifNil: [ 
			^ self ].
	distancia ifEmpty: [ ^ self ].
	lugarDestino = lugarOrigen
		ifTrue: [ mensaje := 'El lugar de origen y de destino no pueden ser iguales'.
			^ self ].
	(Sistema soleInstance
		crearRutaWithLugarOrigen: lugarOrigen
		andLugarDestino: lugarDestino
		andCombi: combi
		andHorario: horario
		andDistancia: distancia)
		ifNil:
			[ mensaje := 'Ya existe Ruta con el mismo lugar de partida, de origen y mismo horario'.
			^ self ].
	self answer
]

{ #category : #initialization }
RutaComponent >> combi [
	^combi
	
]

{ #category : #initialization }
RutaComponent >> combi: unaCombi [
	combi := unaCombi
	
]

{ #category : #initialization }
RutaComponent >> distancia [
	^distancia
]

{ #category : #initialization }
RutaComponent >> distancia: unaDistancia [
	distancia := unaDistancia
]

{ #category : #initialization }
RutaComponent >> hora [
	^hora
]

{ #category : #initialization }
RutaComponent >> hora: unaHora [
hora := unaHora
]

{ #category : #initialization }
RutaComponent >> horario [
	^ horario
]

{ #category : #initialization }
RutaComponent >> horario:unHorario [
horario:= unHorario
]

{ #category : #initialization }
RutaComponent >> initialize [
	super initialize.
	mensaje := ' '.
	objetivo := 'agregar'.
	hora := 0.
	minuto := 0.
]

{ #category : #initialization }
RutaComponent >> initializeWithObjetivo: unObjetivo andRuta: unaRuta [
	super initialize.
	mensaje := ''.
	objetivo := unObjetivo.
	ruta := unaRuta.
	lugarOrigen := unaRuta lugarOrigen.
	lugarDestino := unaRuta lugarDestino.
	horario := unaRuta horario.
	hora := unaRuta horario hour24.
	minuto := unaRuta horario minute.
	combi := unaRuta combi nombre.
	distancia:=unaRuta distancia
]

{ #category : #initialization }
RutaComponent >> lugarDestino [
	^ lugarDestino
]

{ #category : #initialization }
RutaComponent >> lugarDestino: unLugar [
	lugarDestino := unLugar
]

{ #category : #initialization }
RutaComponent >> lugarOrigen [
	^lugarOrigen 
]

{ #category : #initialization }
RutaComponent >> lugarOrigen: unLugar [
	lugarOrigen := unLugar
]

{ #category : #initialization }
RutaComponent >> minuto [
	^minuto
]

{ #category : #initialization }
RutaComponent >> minuto: unosMinutos [
	minuto := unosMinutos
]

{ #category : #initialization }
RutaComponent >> modificarRuta [
	lugarOrigen ifNil: [ ^ self ].
	lugarDestino ifNil: [ ^ self ].
	hora ifNil: [ ^ self ].
	minuto ifNil: [ ^ self ].
	(Sistema soleInstance combisDisponiblesEnHorario: horario)
		ifEmpty: [ combi := ruta combi ].
	 usarCombiActual
		ifTrue: [ self combi: ruta combi ].
	combi ifNil: [ ^ self ].
	distancia ifEmpty: [ ^ self ].
	lugarDestino = lugarOrigen
		ifTrue: [ mensaje := 'El lugar de origen y de destino no pueden ser iguales'.
			^ self ].
	ruta lugarOrigen = lugarOrigen & (ruta lugarDestino = lugarDestino)
		ifFalse: [ (Sistema soleInstance
				modificarRuta: ruta
				withLugarOrigen: lugarOrigen
				andLugarDestino: lugarDestino
				andCombi: combi
				andHorario: horario
				andDistancia: distancia)
				ifNil:
					[ mensaje := 'Ya existe Ruta con el mismo lugar de partida, de origen, misma combi y mismo horario'.
					^ self ] ]
		ifTrue: [ Sistema soleInstance
				modificarRuta: ruta
				withCombi: combi
				andHorario: horario
				andDistancia: distancia ].
	self answer
]

{ #category : #initialization }
RutaComponent >> renderButtonsOn: aCanvas para: unObjetivo [
	unObjetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarRuta ];
				with: 'Agregar' ]
		ifFalse: [ aCanvas submitButton
				callback: [ self modificarRuta ];
				with: 'Modificar' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #initialization }
RutaComponent >> renderCombisOn: aCanvas [
	aCanvas paragraph: 'Seleccione la combi'.
	(aCanvas select
		list:
			(Sistema soleInstance
				combisDisponiblesEnHorario: (hora asString , ':' , minuto asString) asTime);
		labels: [ :each | each nombre ]) on: #combi of: self.
]

{ #category : #initialization }
RutaComponent >> renderContentOn: aCanvas [
	| combisDisponibles |
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 4;
		with: mensaje.
	combisDisponibles := Sistema soleInstance
		combisDisponiblesEnHorario: horario.
	aCanvas
		form: [ aCanvas paragraph: 'Seleccione el lugar de partida de la ruta'.
			Sistema soleInstance lugares
				ifNotEmpty: [ (aCanvas select
						list: Sistema soleInstance lugares;
						labels: [ :each | each nombre ]) on: #lugarOrigen of: self ]
				ifEmpty: [ aCanvas heading
						level: 4;
						with: 'No hay lugares registrados en el sistema' ].
			aCanvas break.
			aCanvas paragraph: 'Seleccione el lugar de llegada de la ruta'.
			Sistema soleInstance lugares
				ifNotEmpty: [ (aCanvas select
						list: Sistema soleInstance lugares;
						labels: [ :each | each nombre ]) on: #lugarDestino of: self ]
				ifEmpty: [ aCanvas heading
						level: 4;
						with: 'No hay lugares registrados en el sistema' ].
			aCanvas horizontalRule.
			aCanvas paragraph: 'Seleccione la hora'.
			aCanvas timeInput on: #horario of: self.
			"		(aCanvas select list: (0 to: 23)) on: #hora of: self.
			aCanvas paragraph: 'Seleccione los minutos'.
			(aCanvas select list: (0 to: 59)) on: #minuto of: self."
			aCanvas horizontalRule.
			objetivo = 'modificar'
				ifTrue: [ aCanvas
						paragraph: [ aCanvas paragraph: 'Combi actual: ' , ruta combi nombre.
							aCanvas submitButton
								callback: [ self usarCombiActual ];
								with: 'Seleccionar combi actual' ] ].
			aCanvas paragraph: 'Seleccione la combi nueva'.
			combisDisponibles
				ifEmpty: [ aCanvas
						paragraph: 'No hay combis disponibles para el horario seleccionado' ]
				ifNotEmpty: [ (aCanvas select
						list: (Sistema soleInstance combisDisponiblesEnHorario: horario);
						labels: [ :each | each nombre ]) on: #combi of: self ].
			aCanvas break.
			aCanvas horizontalRule.
			aCanvas paragraph: 'Ingrese la distancia del viaje'.
			aCanvas textArea on: #distancia of: self.
			aCanvas break.
			aCanvas horizontalRule.
			self renderButtonsOn: aCanvas para: objetivo ]
]

{ #category : #accessing }
RutaComponent >> usarCombiActual [
usarCombiActual:=true
]
