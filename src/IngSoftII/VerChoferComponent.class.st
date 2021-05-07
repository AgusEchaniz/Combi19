Class {
	#name : #VerChoferComponent,
	#superclass : #WAComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #chofer }
VerChoferComponent >> eliminarChofer: unChofer [
	Sistema soleInstance eliminarChofer: unChofer
]

{ #category : #rendering }
VerChoferComponent >> renderChoferesOn: aCanvas [
	| usuarios |
	usuarios := Sistema soleInstance usuarios.
	usuarios := usuarios select: [ :each | each soy = 'chofer' ].
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ usuarios
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each nombreUsuario.
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarChofer: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self call: (ChoferComponent newWithObjetivo:'modificar' andChofer: each) ];
												"InsumoComponent newWithObjetivo:'modificar'andInsumo: each"
													with: 'Modificar' ].
									aCanvas break.
									aCanvas break ] ] ].
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]

{ #category : #rendering }
VerChoferComponent >> renderContentOn: aCanvas [

	aCanvas paragraph: (BasicComponent newWithParent: self).
	self renderChoferesOn: aCanvas
]
