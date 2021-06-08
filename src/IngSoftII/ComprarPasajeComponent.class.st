Class {
	#name : #ComprarPasajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'cantidadAsientos',
		'insumos',
		'cantidadInsumo',
		'total',
		'conTarjetaCargada'
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
	| pago |
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
	self session user agregarPasaje: (Pasaje newWithViaje: viaje andCantidad: cantidadAsientos).
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
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> insumo: unInsumo [
	insumos add: unInsumo.
	total := unInsumo precio asInteger * cantidadInsumo asInteger
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
				with: 'No hay insumos disponibles' ].
	aCanvas
		unorderedList: [ insumosAMostrar
				do: [ :each | 
					aCanvas
						listItem: [ aCanvas
								paragraph: [ aCanvas text: each nombre.
									aCanvas space.
									aCanvas textInput
										size: 1;
										on: #cantidadInsumo of: self.
									aCanvas space.
									aCanvas submitButton
										callback: [ self insumo: each ];
										with: 'Seleccionar'.
									aCanvas break ] ] ] ]
]
