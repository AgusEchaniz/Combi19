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
				callback: [ self call: LugarComponent new ];
				with: [ aCanvas button: 'Agregar lugar' ].
			aCanvas anchor
				callback: [ self call: CombiComponent new ];
				with: [ aCanvas button: 'Agregar combi' ].
			aCanvas anchor
				callback: [ self call: RutaComponent new ];
				with: [ aCanvas button: 'Agregar Ruta' ].
			aCanvas anchor
				callback: [ self call: ViajeComponent new ];
				with: [ aCanvas button: 'Agregar Viaje' ].
			aCanvas space.
			aCanvas space.
			aCanvas anchor
				callback: [ self call: VerViajesComponent new ];
				with: [ aCanvas button: 'Ver viajes' ].
			aCanvas anchor
				callback: [ self call: VerRutaComponent new ];
				with: [ aCanvas button: 'Ver Rutas' ].
			aCanvas anchor
				callback: [ self call: PasajeroComponent new ];
				with: [ aCanvas button: 'Ver usuarios' ].
			aCanvas anchor
				callback: [ self call: VerInsumoComponent new ];
				with: [ aCanvas button: 'Ver insumos' ].
			aCanvas anchor
				callback: [ self call: VerChoferComponent new ];
				with: [ aCanvas button: 'Ver choferes' ].
			aCanvas anchor
				callback: [ self call: VerLugaresComponent new ];
				with: [ aCanvas button: 'Ver lugares' ].
			aCanvas anchor
				callback: [ self call: VerCombisComponent new ];
				with: [ aCanvas button: 'Ver combis' ] ].
			aCanvas horizontalRule
]
