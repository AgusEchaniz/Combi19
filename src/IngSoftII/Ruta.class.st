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
Ruta >> modificarRutaWithLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	lugarOrigen := unLugarOrigen.
	lugarDestino := unLugarDestino.
	combi := unaCombi.
	horario := unHorario.
	distancia := unaDistancia
]

{ #category : #accessing }
Ruta >> tieneHorario: unHorario [
	^(horario = unHorario)
]
