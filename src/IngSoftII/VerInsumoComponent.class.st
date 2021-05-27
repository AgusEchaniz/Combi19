Class {
	#name : #VerInsumoComponent,
	#superclass : #WAComponent,
	#instVars : [
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'as yet unclassified' }
VerInsumoComponent >> chequearVacio [
| insumos |
	insumos := Sistema soleInstance insumos.
	insumos
		ifEmpty: [ mensaje := 'No hay insumos cargados en el sistema.' ].
]

{ #category : #insumo }
VerInsumoComponent >> eliminarInsumo: unInsumo [
	Sistema soleInstance eliminarInsumo: unInsumo 
]

{ #category : #initialization }
VerInsumoComponent >> initialize [ 
super initialize .
mensaje:=' '.
]

{ #category : #rendering }
VerInsumoComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self andHome: HomeComponentAdmin new).
	aCanvas heading
		level: 2;
		with: 'Insumos: '.
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
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
														call: (InsumoComponent newWithObjetivo: 'modificar' andInsumo: each) ];
												with: 'Modificar' ].
									aCanvas break.
									aCanvas break ] ] ].
			aCanvas horizontalRule .
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]
