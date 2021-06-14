Class {
	#name : #ComentarioComponent,
	#superclass : #WAComponent,
	#instVars : [
		'comentario',
		'mensaje',
		'objetivo',
		'contenido',
		'usuario'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
ComentarioComponent class >> newWithObjetivo: unObjetivo andComentario: unComentario [
	^self new initializeWithObjetivo: unObjetivo andComentario: unComentario
]

{ #category : #rendering }
ComentarioComponent >> agregarComentario [
	contenido
		ifEmpty: [ mensaje := 'Complete el campo para agregar un comentario.'.
			^ self ].
	Sistema soleInstance
		agregarComentarioWithContenido: contenido
		andUsuario: self session user.
	self answer
]

{ #category : #accessing }
ComentarioComponent >> contenido [
^contenido
]

{ #category : #accessing }
ComentarioComponent >> contenido: unContenido [
 contenido:=unContenido
]

{ #category : #initialization }
ComentarioComponent >> initialize [
	super initialize.
	mensaje := ' '.
	objetivo := 'agregar'
]

{ #category : #initialization }
ComentarioComponent >> initializeWithObjetivo: unObjetivo andComentario: unComentario [ 
	super initialize.
	mensaje := ' '.
	objetivo := unObjetivo.
	comentario  := unComentario .
	usuario  := unComentario usuario .
	contenido := unComentario contenido .
]

{ #category : #'as yet unclassified' }
ComentarioComponent >> modificarComentario [
	(Sistema soleInstance
		modificarComentario: comentario
		withContenido: contenido)
		ifNil: [ mensaje := 'Complete el campo para modificar el comentario' ]
		ifNotNil: [ self answer ]
]

{ #category : #rendering }
ComentarioComponent >> renderButtonsOn: aCanvas para: unObjetivo [
	unObjetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarComentario  ];
				with: 'Agregar' ]
		ifFalse: [ aCanvas submitButton
				callback: [ self modificarComentario  ];
				with: 'Modificar' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
ComentarioComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese el comentario:'.
			aCanvas textArea on: #contenido of: self.
			aCanvas break.
			aCanvas horizontalRule.
			aCanvas break.
			self renderButtonsOn: aCanvas para: objetivo ]
]
