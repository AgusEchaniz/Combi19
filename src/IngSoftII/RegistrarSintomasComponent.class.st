Class {
	#name : #RegistrarSintomasComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sintomas',
		'temperatura'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoGarganta [
	sintomas
		detect: [ :sintoma | sintoma es: 'Dolor de garganta' ]
		ifFound: [ :sintoma | ^sintoma estado ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoGarganta: aValue [
	sintomas detect:[:sintoma| sintoma es:'Dolor de garganta'] ifFound:[:sintoma|sintoma cambiarEstado: aValue]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoGusto [
	sintomas
		detect: [ :sintoma | sintoma es: 'Pérdida de gusto' ]
		ifFound: [ :sintoma | ^ sintoma estado ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoGusto: aValue [
	sintomas
		detect: [ :sintoma | sintoma es: 'Pérdida de gusto' ]
		ifFound: [ :sintoma | sintoma cambiarEstado: aValue ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoOlfato [
	sintomas
		detect: [ :sintoma | sintoma es: 'Pérdida de olfato' ]
		ifFound: [ :sintoma | ^ sintoma estado ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoOlfato: aValue [
	sintomas
		detect: [ :sintoma | sintoma es: 'Pérdida de olfato' ]
		ifFound: [ :sintoma | sintoma cambiarEstado: aValue ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoRespiratorio [
	sintomas
		detect: [ :sintoma | sintoma es: 'Dificultad respiratoria' ]
		ifFound: [ :sintoma | ^ sintoma estado ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoRespiratorio: aValue [
		sintomas
		detect: [ :sintoma | sintoma es: 'Dificultad respiratoria' ]
		ifFound: [ :sintoma | sintoma cambiarEstado: aValue ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoTos [
		sintomas
		detect: [ :sintoma | sintoma es: 'Tos' ]
		ifFound: [ :sintoma | ^ sintoma estado ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> estadoTos: aValue [
		sintomas
		detect: [ :sintoma | sintoma es: 'Tos' ]
		ifFound: [ :sintoma | sintoma cambiarEstado: aValue ]
]

{ #category : #initialization }
RegistrarSintomasComponent >> initialize [
	super initialize.
	sintomas := OrderedCollection new.
	sintomas add: (Sintoma newWithNombre: 'Tos').
	sintomas add: (Sintoma newWithNombre: 'Pérdida de olfato').
	sintomas add: (Sintoma newWithNombre: 'Pérdida de gusto').
	sintomas add: (Sintoma newWithNombre: 'Dolor de garganta').
	sintomas add: (Sintoma newWithNombre: 'Dificultad respiratoria').
	sintomas add: (Sintoma newWithNombre: 'Fiebre').
	"temperatura := ' '"
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> registrarSintomas [
	temperatura ifNil: [ ^ self ] ifNotNil: [ self registrarTemperatura ].
	temperatura asInteger >= 38
		ifTrue: [ self answer:'Rechazado por fiebre'] ifFalse:[(sintomas count:[:sintoma| sintoma estado])>=2 ifTrue:[self answer:'Rechazado por sintomas'] ifFalse:[self answer:'Aceptado']]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> registrarTemperatura [
	temperatura asInteger >= 38
		ifTrue: [sintomas
		detect: [ :sintoma | sintoma es: 'Fiebre' ]
		ifFound: [ :sintoma | sintoma cambiarEstado: true ]  ]
]

{ #category : #rendering }
RegistrarSintomasComponent >> renderButtonsOn: aCanvas [
aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas submitButton
				callback: [ self registrarSintomas ];
				with: 'Aceptar'.
			aCanvas submitButton
				callback: [ self answer: 'Cancelado' ];
				with: 'Cancelar' ]
]

{ #category : #rendering }
RegistrarSintomasComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	"aCanvas
		table: [ "
	aCanvas text: ' Ingrese la temperatura del pasajero '.
	aCanvas textInput
		size: 1;
		on: #temperatura of: self.
	aCanvas break.
	aCanvas break.
	aCanvas checkbox on: #estadoTos of: self.
	aCanvas text: ' El pasajero presenta tos '.
	aCanvas break.
	aCanvas checkbox on: #estadoOlfato of: self.
	aCanvas text: ' El pasajero presenta pérdida de olfato '.
	aCanvas break.
	aCanvas checkbox on: #estadoGusto of: self.
	aCanvas text: ' El pasajero presenta pérdida de gusto'.
	aCanvas break.
	aCanvas checkbox on: #estadoGarganta of: self.
	aCanvas text: ' El pasajero presenta dolor de garganta '.
	aCanvas break.
	aCanvas checkbox on: #estadoRespiratorio of: self.
	aCanvas text: ' El pasajero presenta dificultad respiratoria '.
	aCanvas break.

	"			aCanvas
				tableData: [ aCanvas text: ' El pasajero presenta tos '.
					aCanvas break.
					aCanvas text: ' El pasajero presenta pérdida de olfato '.
					aCanvas break.
					aCanvas text: ' El pasajero presenta pérdida de gusto'.
					aCanvas break.
					aCanvas text: ' El pasajero presenta dolor de garganta '.
					aCanvas break.
					aCanvas text: ' El pasajero presenta dificultad respiratoria '.
					aCanvas break.
					aCanvas text: ' Ingrese la temperatura del pasajero ' ].
			aCanvas
				tableData: [ aCanvas checkbox on: #estadoTos of: self.
					aCanvas break.
					aCanvas checkbox on: #estadoOlfato of: self.
					aCanvas break.
					aCanvas checkbox on: #estadoGusto of: self.
					aCanvas break.
					aCanvas checkbox on: #estadoGarganta of: self.
					aCanvas break.
					aCanvas checkbox on: #estadoRespiratorio of: self.
					aCanvas break.
					aCanvas textInput
						size: 1;
						on: #temperatura of: self ] ]."
	self renderButtonsOn: aCanvas
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> temperatura [
^	temperatura
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> temperatura: unaTemperatura [
	temperatura:=unaTemperatura 
]
