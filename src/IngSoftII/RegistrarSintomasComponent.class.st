Class {
	#name : #RegistrarSintomasComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sintomas',
		'temperatura',
		'mensaje',
		'usuario',
		'objetivo',
		'viaje'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
RegistrarSintomasComponent class >> newWithUser:unUsuario [
^self new initializeWithUser: unUsuario
]

{ #category : #'instance creation' }
RegistrarSintomasComponent class >> newWithUser: unUsuario
								andViaje: unViaje
								objetivo: unObjetivo [ 
								^self new initializeWithUser: unUsuario
								andViaje: unViaje
								objetivo: unObjetivo 
]

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
	mensaje := ''
]

{ #category : #initialization }
RegistrarSintomasComponent >> initializeWithUser: unUsuario [
	self initialize.
	usuario := unUsuario.
	objetivo:=''.
	viaje:=nil.
]

{ #category : #initialization }
RegistrarSintomasComponent >> initializeWithUser: unUsuario
		andViaje: unViaje
		objetivo: unObjetivo [
		
	usuario:=unUsuario .
	viaje:=unViaje .
	objetivo:=unObjetivo 
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> registrarSintomas [
	temperatura isNil | temperatura isEmpty ifTrue:
		 [ mensaje := 'Por favor ingrese la temperatura del pasajero'.
			^ self ]
		ifFalse: [ self registrarTemperatura ].
	temperatura asInteger < 36
		ifTrue: [ mensaje := 'La temperatura mínima es 36°'.
			^ self ].
	temperatura asInteger >= 38
		ifTrue: [ usuario rechazar.
			self answer: 'Rechazado por fiebre' ]
		ifFalse: [ (sintomas count: [ :sintoma | sintoma estado ]) >= 2
				ifTrue: [ usuario rechazar.
					self answer: 'Rechazado por sintomas' ]
				ifFalse: [ objetivo = ''
						ifTrue: [ self answer: 'Aceptado' ]
						ifFalse: [ self
								call:
									(VenderViajeComponent
										newWithViaje: viaje
										andPasajero: usuario
										andEstado: 'Aceptado') ] ] ]
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
	aCanvas submitButton
		callback: [ self registrarSintomas ];
		with: 'Aceptar'.
	 aCanvas submitButton
				callback: [ self answer: 'Cancelado' ];
				with: 'Cancelar' 
]

{ #category : #rendering }
RegistrarSintomasComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	"aCanvas
		table: [ "
	aCanvas heading
		level: 4;
		with: mensaje.
	usuario nombre
		ifNil: [ aCanvas big: usuario nombreUsuario ]
		ifNotNil: [ aCanvas big: usuario nombreCompleto ].
	aCanvas break.
	aCanvas break.
	aCanvas
		form: [ aCanvas text: ' Ingrese la temperatura del pasajero '.
			aCanvas textInput
				size: 1;
				on: #temperatura of: self.
			aCanvas space.
			aCanvas small: 'Min. 36°'.
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
			self renderButtonsOn: aCanvas ]
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> temperatura [
^	temperatura
]

{ #category : #'as yet unclassified' }
RegistrarSintomasComponent >> temperatura: unaTemperatura [
	temperatura:=unaTemperatura 
]
