Class {
	#name : #VerCombisComponent,
	#superclass : #WAComponent,
	#instVars : [
		'patente',
		'tipo',
		'cantidadAsientos',
		'chofer',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #combi }
VerCombisComponent >> eliminarCombi:unaCombi [
	Sistema soleInstance eliminarCombi: unaCombi
]

{ #category : #rendering }
VerCombisComponent >> renderCombisOn: aCanvas [
	| combis |
	combis := Sistema soleInstance combis .
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ combis
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each patente .
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarCombi: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self
														call:
															(CombiComponent newWithObjetivo: 'modificar' andCombi: each) ];
												with: 'Modificar' ].
									aCanvas break.
									aCanvas break ] ] ].
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]

{ #category : #rendering }
VerCombisComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	self renderCombisOn: aCanvas
]
