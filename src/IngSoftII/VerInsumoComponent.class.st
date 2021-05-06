Class {
	#name : #VerInsumoComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombre',
		'tipo',
		'precio',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #insumo }
VerInsumoComponent >> eliminarInsumo: unInsumo [
	Sistema soleInstance eliminarInsumo: unInsumo 
]

{ #category : #'as yet unclassified' }
VerInsumoComponent >> modificarInsumo: unInsumo [
	
]

{ #category : #rendering }
VerInsumoComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	self renderInsumosOn: aCanvas
	
]

{ #category : #rendering }
VerInsumoComponent >> renderInsumosOn: aCanvas [
	| insumos |
	insumos := Sistema soleInstance insumos.
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ insumos
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each nombre.
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarInsumo: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self
														call: (InsumoComponent
														newWithObjetivo: 'modificar'
														andInsumo: each) ];
												with: 'Modificar' ].
									aCanvas break.
									aCanvas break ] ] ].
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]
