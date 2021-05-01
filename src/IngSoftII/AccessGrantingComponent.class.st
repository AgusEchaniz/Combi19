"
""Sistema clearSoleInstance.
    application:= WAAdmin register: LoginComponent asApplicationAt:'combi19'.
    ""application sessionClass: SessionWithUser.""""


Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	email:		<Object>
	password:		<Object>


    Implementation Points
"
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
	"self call: HomeComponent new"
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
	aCanvas label: 'Password'.
	aCanvas paragraph: [ aCanvas passwordInput on: #password of: self ]
]

{ #category : #accessing }
AccessGrantingComponent >> renderTitleOn: aCanvas [
	aCanvas heading
		level: 1;
		with: 'Combi-19'.
	aCanvas horizontalRule
]
