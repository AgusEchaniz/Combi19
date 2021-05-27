Class {
	#name : #BasicComponent,
	#superclass : #WAComponent,
	#instVars : [
		'parent',
		'home'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
BasicComponent class >> newWithParent: aParent [
	^ self new initializeWithParent: aParent
]

{ #category : #'instance creation' }
BasicComponent class >> newWithParent: aParent andHome: aHome [
	^ self new initializeWithParent: aParent andHome:aHome
]

{ #category : #accessing }
BasicComponent >> initializeWithParent: aParent [
	parent := aParent
]

{ #category : #accessing }
BasicComponent >> initializeWithParent: aParent andHome:aHome [
	parent := aParent.
	home:=aHome
	
]

{ #category : #accessing }
BasicComponent >> parent [ 
^parent
]

{ #category : #rendering }
BasicComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas imageButton
						callback: [ self parent call: home  ];
						url: 'https://i.imgur.com/QbQap9R.png';
						height: 100;
						width: 100 ] ].
	aCanvas
		paragraph: [ aCanvas emphasis: 'Bienvenido ' , self session user nombre.
			aCanvas space.
			aCanvas anchor
				callback: [ self parent call: LoginComponent new ];
				with: [ aCanvas button: 'Cerrar sesión' ] ].
	aCanvas horizontalRule
]
