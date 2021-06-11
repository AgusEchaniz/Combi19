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
		ifEmpty: [ mensaje := 'No existen comentarios cargados en el sistema.' ] ifNotEmpty:[mensaje:=' ']
]

{ #category : #'as yet unclassified' }
VerComentarioComponent >> eliminarComentario:unComentario [
Sistema soleInstance eliminarComentario:unComentario
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
											each usuario = self session user
												ifTrue: [ aCanvas break.
													aCanvas submitButton
														callback: [ self eliminarComentario: each ];
														with: 'Eliminar comentario'.
													aCanvas submitButton
														callback: [ self
																call:
																	(ComentarioComponent newWithObjetivo: 'modificar' andComentario: each) ];
														with: 'Modificar' ].
											aCanvas break.
											aCanvas horizontalRule ] ] ] ] .	aCanvas submitButton
						callback: [ self answer ];
						with: 'Volver' ]
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
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	self renderComentariosOn: aCanvas.
	
]
