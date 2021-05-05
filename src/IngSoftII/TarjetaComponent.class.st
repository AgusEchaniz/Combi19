Class {
	#name : #TarjetaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'numeroTarjeta',
		'codSeg',
		'unaFechaVencimiento',
		'nombreDeTarjeta',
		'user',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
TarjetaComponent class >> newWithUser:user [ 
^ self new initializeWithUser:user
]

{ #category : #'as yet unclassified' }
TarjetaComponent >> cargarTarjeta [
	numeroTarjeta ifEmpty: [ ^ self ].
	codSeg ifEmpty: [ ^ self ].
	unaFechaVencimiento ifNil: [ ^ self ].
	unaFechaVencimiento = Date today
		ifTrue: [ ^ self ].
	nombreDeTarjeta ifEmpty: [ ^ self ].
	(user
		puedeSerTarjetaWithNumero: numeroTarjeta
		andFechaVencimiento: unaFechaVencimiento)
		ifTrue: [ user
				cargarTarjetaWithNumero: numeroTarjeta
				andCodigoSeguridad: codSeg
				andFechaVencimiento: unaFechaVencimiento
				andNombre: nombreDeTarjeta ]
		ifFalse: [ (user esNumeroValido:numeroTarjeta)ifFalse:[mensaje:='Número de tarjeta inválido, recuerde que son 16 caracteres númericos'] ifTrue:[(user estaVigente:unaFechaVencimiento) ifFalse:[mensaje:='La tarjeta ingresada se encuentra vencida']]. ^ self ].
	self call: LoginComponent new
]

{ #category : #accessing }
TarjetaComponent >> codSeg [
	^ codSeg
]

{ #category : #accessing }
TarjetaComponent >> codSeg: anObject [
	codSeg := anObject
]

{ #category : #initialization }
TarjetaComponent >> initializeWithUser: aUser [
	self initialize.
	user := aUser.
	mensaje := ' '.
]

{ #category : #accessing }
TarjetaComponent >> nombreDeTarjeta [
	^ nombreDeTarjeta
]

{ #category : #accessing }
TarjetaComponent >> nombreDeTarjeta: anObject [
	nombreDeTarjeta := anObject
]

{ #category : #accessing }
TarjetaComponent >> numeroTarjeta [
	^ numeroTarjeta
]

{ #category : #accessing }
TarjetaComponent >> numeroTarjeta: anObject [
	numeroTarjeta := anObject
]

{ #category : #rendering }
TarjetaComponent >> renderContentOn: aCanvas [
aCanvas heading level:4;with: mensaje.
	aCanvas
		form: [ aCanvas paragraph: 'Numero de tarjeta'.
			aCanvas
				paragraph: [ aCanvas textInput on: #numeroTarjeta of: self ].
			aCanvas paragraph: 'Nombre en la tarjeta'.
			aCanvas
				paragraph: [ aCanvas textInput on: #nombreDeTarjeta of: self ].
			aCanvas paragraph: 'Código de seguridad'.
			aCanvas paragraph: [ aCanvas textInput on: #codSeg of: self ].
			aCanvas paragraph: 'Ingrese fecha de vencimiento mes/día/año'.
			aCanvas
				paragraph: [ aCanvas textInput on: #unaFechaVencimiento of: self ].
			"aCanvas anchor
		callback: [ self cargarTarjeta ];
		with: [ aCanvas button: 'Cargar' ].
	aCanvas anchor
		callback: [ self answer ];
		with: [ aCanvas button: 'Cancelar' ]"
			aCanvas submitButton
				callback: [ self cargarTarjeta ];
				with: 'Cargar'.
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Cancel' ]
]

{ #category : #accessing }
TarjetaComponent >> unaFechaVencimiento [
	^ unaFechaVencimiento
]

{ #category : #accessing }
TarjetaComponent >> unaFechaVencimiento: anObject [
	unaFechaVencimiento := anObject
]
