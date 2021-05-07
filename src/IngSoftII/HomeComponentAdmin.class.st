Class {
	#name : #HomeComponentAdmin,
	#superclass : #HomeComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
HomeComponentAdmin >> renderContentOn: aCanvas [
	super renderContentOn: aCanvas.
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self call: InsumoComponent new ];
				with: [ aCanvas button: 'Agregar insumo' ].
			aCanvas anchor
				callback: [ self call: ChoferComponent new ];
				with: [ aCanvas button: 'Agregar chofer' ].
			aCanvas anchor
				callback: [ self call: VerViajesComponent new ];
				with: [ aCanvas button: 'Agregar viaje' ].
			aCanvas anchor
				callback: [ self call: PasajeroComponent new ];
				with: [ aCanvas button: 'Ver usuarios' ].
			aCanvas anchor
				callback: [ self call: VerInsumoComponent new ];
				with: [ aCanvas button: 'Ver insumos' ].
			aCanvas anchor
				callback: [ self call: VerChoferComponent new ];
				with: [ aCanvas button: 'Ver choferes' ] ]
]
