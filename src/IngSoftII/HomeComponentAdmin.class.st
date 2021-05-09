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
				with: [ aCanvas button: 'Agregar Insumo' ].
			aCanvas anchor
				callback: [ self call: ChoferComponent new ];
				with: [ aCanvas button: 'Agregar Chofer' ].
			aCanvas anchor
				callback: [ self call: LugarComponent new ];
				with: [ aCanvas button: 'Agregar Lugar' ].
			aCanvas anchor
				callback: [ self call: CombiComponent new ];
				with: [ aCanvas button: 'Agregar Combi' ].
			aCanvas anchor
				callback: [ self call: RutaComponent new ];
				with: [ aCanvas button: 'Agregar Ruta' ].
			aCanvas anchor
				callback: [ self call: ViajeComponent new ];
				with: [ aCanvas button: 'Agregar Viaje' ].

			aCanvas anchor
				callback: [ self call: VerInsumoComponent new ];
				with: [ aCanvas button: 'Ver Insumos' ].
			aCanvas anchor
				callback: [ self call: VerChoferComponent new ];
				with: [ aCanvas button: 'Ver Choferes' ].
			aCanvas anchor
				callback: [ self call: VerLugaresComponent new ];
				with: [ aCanvas button: 'Ver Lugares' ].
			aCanvas anchor
				callback: [ self call: VerCombisComponent new ];
				with: [ aCanvas button: 'Ver Combis' ].
			aCanvas anchor
				callback: [ self call: VerRutaComponent new ];
				with: [ aCanvas button: 'Ver Rutas' ].
			aCanvas anchor
				callback: [ self call: VerViajesComponent new ];
				with: [ aCanvas button: 'Ver Viajes' ].
			aCanvas anchor
				callback: [ self call: PasajeroComponent new ];
				with: [ aCanvas button: 'Ver Usuarios' ] ].
	aCanvas horizontalRule
]
