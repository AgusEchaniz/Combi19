Class {
	#name : #VerComentarioComponent,
	#superclass : #WAComponent,
	#instVars : [
		'comentarios',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
VerComentarioComponent class >> newWithObjetivo: unObjetivo andComentario: unComentario [
	^ self new initializeWithObjetivo: unObjetivo andComentario: unComentario
]

{ #category : #utility }
VerComentarioComponent >> chequearVacio [
	comentarios
		ifEmpty: [ mensaje := 'No existen comentarios cargados en el sistema.' ]
]

{ #category : #initialization }
VerComentarioComponent >> initialize [
super initialize .
	mensaje:=' '.
	comentarios := Sistema soleInstance comentarios
]

{ #category : #rendering }
VerComentarioComponent >> renderComentariosOn: aCanvas [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ comentarios
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas
												strong: 'El usuario ' , each usuario nombreCompleto printString.
											aCanvas break.
											aCanvas text: 'Dice: ' , each contenido.
											aCanvas break. aCanvas horizontalRule ] ] ] ] ]
]

{ #category : #rendering }
VerComentarioComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas anchor
		callback: [ self call: ComentarioComponent new ];
		with: [ aCanvas button: 'Agregar Comentario' ].
	aCanvas heading
		level: 2;
		with: 'Comentarios: '.
	aCanvas heading
		level: 4;
		with: mensaje.
		self chequearVacio.
	self renderComentariosOn: aCanvas.
	
]
