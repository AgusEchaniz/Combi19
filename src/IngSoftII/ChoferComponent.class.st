Class {
	#name : #ChoferComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombreUsuario',
		'contraseña',
		'nombre',
		'apellido',
		'telefono'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
ChoferComponent >> agregarChofer [
	nombreUsuario ifEmpty: [ ^ self ].
	(self model
		puedeSerChofer: nombreUsuario
		conContraseña: contraseña)
		ifFalse: [ ^ self ].
	self model
		agregarChoferConNombreDeUsuario: nombreUsuario
		andContraseña: contraseña
		andNombre: nombre
		andApellido: apellido
		andTelefono: telefono.
	self answer
]

{ #category : #accessing }
ChoferComponent >> apellido [
	^ apellido
]

{ #category : #accessing }
ChoferComponent >> apellido: anObject [
	apellido := anObject
]

{ #category : #accessing }
ChoferComponent >> contraseña [
	^ contraseña
]

{ #category : #accessing }
ChoferComponent >> contraseña: anObject [
	contraseña := anObject
]

{ #category : #accessing }
ChoferComponent >> model [
^Sistema soleInstance 
]

{ #category : #accessing }
ChoferComponent >> nombre [
	^ nombre
]

{ #category : #accessing }
ChoferComponent >> nombre: anObject [
	nombre := anObject
]

{ #category : #accessing }
ChoferComponent >> nombreUsuario [
	^ nombreUsuario
]

{ #category : #accessing }
ChoferComponent >> nombreUsuario: anObject [
	nombreUsuario := anObject
]

{ #category : #rendering }
ChoferComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self agregarChofer ];
		with: 'Agregar' .
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar' 
]

{ #category : #rendering }
ChoferComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas horizontalRule.
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese el nombre de usuario del chofer'.
			aCanvas textArea on: #nombreUsuario of: self.
			aCanvas paragraph: 'Ingrese la contraseña del chofer'.
			aCanvas passwordInput on: #contraseña of: self.
			aCanvas paragraph: 'Ingrese el nombre del chofer'.
			aCanvas textArea on: #nombre of: self.
			aCanvas paragraph: 'Ingrese el apellido del chofer'.
			aCanvas textArea on: #apellido of: self.
			aCanvas paragraph: 'Ingrese el telefono del chofer'.
			aCanvas textArea on: #telefono of: self.
			aCanvas horizontalRule.
			aCanvas break.
			self renderButtonsOn: aCanvas ]
]

{ #category : #accessing }
ChoferComponent >> telefono [
	^ telefono
]

{ #category : #accessing }
ChoferComponent >> telefono: anObject [
	telefono := anObject
]
