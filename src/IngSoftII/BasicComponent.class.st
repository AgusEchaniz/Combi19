Class {
	#name : #BasicComponent,
	#superclass : #WAComponent,
	#instVars : [
		'parent'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
BasicComponent class >> newWithParent: aParent [
	^ self new initializeWithParent: aParent
]

{ #category : #accessing }
BasicComponent >> initializeWithParent: aParent [
	parent := aParent
]

{ #category : #accessing }
BasicComponent >> parent [ 
^parent
]

{ #category : #rendering }
BasicComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas image
				url: 'https://i.imgur.com/QbQap9R.png';
				height: 100;
				width: 100].
	aCanvas
		paragraph: [ aCanvas emphasis: 'Bienvenido ' , self session user nombre.
			aCanvas space.
			aCanvas anchor
				callback: [ self parent call: LoginComponent new ];
				with: [ aCanvas button: 'Cerrar sesión' ] ].
	aCanvas horizontalRule
]
