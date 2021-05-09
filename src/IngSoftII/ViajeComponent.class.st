Class {
	#name : #ViajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'ruta',
		'fecha',
		'cantidadAsientos',
		'objetivo',
		'viaje',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
ViajeComponent class >> newWithObjetivo:unObjetivo andViaje: unViaje [
^self new initializeWithObjetivo: unObjetivo  andViaje: unViaje 
]

{ #category : #rendering }
ViajeComponent >> agregarViaje [
	fecha ifNil: [ ^ self ].
	fecha = Date today
		ifTrue: [ ^ self ].
	cantidadAsientos ifEmpty: [ ^ self ].
	ruta ifEmpty: [ ^ self ].
	(Sistema soleInstance
		crearViajeWithRuta: ruta
		andFecha: fecha
		andCantidadAsientos: cantidadAsientos)
		ifNil: [ mensaje := 'Ya existe viaje con esos datos registrado'.
			^ self ].
	self answer
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

{ #category : #initialization }
ViajeComponent >> initializeWithObjetivo: unObjetivo andViaje: unViaje [
super initialize.
	objetivo := unObjetivo.
	viaje := unViaje
]

{ #category : #rendering }
ViajeComponent >> model [
	^ Sistema soleInstance 
]

{ #category : #'as yet unclassified' }
ViajeComponent >> modificarViaje [
	fecha ifNil: [ ^ self ].
	fecha = Date today
		ifTrue: [ ^ self ].
	cantidadAsientos ifEmpty: [ ^ self ].
	ruta ifEmpty: [ ^ self ]
	"FALTA MÉTODO DEL SISTEMA CREAR VIAJE"
	ruta nombre = viaje obtenerNombreRuta
	"	ifFalse: [ (Sistema soleInstance
				modificarInsumo: insumo
				withNombre: nombre
				andTipo: tipo
				andPrecio: precio)
				ifNil: [ mensaje := 'Ya existe un insumo con ese nombre registrado'.
					^ self ] ]
		ifTrue: [ Sistema soleInstance
				modificarInsumo: insumo
				withTipo: tipo
				andPrecio: precio ]." "Cambiar por método modificar viaje"
	self answer
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
ViajeComponent >> renderRutasDisponibles: rutas on: aCanvas [
	^ aCanvas
		unorderedList: [ rutas
				do: [ :each | 
					(self model canBeRuta: each enFecha: fecha)
						ifTrue: [ aCanvas
								listItem: [ aCanvas text: each nombre.	"aCanvas anchor
										callback: [ self call: (RutaComponent newWithRuta: each) ];
										with: each nombre."
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
		ifNotEmpty: [ self renderRutasDisponibles: rutas on: aCanvas ]
]

{ #category : #accessing }
ViajeComponent >> ruta [
	^ ruta
]

{ #category : #accessing }
ViajeComponent >> ruta: anObject [
	ruta := anObject
]
