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
		'distancia'
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
	combi ifNil: [ ^ self ].
	distancia ifEmpty: [ ^ self ].
	(Sistema soleInstance
		crearRutaWithLugarOrigen: lugarOrigen
		andLugarDestino: lugarDestino
		andCombi: combi
		andHorario: (hora asString , ':' , minuto asString) asTime
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
RutaComponent >> horario [ 	^hora
]

{ #category : #initialization }
RutaComponent >> initialize [
	super initialize.
	mensaje := ' '.
	objetivo := 'agregar'
]

{ #category : #initialization }
RutaComponent >> initializeWithObjetivo: unObjetivo andRuta: unaRuta [
	super initialize.
	mensaje := ''.
	objetivo := unObjetivo.
	ruta := unaRuta
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
	combi ifNil: [ ^ self ].
	distancia ifEmpty: [ ^ self ].
	(lugarOrigen nombre , ' - ' , lugarDestino nombre) = ruta nombre
		ifFalse: [ (Sistema soleInstance
				modificarRuta: ruta WithLugarOrigen: lugarOrigen
				andLugarDestino: lugarDestino
				andCombi: combi
				andHorario: (hora asString , ':' , minuto asString) asTime
				andDistancia: distancia)
				ifNil:
					[ mensaje := 'Ya existe Ruta con el mismo lugar de partida, de origen y mismo horario'.
					^ self ] ]
		ifTrue: [ Sistema soleInstance
				modificarRuta: ruta withCombi: combi
				andHorario: (hora asString , ':' , minuto asString) asTime
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
RutaComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 4;
		with: mensaje.
	hora := 0.
	minuto := 0.
	aCanvas
		form: [ aCanvas paragraph: 'seleccione el lugar de partida de la ruta'.
			(aCanvas select
				list: Sistema soleInstance lugares;
				labels: [ :each | each nombre ]) on: #lugarOrigen of: self.
			aCanvas break.
			aCanvas paragraph: 'Seleccione el lugar de llegada de la ruta'.
			(aCanvas select
				list: Sistema soleInstance lugares;
				labels: [ :each | each nombre ]) on: #lugarDestino of: self.
			aCanvas horizontalRule.
			aCanvas paragraph: 'Seleccione la hora'.
			(aCanvas select list: (0 to: 23)) on: #hora of: self.
			aCanvas paragraph: 'Seleccione los minutos'.
			(aCanvas select list: (0 to: 59)) on: #minuto of: self.
			aCanvas horizontalRule.
			aCanvas paragraph: 'Seleccione la combi'.
			(aCanvas select
				list:
					(Sistema soleInstance
						combisDisponiblesEnHorario: (hora asString , ':' , minuto asString) asTime);
				labels: [ :each | each nombre ]) on: #combi of: self.
			aCanvas break.
			aCanvas paragraph: 'Ingrese la distancia del viaje'.
			aCanvas textArea on: #distancia of: self.
			aCanvas break.
			aCanvas break.
			self renderButtonsOn: aCanvas para: objetivo ]
]
