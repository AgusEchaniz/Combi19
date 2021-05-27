Class {
	#name : #PasajeroComponent,
	#superclass : #WAComponent,
	#instVars : [
		'mensaje'
	],
	#category : #'IngSoftII-ui-Admin'
}

{ #category : #'as yet unclassified' }
PasajeroComponent >> chequearVacio [
	| usuarios |
	usuarios := Sistema soleInstance usuarios.
	usuarios := usuarios select: [ :each | each soy = 'pasajero' ].
	usuarios
		ifEmpty: [ mensaje := 'No existen usuarios pasajeros cargados en el sistema.' ]
]

{ #category : #rendering }
PasajeroComponent >> eliminarPasajero: unPasajero [
	Sistema soleInstance eliminarUsuario: unPasajero
]

{ #category : #initialization }
PasajeroComponent >> initialize [ 
super initialize.
mensaje:= ' '

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
	aCanvas paragraph: (BasicComponent newWithParent: self andHome: HomeComponentAdmin new).
	aCanvas heading
		level: 2;
		with: 'Usuarios: '.
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	self mostrarPasajeros: users on: aCanvas.
	aCanvas horizontalRule.
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button: 'Volver' ]
]
