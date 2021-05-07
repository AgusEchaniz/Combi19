Class {
	#name : #ChoferComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombreUsuario',
		'contraseña',
		'nombre',
		'apellido',
		'telefono',
		'objetivo',
		'chofer',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
ChoferComponent class >> newWithObjetivo: unObjetivo andChofer: unChofer [
	^ self new initializeWithObjetivo:unObjetivo andChofer: unChofer
]

{ #category : #rendering }
ChoferComponent >> agregarChofer [
	nombreUsuario ifEmpty: [ ^ self ].
	(self model puedeSerChofer: nombreUsuario conContraseña: contraseña)
		ifFalse: [ (self model existeUsuario: nombreUsuario)
				ifTrue: [ mensaje := 'Ya existe un chofer con ese email ingresado.' ]
				ifFalse: [ (self model esValidaContraseña: contraseña ) ifFalse: [ mensaje:= 'La contraseña ingresada debe tener minimo 6 caracteres.' ] ].
				
			^ self ].
	self model
		crearUsuarioChoferWithNombreDeUsuario: nombreUsuario
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

{ #category : #initialization }
ChoferComponent >> initialize [
	super initialize.
	objetivo := 'agregar'.
	mensaje:= ' '
]

{ #category : #initialization }
ChoferComponent >> initializeWithObjetivo: unObjetivo andChofer: unChofer [
	super initialize.
	mensaje := ' '.
	objetivo := unObjetivo.
	chofer := unChofer.
	nombreUsuario := unChofer nombreUsuario.
	nombre := unChofer nombre.
	apellido := unChofer apellido.
	telefono := unChofer telefono.
	contraseña := unChofer contraseña	"obliga a cambiar todos los datos/registros"
]

{ #category : #accessing }
ChoferComponent >> model [
^Sistema soleInstance 
]

{ #category : #rendering }
ChoferComponent >> modificarChofer [
	nombre ifEmpty: [ ^ self ].
	apellido ifEmpty: [ ^ self ].
	telefono ifEmpty: [ ^ self ].
	nombreUsuario =chofer nombreUsuario ifFalse:[
	(Sistema soleInstance
		modificarChofer: chofer
		withNombreUsuario: nombreUsuario
		andNombre: nombre
		andApellido: apellido
		andTelefono: telefono)
		ifNil: [ mensaje := 'Ya existe un chofer con ese nombre registrado'.
			^ self ]]
	ifTrue:[Sistema soleInstance 		modificarChofer: chofer
		withNombre: nombre
		andApellido: apellido
		andTelefono: telefono].
	self answer
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
ChoferComponent >> renderButtonsOn: aCanvas para: unObjetivo [
	unObjetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarChofer];
				with: 'Agregar' ]
		ifFalse: [ aCanvas submitButton
				callback: [ self modificarChofer];
				with: 'Modificar' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
ChoferComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas horizontalRule.
	aCanvas heading level: 4;with: mensaje.
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
			self renderButtonsOn: aCanvas para: objetivo ]
]

{ #category : #accessing }
ChoferComponent >> telefono [
	^ telefono
]

{ #category : #accessing }
ChoferComponent >> telefono: anObject [
	telefono := anObject
]
