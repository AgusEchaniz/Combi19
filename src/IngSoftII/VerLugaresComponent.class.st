Class {
	#name : #VerLugaresComponent,
	#superclass : #WAComponent,
	#instVars : [
		'localidad',
		'provincia',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #lugar }
VerLugaresComponent >> eliminarLugar:unLugar [
Sistema soleInstance eliminarLugar: unLugar
]

{ #category : #rendering }
VerLugaresComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	self renderLugaresOn: aCanvas
]

{ #category : #rendering }
VerLugaresComponent >> renderLugaresOn: aCanvas [
	| lugares |
	lugares := Sistema soleInstance lugares.
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ lugares
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each localidad.
											aCanvas space.
											aCanvas text: each provincia.
											"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarLugar: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self
														call: (LugarComponent newWithObjetivo: 'modificar' andLugar: each) ];
												with: 'Modificar' ].
									aCanvas break.
									aCanvas break ] ] ].
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]
