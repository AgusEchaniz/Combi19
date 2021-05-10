Class {
	#name : #Ruta,
	#superclass : #Object,
	#instVars : [
		'lugarOrigen',
		'lugarDestino',
		'combi',
		'horario',
		'distancia'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Ruta class >> newWithLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	^ self new
		initializeWithLugarOrigen: unLugarOrigen
		andLugarDestino: unLugarDestino
		andCombi: unaCombi
		andHorario: unHorario
		andDistancia: unaDistancia
]

{ #category : #'as yet unclassified' }
Ruta >> cantidadAsientosDeLaCombi [
^combi cantidadAsientos 
]

{ #category : #accessing }
Ruta >> combi [
	^ combi
]

{ #category : #accessing }
Ruta >> distancia [
	^ distancia
]

{ #category : #accessing }
Ruta >> horario [
	^ horario
]

{ #category : #'as yet unclassified' }
Ruta >> incluyeLugar: unLugar [
	lugarOrigen = unLugar
		ifFalse: [ lugarDestino = unLugar
				ifFalse: [ ^ false ] ].^true
]

{ #category : #initialization }
Ruta >> initializeWithLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	lugarOrigen := unLugarOrigen.
	lugarDestino := unLugarDestino.
	combi := unaCombi.
	horario := unHorario.
	distancia := unaDistancia
]

{ #category : #accessing }
Ruta >> lugarDestino [
	^ lugarDestino
]

{ #category : #accessing }
Ruta >> lugarOrigen [
	^ lugarOrigen
]

{ #category : #initialization }
Ruta >> modificarCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	combi := unaCombi.
	horario := unHorario.
	distancia := unaDistancia
]

{ #category : #initialization }
Ruta >> modificarRutaWithLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	lugarOrigen := unLugarOrigen.
	lugarDestino := unLugarDestino.
	combi := unaCombi.
	horario := unHorario.
	distancia := unaDistancia
]

{ #category : #accessing }
Ruta >> nombre [
	^ lugarOrigen nombre , ' - ' , lugarDestino nombre,' ',horario asString
]

{ #category : #'as yet unclassified' }
Ruta >> tieneCombi: unaCombi [
^combi=unaCombi 
]

{ #category : #accessing }
Ruta >> tieneHorario: unHorario [
	^(horario = unHorario)
]

{ #category : #'as yet unclassified' }
Ruta >> tieneOrigen: unLugarOrigen andUnDestino: unLugarDestino andHorario: unHorario [
	^ ((unLugarOrigen = lugarOrigen) & (unLugarDestino = lugarDestino)
		& (unHorario = horario))
]
