Class {
	#name : #ComprarPasajeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'cantidadAsientos',
		'insumos',
		'cantidadInsumo',
		'total'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
ComprarPasajeComponent class >> newWithViaje:unViaje [
^self new initializeWithViaje:unViaje
]

{ #category : #accessing }
ComprarPasajeComponent >> cantidadAsientos:unaCantidad [
cantidadAsientos :=unaCantidad
]

{ #category : #accessing }
ComprarPasajeComponent >> cantidadInsumo:unaCantidad [
 cantidadInsumo:=unaCantidad 
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> comprarPasaje [
	viaje venderPasaje: cantidadAsientos
]

{ #category : #initialization }
ComprarPasajeComponent >> initializeWithViaje: unViaje [
viaje:=unViaje.
insumos:=OrderedCollection new
]

{ #category : #'as yet unclassified' }
ComprarPasajeComponent >> insumo: unInsumo [
	insumos add: unInsumo.
	total:= unInsumo precio *cantidadInsumo
]

{ #category : #rendering }
ComprarPasajeComponent >> renderButtonsOn: aCanvas [
	self session user membresia nombre = 'gold'
		ifTrue: [ aCanvas submitButton
				callback: [ self comprarPasaje ];
				with: 'Pagar con tarjeta cargada' ].
	aCanvas submitButton
		callback: [ self call: (TarjetaComponent newWithUser: self session user).
			self comprarPasaje ];
		with: 'Comprar pasaje'.
		

 aCanvas submitButton
				callback: [ self answer ];
				with: 'Cancelar' .
]

{ #category : #rendering }
ComprarPasajeComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ (aCanvas select list: (1 to: viaje cantidadAsientosDisponibles))
				on: #cantidadAsientos
				of: self.
			self renderInsumosOn: aCanvas.
			self session user membresia nombre = 'basico'
				ifTrue: [ aCanvas paragraph: 'Total: ' , viaje precio * cantidadAsientos+total ]
				ifFalse: [ aCanvas
						paragraph:(
							('Total: ' , (viaje precio * cantidadAsientos))
								- (10 * viaje precio * cantidadAsientos / 100) )+total].
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
									aCanvas textInput on: #cantidadInsumo of: self.
									aCanvas submitButton
										callback: [ self insumo: each ];
										with: 'Seleccionar'.
									aCanvas break ] ] ] ]
]
