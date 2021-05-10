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

{ #category : #'as yet unclassified' }
VerCombisComponent >> chquearVacio [
| combis |
combis := Sistema soleInstance combis.
combis ifEmpty: [ mensaje :='No existen combis cargadas en el sistema.' ].
]

{ #category : #combi }
VerCombisComponent >> eliminarCombi: unaCombi [
	(Sistema soleInstance eliminarCombi: unaCombi)
		ifFalse:
			[ mensaje := 'No se pudo eliminar la combi porque está asignada a una ruta' ]
]

{ #category : #rendering }
VerCombisComponent >> renderCombisOn: aCanvas [
	| combis |
	combis := Sistema soleInstance combis.
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ combis
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each nombre.
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarCombi: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self
														call: (CombiComponent newWithObjetivo: 'modificar' andCombi: each) ];
												with: 'Modificar' ].
									aCanvas break ] ] ].
			aCanvas horizontalRule.
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]

{ #category : #rendering }
VerCombisComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 2;
		with: 'Combis: '.
	self chquearVacio.
aCanvas heading
		level: 4;
		with: mensaje.	self renderCombisOn: aCanvas
]
