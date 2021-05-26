Class {
	#name : #ViajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'ruta',
		'fecha',
		'cantidadAsientos',
		'objetivo',
		'viaje',
		'mensaje',
		'cantidadMaximaAsientos',
		'precio',
		'usarRutaActual'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
ViajeComponent class >> newWithObjetivo:unObjetivo andViaje: unViaje [
^self new initializeWithObjetivo: unObjetivo  andViaje: unViaje 
]

{ #category : #rendering }
ViajeComponent >> agregarViaje [
	precio
		ifNil: [ mensaje := 'Por favor ingrese un precio'.
			^ self ].
	fecha
		ifNil: [ mensaje := 'Por favor ingrese una fecha'.
			^ self ].
	(fecha isBefore: Date today)
		ifTrue: [ mensaje := 'Por favor ingrese una fecha actual o posterior'.
			^ self ].
	cantidadAsientos
		ifEmpty: [ mensaje := 'Por favor ingrese una cantidad'.
			^ self ].
	ruta
		ifNil: [ mensaje := 'Por favor seleccione una ruta'.
			^ self ].
	cantidadAsientos asInteger > cantidadMaximaAsientos asInteger
		ifTrue: [ "FALTA MÉTODO DEL SISTEMA CREAR VIAJE"
			mensaje := 'La cantidad de asientos ingresada es mayor a la capacidad máxima de la combi, como máximo ingrese: '
				, ruta cantidadAsientosDeLaCombi asString.
			^ self ].
	(Sistema soleInstance
		crearViajeWithRuta: ruta
		andFecha: fecha
		andCantidadAsientos: cantidadAsientos
		andPrecio: precio)
		ifNil:
			[ mensaje := 'Ya existe un viaje en esa fecha con esa ruta registrado'.
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
	fecha := Date today.
	mensaje := ' '.
	objetivo := 'agregar'.
	
]

{ #category : #initialization }
ViajeComponent >> initializeWithObjetivo: unObjetivo andViaje: unViaje [
	super initialize.
	objetivo := unObjetivo.
	viaje := unViaje.
	mensaje := ' '.
	fecha := unViaje fecha.
	ruta := unViaje ruta.
	cantidadAsientos := unViaje cantidadAsientos.
	precio := unViaje precio.
	usarRutaActual :=false.
]

{ #category : #rendering }
ViajeComponent >> model [
	^ Sistema soleInstance 
]

{ #category : #'as yet unclassified' }
ViajeComponent >> modificarViaje [
	fecha
		ifNil: [ mensaje := 'Por favor ingrese una fecha'.
			^ self ].
	(fecha isBefore: Date today)
		ifTrue: [ mensaje := 'Por favor ingrese una fecha válida'.
			^ self ].
	cantidadAsientos
		ifEmpty: [ mensaje := 'Por favor ingrese una cantidad'.
			^ self ].
	ruta
		ifNil: [ mensaje := 'Por favor seleccione una ruta'.
			^ self ].
	cantidadAsientos asInteger > ruta cantidadAsientosDeLaCombi asInteger
		ifTrue:
			[ mensaje := 'La cantidad de asientos ingresada es mayor a la capacidad máxima de la combi, como máximo ingrese: '
				, ruta cantidadAsientosDeLaCombi asString.
			^ self ].
	usarRutaActual
		ifTrue: [ self ruta: viaje ruta ].
	"(Sistema soleInstance rutas
		select: [ :unaRuta | self model canBeRuta: unaRuta enFecha: fecha ])
		ifEmpty: [ ruta := viaje ruta ]."
	ruta = viaje ruta & (fecha = viaje fecha)
		ifFalse: [ (Sistema soleInstance
				modificarViaje: viaje
				withRuta: ruta
				andFecha: fecha
				andCantidadAsientos: cantidadAsientos
				andPrecio: precio)
				ifNil:
					[ mensaje := 'Ya existe un viaje en esa fecha con esa ruta registrado'.
					^ self ] ]
		ifTrue: [ Sistema soleInstance
				modificarViaje: viaje
				withCantidadAsientos: cantidadAsientos
				andPrecio: precio ].
	self answer
]

{ #category : #accessing }
ViajeComponent >> precio [
	^ precio
]

{ #category : #accessing }
ViajeComponent >> precio: anObject [
	precio := anObject
]

{ #category : #rendering }
ViajeComponent >> renderButtonsOn: aCanvas [
	objetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarViaje ];
				with: 'Agregar viaje' ]
		ifFalse: [ aCanvas submitButton
				callback: [ self modificarViaje ];
				with: 'Modificar viaje' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
ViajeComponent >> renderCantAsientos: aCanvas [
	aCanvas paragraph: 'Ingrese cantidad de asientos'.
	aCanvas paragraph: [ aCanvas textInput on: #cantidadAsientos of: self ]
]

{ #category : #rendering }
ViajeComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ self renderFecha: aCanvas.
			aCanvas horizontalRule.
			self renderRutasOn: aCanvas.
			aCanvas horizontalRule.
			self renderCantAsientos: aCanvas.
			aCanvas horizontalRule.
			self renderPrecioOn:aCanvas.
			aCanvas horizontalRule.
			self renderButtonsOn: aCanvas ]
]

{ #category : #rendering }
ViajeComponent >> renderFecha: aCanvas [
	aCanvas paragraph: 'Ingrese fecha del viaje  mes/día/año'.
	"	aCanvas paragraph: [ aCanvas textInput on: #fecha of: self ]"
	(aCanvas dateInput options: #(day month year)) on: #fecha of: self
]

{ #category : #rendering }
ViajeComponent >> renderPrecioOn: aCanvas [
		aCanvas paragraph: 'Ingrese el precio'.
	aCanvas
		paragraph: [ aCanvas textInput on: #precio of: self ]
]

{ #category : #rendering }
ViajeComponent >> renderRutasDisponibles: rutas on: aCanvas [
	| rutasDisponibles |
	rutasDisponibles := rutas
		select: [ :unaRuta | self model canBeRuta: unaRuta enFecha: fecha ].
	rutasDisponibles
		ifEmpty: [ aCanvas
				paragraph: 'No hay rutas disponibles para la fecha seleccionada.' ].
	objetivo = 'modificar'
		ifTrue: [ aCanvas
				paragraph: [ aCanvas paragraph: 'Ruta actual: ' , viaje obtenerNombreRuta.
					aCanvas submitButton
						callback: [ usarRutaActual :=true ];
						with: 'Seleccionar ruta actual' ] ].
	aCanvas
		unorderedList: [ rutasDisponibles
				do: [ :each | 
					"					(self model canBeRuta: each enFecha: fecha)"
					"						ifTrue: ["
					aCanvas
						listItem: [ aCanvas text: each nombre.
							aCanvas space.
							aCanvas submitButton
								callback: [ self ruta: each ];
								with: 'Agregar ruta' ] ] ]
]

{ #category : #rendering }
ViajeComponent >> renderRutasOn: aCanvas [
	| rutas |
	aCanvas paragraph: 'RUTAS DISPONIBLES: '.
	rutas := Sistema soleInstance rutas.
	rutas
		ifEmpty: [ aCanvas paragraph: 'Lo sentimos.. No hay rutas disponibles'. objetivo = 'modificar'
						ifTrue: [ aCanvas paragraph: 'Ruta actual: ' , viaje ruta nombre ] ]
		ifNotEmpty: [ self renderRutasDisponibles: rutas on: aCanvas ]
]

{ #category : #accessing }
ViajeComponent >> ruta [
	^ ruta
]

{ #category : #accessing }
ViajeComponent >> ruta: anObject [
	ruta := anObject.
	self setearMaximoAsientos: anObject 
]

{ #category : #'as yet unclassified' }
ViajeComponent >> setearMaximoAsientos: unaRuta [
cantidadMaximaAsientos:= unaRuta cantidadAsientosDeLaCombi .
]

{ #category : #accessing }
ViajeComponent >> usarRutaActual [
usarRutaActual:=true.
]
