Class {
	#name : #PasajeroComponent,
	#superclass : #WAComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
PasajeroComponent >> eliminarPasajero: unPasajero [
	Sistema soleInstance eliminarUsuario: unPasajero
]

{ #category : #'as yet unclassified' }
PasajeroComponent >> mostrarPasajero: each on: aCanvas [
aCanvas paragraph: each nombreUsuario.
	aCanvas paragraph: each nombre.
	aCanvas paragraph: each apellido.
	aCanvas paragraph: each fechaNac printString.
	aCanvas paragraph: each dni.
	aCanvas paragraph: each membresia nombre
]

{ #category : #'as yet unclassified' }
PasajeroComponent >> mostrarPasajeros: users on: aCanvas [
	^ aCanvas
		unorderedList: [ users
				do: [ :each | 
					(each es: 'pasajero')
						ifTrue: [ aCanvas
								listItem: [ aCanvas text: each nombreCompleto.	aCanvas space."aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
									aCanvas anchor
										callback: [ self eliminarPasajero: each ];
										with: [ aCanvas button: 'Eliminar' ].
									aCanvas break.
									aCanvas break.
									aCanvas break ] ] ] ]
]

{ #category : #rendering }
PasajeroComponent >> renderContentOn: aCanvas [
	| users |
	users := Sistema soleInstance usuarios.
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 3;
		with: 'Usuarios: '.
	self mostrarPasajeros: users on: aCanvas.
	aCanvas horizontalRule.
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button: 'Volver' ]
]
