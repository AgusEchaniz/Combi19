Class {
	#name : #AccessGrantingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'email',
		'password'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #accessing }
AccessGrantingComponent >> email [
^email
]

{ #category : #accessing }
AccessGrantingComponent >> email:aEmail [
email:=aEmail
]

{ #category : #accessing }
AccessGrantingComponent >> model [
	^ Sistema soleInstance
]

{ #category : #accessing }
AccessGrantingComponent >> password [
	^ password
]

{ #category : #accessing }
AccessGrantingComponent >> password: aPassword [
	password := aPassword 
]

{ #category : #accessing }
AccessGrantingComponent >> proceedWith: aUser [
	self session user: aUser.
	(aUser
		es: 'chofer')
		ifTrue: [ self call: HomeComponentChofer new ]
		ifFalse: [ (aUser
				es: 'pasajero')
				ifTrue: [ self call: HomeComponentPasajero new ]
				ifFalse: [ self call: HomeComponentAdmin new ] ]
]

{ #category : #accessing }
AccessGrantingComponent >> renderButtonsOn: aCanvas [
	self subclassResponsibility
]

{ #category : #accessing }
AccessGrantingComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ self renderTitleOn: aCanvas.
			self renderInputElementsOn: aCanvas.
			self renderButtonsOn: aCanvas ]
]

{ #category : #accessing }
AccessGrantingComponent >> renderInputElementsOn: aCanvas [
	aCanvas label: 'Email'.
	aCanvas paragraph: [ aCanvas textInput on: #email of: self ].
	aCanvas label: 'Contraseña'.
	aCanvas paragraph: [ aCanvas passwordInput on: #password of: self ]
]

{ #category : #accessing }
AccessGrantingComponent >> renderTitleOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas image
				url: 'https://i.imgur.com/QbQap9R.png';
				height: 100;
				width: 100 ].

	aCanvas horizontalRule
]
