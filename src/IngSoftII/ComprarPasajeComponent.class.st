Class {
	#name : #ComprarPasajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'cantidadAsientos',
		'insumos',
		'cantidadInsumo',
		'total',
		'conTarjetaCargada',
		'insumo'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
ComprarPasajeComponent class >> newWithViaje:unViaje [
^self new initializeWithViaje:unViaje
]

{ #category : #accessing }
ComprarPasajeComponent >> cantidadAsientos [
^	cantidadAsientos
]

{ #category : #accessing }
ComprarPasajeComponent >> cantidadAsientos:unaCantidad [
cantidadAsientos :=unaCantidad
]

{ #category : #accessing }
ComprarPasajeComponent >> cantidadInsumo [
^	cantidadInsumo
]

{ #category : #accessing }
ComprarPasajeComponent >> cantidadInsumo:unaCantidad [
 cantidadInsumo:=unaCantidad 
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> comprarPasaje [
	| pago totalPasaje |
	pago := true.
	conTarjetaCargada
		ifFalse: [ pago := self
				call:
					(TarjetaComponent
						newWithUser: self session user
						andReturn: HomeComponentPasajero) ].
	pago
		ifFalse: [ ^ self ].
	viaje venderPasaje: cantidadAsientos.
	totalPasaje := self setearTotalPasaje.
	self session user
		agregarPasaje:
			(Pasaje
				newWithViaje: viaje
				andCantidad: cantidadAsientos
				andPrecio: totalPasaje andInsumos:insumos).
	self answer
]

{ #category : #initialization }
ComprarPasajeComponent >> initializeWithViaje: unViaje [
	viaje := unViaje.
	insumos := OrderedCollection new.
	conTarjetaCargada := false.
	cantidadAsientos := 0.
	cantidadInsumo := 0.
	total := 0
	"	self session user cambiarMembresia"
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> insumo [
^	insumo 	"s add: unInsumo.
	total := unInsumo precio asInteger * unInsumo cantidad asInteger"
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> insumo: unInsumo [
	insumo:=unInsumo"s add: unInsumo.
	total := unInsumo precio asInteger * unInsumo cantidad asInteger"
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> insumo: unInsumo cantidad: unaCant [
	insumos
		detect: [ :i | i nombre = unInsumo nombre ]
		ifFound: [ :i | i agregar: unaCant ]
		ifNone: [ insumos
				add: (InsumoConCant newWithInsumo: unInsumo andUnaCantidad: unaCant) ].	"unInsumo withOccurrences: unaCant asInteger."
	total := total+unInsumo precio asInteger * unaCant asInteger
]

{ #category : #rendering }
ComprarPasajeComponent >> renderButtonsOn: aCanvas [
	self session user membresia nombre = 'gold'
		ifTrue: [ aCanvas submitButton
				callback: [ conTarjetaCargada := true ];
				with: 'Pagar con tarjeta cargada'.
			aCanvas break.
			aCanvas break ].
	aCanvas submitButton
		callback: [ self comprarPasaje ];
		with: 'Comprar pasaje'.
		aCanvas space.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
ComprarPasajeComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese la cantidad de pasajes a comprar'.
			(aCanvas select list: (1 to: viaje cantidadAsientosDisponibles))
				on: #cantidadAsientos
				of: self.
			aCanvas space.
			aCanvas submitButton
				callback: [ self cantidadAsientos ];
				with: 'Seleccionar'.
			aCanvas space.
			aCanvas small: '$' , viaje precio asString , ' por pasaje'.
			self renderInsumosOn: aCanvas.
			self session user membresia nombre = 'basico'
				ifTrue: [ aCanvas
						paragraph:
							'Total: '
								,
									(viaje precio asInteger * cantidadAsientos asInteger + total asInteger)
										printString ]
				ifFalse: [ aCanvas
						paragraph:
							'Total: '
								,
									(viaje precio asInteger * cantidadAsientos + total
										- (10 * (viaje precio asInteger * cantidadAsientos + total) / 100))
										printString ].
			self renderButtonsOn: aCanvas ]
]

{ #category : #rendering }
ComprarPasajeComponent >> renderInsumosOn: aCanvas [
	| insumosAMostrar |
	insumosAMostrar := Sistema soleInstance insumos.
	aCanvas paragraph: 'Seleccione los insumos que desea comprar'.
	insumosAMostrar
		ifEmpty: [ aCanvas heading
				level: 4;
				with: 'No hay insumos disponibles' ]
		ifNotEmpty: [ "	aCanvas
		unorderedList: [ insumosAMostrar
				do: [ :each | 
					aCanvas
						listItem: [ aCanvas
								paragraph: [ aCanvas text: each nombre.
									aCanvas space.
									self insumo: each cantidad: (aCanvas textInput size: 1).
									aCanvas space.
									aCanvas textInput
										size: 1;
										on: #cantidadInsumo of: self.
											on: (self insumo: each cantidad: self).

									aCanvas submitButton
										callback: [ self insumo: insumo ];
										with: 'Seleccionar'.
									aCanvas break ] ] ] ]"
			(aCanvas select
				list: insumosAMostrar;
				labels: [ :each | each nombreCompleto ]) on: #insumo of: self.
			aCanvas space.
			aCanvas textInput
				size: 1;
				on: #cantidadInsumo of: self.
			aCanvas space.
			aCanvas submitButton
				callback: [ self insumo: insumo cantidad: cantidadInsumo ];
				with: 'Agregar' ]
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> setearTotalPasaje [
	self session user membresia nombre = 'basico'
		ifTrue: [ ^ viaje precio asInteger * cantidadAsientos asInteger
				+ total asInteger ]
		ifFalse: [ ^ viaje precio asInteger * cantidadAsientos + total
				- (10 * (viaje precio asInteger * cantidadAsientos + total) / 100) ]
]
