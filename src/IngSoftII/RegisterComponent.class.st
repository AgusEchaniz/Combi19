Class {
	#name : #RegisterComponent,
	#superclass : #AccessGrantingComponent,
	#instVars : [
		'name',
		'membresia',
		'unaFecha',
		'unApellido',
		'unDni'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #accessing }
RegisterComponent >> initialize [
	super initialize.
	unaFecha := Date today.
	
]

{ #category : #accessing }
RegisterComponent >> membresia [
	^ membresia
]

{ #category : #accessing }
RegisterComponent >> membresia: anObject [
	anObject = 'basica'
		ifTrue: [ membresia := MembresiaBasica new ]
		ifFalse: [ membresia := MembresiaGold new ]
]

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
	| user |
	email ifEmpty: [ ^ self ].
	password ifEmpty: [ ^ self ].
	unaFecha ifNil: [ ^ self ].
	unaFecha = Date today
		ifTrue: [ ^ self ].
	name ifEmpty: [ ^ self ].
	unApellido ifEmpty: [ ^ self ].
	unDni ifEmpty: [ ^ self ].
	membresia ifNil: [ ^ self ].
	(self model
		puedeSerUsuario: email
		conContraseña: password
		conFechaNac: unaFecha)
		ifTrue: [ user := self model
				crearUsuarioPasajeroWithNombreDeUsuario: email
				andContraseña: password
				andFechaNacimiento: unaFecha
				andNombre: name
				andApellido: unApellido
				andDni: unDni
				andMembresia: membresia.
			user
				ifNotNil: [ membresia nombre = 'gold'
						ifTrue: [ self call: (TarjetaComponent newWithUser: user).
							self validarCargaTarjetaDeUsuario: user ] ] ]
		ifFalse: [ (self model esValidaContraseña: password)
				ifFalse: [ mensaje := 'Contraseña muy corta, mínimo 6 caracteres' ]
				ifTrue: [ (self model existeUsuario: email)
						ifTrue: [ mensaje := 'El email ya se encuentra registrado en el sistema' ]
						ifFalse: [ (self model esMayorDeEdad: unaFecha)
								ifFalse: [ mensaje := 'Debe ser mayor para registrarse en el sistema' ] ] ].
			^ self].
	self answer
]

{ #category : #accessing }
RegisterComponent >> renderButtonsOn: aCanvas [
	self renderSignUpButtonOn: aCanvas
	
]

{ #category : #accessing }
RegisterComponent >> renderInputElementsOn: aCanvas [
	aCanvas heading
		level: 4;
		with: mensaje.
	"	aCanvas horizontalRule."
	aCanvas paragraph: 'Nombre'.
	aCanvas paragraph: [ aCanvas textInput on: #name of: self ].
	aCanvas paragraph: 'Apellido'.
	aCanvas paragraph: [ aCanvas textInput on: #unApellido of: self ].
	aCanvas paragraph: 'DNI'.
	aCanvas paragraph: [ aCanvas textInput on: #unDni of: self ].
	aCanvas paragraph: 'Ingrese fecha de nacimiento día/mes/año'.
	aCanvas paragraph: [ (aCanvas dateInput options: #(day month year)) on: #unaFecha of: self ].
	aCanvas paragraph: 'Elegi tu membresia: '.
	aCanvas submitButton
		callback: [ self membresia: 'basica' ];
		with: 'Básica'.
	aCanvas space.
	aCanvas submitButton
		callback: [ self membresia: 'gold' ];
		with: 'Gold. Paga sólo $250 al mes'.
	aCanvas break.
	aCanvas break.
	aCanvas label: 'Email'.
	aCanvas paragraph: [ aCanvas textInput on: #email of: self ].
	aCanvas label: 'Contraseña'.
	aCanvas paragraph: [ aCanvas passwordInput on: #password of: self ]
]

{ #category : #accessing }
RegisterComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton
		callback: [ self registerAndLogin ];
		with: 'Registrarse'.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #accessing }
RegisterComponent >> unApellido [
	^ unApellido
]

{ #category : #accessing }
RegisterComponent >> unApellido: anObject [
	unApellido := anObject
]

{ #category : #accessing }
RegisterComponent >> unDni [
	^ unDni
]

{ #category : #accessing }
RegisterComponent >> unDni: anObject [
	unDni := anObject
]

{ #category : #accessing }
RegisterComponent >> unaFecha [
	^ unaFecha
]

{ #category : #accessing }
RegisterComponent >> unaFecha: anObject [
	unaFecha := anObject
]

{ #category : #'as yet unclassified' }
RegisterComponent >> validarCargaTarjetaDeUsuario: user [
	user tarjeta ifNil: [  self model eliminarUsuario: user ]
]
