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
	aCanvas heading: 'Combi-19'.
	aCanvas heading
		level: 4;
		with: self session user nombre.
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self parent call: LoginComponent new ];
				with: [ aCanvas button: 'Cerrar sesión' ] ].
			aCanvas horizontalRule 
]
