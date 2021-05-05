Class {
	#name : #HomeComponent,
	#superclass : #WAComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #accessing }
HomeComponent >> model [
	^ Sistema soleInstance
]

{ #category : #rendering }
HomeComponent >> renderContentOn: aCanvas [
	"aCanvas paragraph: (BasicComponent newWithParent: self)."

	aCanvas paragraph: (BasicComponent newWithParent: self).

	"self renderPostsOn: aCanvas.
	aCanvas horizontalRule.
	self renderFriendsOn: aCanvas.
	aCanvas horizontalRule.
	self renderLogoutButtonOn: aCanvas"
]

{ #category : #rendering }
HomeComponent >> renderFriendsOn: aCanvas [
"	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self call: FriendsComponent new ];
				with: [ aCanvas button with: 'Buscar amigos' ] ]"
]

{ #category : #rendering }
HomeComponent >> renderLogoutButtonOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self answer ];
				with: [ aCanvas button: 'Logout' ] ]
]

{ #category : #rendering }
HomeComponent >> renderPostsOn: aCanvas [
"	aCanvas heading
		level: 2;
		with: 'Preguntas'.
	aCanvas
		unorderedList: [ self session user obtenerUltimas5PreguntasRelevantes
				do: [ :each | 
					aCanvas
						listItem: (QuestionComponent newWithPregunta: each andParent: self) ] ].
	aCanvas anchor
		callback: [ self call: PostComponent new ];
		with: 'Publicar nueva pregunta'"
]
