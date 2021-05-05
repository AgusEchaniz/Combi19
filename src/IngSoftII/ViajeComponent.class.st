Class {
	#name : #ViajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'ruta',
		'fecha',
		'cantidadAsientos'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
ViajeComponent >> agregarViaje [
	fecha ifNil: [ ^ self ].
	fecha = Date today ifTrue:[^self].
	cantidadAsientos ifEmpty: [ ^ self ].
	ruta ifEmpty: [ ^ self ]
]

{ #category : #accessing }
ViajeComponent >> cantidadAsientos [
	^ cantidadAsientos
]

{ #category : #accessing }
ViajeComponent >> cantidadAsientos: anObject [
	cantidadAsientos := anObject
]

{ #category : #accessing }
ViajeComponent >> fecha [
	^ fecha
]

{ #category : #accessing }
ViajeComponent >> fecha: anObject [
	fecha := anObject asDate
]

{ #category : #accessing }
ViajeComponent >> initialize [
super initialize.
fecha:= Date today
]

{ #category : #rendering }
ViajeComponent >> model [
	^ Sistema soleInstance 
]

{ #category : #rendering }
ViajeComponent >> renderButtonsOn: aCanvas [
	aCanvas anchor
		callback: [ self agregarViaje ];
		with: [ aCanvas button: 'Agregar viaje' ].
			aCanvas anchor
		callback: [ self answer  ];
		with: [ aCanvas button: 'Cancelar' ].
		
]

{ #category : #rendering }
ViajeComponent >> renderCantAsientos: aCanvas [
	aCanvas paragraph: 'Ingrese cantidad de asientos'.
	aCanvas paragraph: [ aCanvas textInput on: #cantidadAsientos of: self ]
]

{ #category : #rendering }
ViajeComponent >> renderContentOn: aCanvas [
	
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas horizontalRule.
	self renderFecha: aCanvas.
	aCanvas horizontalRule.
	self renderRutasOn: aCanvas.
	aCanvas horizontalRule.
	self renderCantAsientos: aCanvas.
	self renderButtonsOn: aCanvas
]

{ #category : #rendering }
ViajeComponent >> renderFecha: aCanvas [
	aCanvas paragraph: 'Ingrese fecha del viaje  mes/día/año'.
	aCanvas paragraph: [ aCanvas textInput on: #fecha of: self ]
]

{ #category : #rendering }
ViajeComponent >> renderRutas: rutas on: aCanvas [
	^ aCanvas
		unorderedList: [ rutas
				do: [ :each | 
					(self model canBeRuta: each enFecha: fecha)
						ifTrue: [ aCanvas
								listItem: [ aCanvas anchor
										callback: [ self call: (RutaComponent newWithRuta: each) ];
										with: each nombre.
									aCanvas anchor
										callback: [ self ruta: each ];
										with: [ aCanvas button: 'Agregar ruta' ] ] ] ] ]
]

{ #category : #rendering }
ViajeComponent >> renderRutasOn: aCanvas [
	| rutas |
	aCanvas paragraph: 'RUTAS DISPONIBLES: '.
	rutas := Sistema soleInstance rutas.
	rutas
		ifEmpty: [ aCanvas paragraph: 'Lo sentimos.. No hay rutas disponibles' ]
		ifNotEmpty: [ self renderRutas: rutas on: aCanvas ].

]

{ #category : #accessing }
ViajeComponent >> ruta [
	^ ruta
]

{ #category : #accessing }
ViajeComponent >> ruta: anObject [
	ruta := anObject
]
