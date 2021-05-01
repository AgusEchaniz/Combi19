Class {
	#name : #RegisterComponent,
	#superclass : #AccessGrantingComponent,
	#instVars : [
		'name'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #accessing }
RegisterComponent >> name [
^name
]

{ #category : #accessing }
RegisterComponent >> name: aName [
name:=aName
]

{ #category : #accessing }
RegisterComponent >> registerAndLogin [
 self model
		crearNuevoUsuarioConNombreDeUsuario: email
		conContraseña: password.
	self answer
]

{ #category : #accessing }
RegisterComponent >> renderButtonsOn: aCanvas [
	self renderSignUpButtonOn: aCanvas
	
]

{ #category : #accessing }
RegisterComponent >> renderInputElementsOn: aCanvas [
	aCanvas label: 'Name'.
	aCanvas paragraph: [ aCanvas textInput on: #name of: self ].
	super renderInputElementsOn: aCanvas
]

{ #category : #accessing }
RegisterComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Register'.
		aCanvas submitButton callback:[self answer];
		with:'Cancel'
]
