Class {
	#name : #TarjetaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'numeroTarjeta',
		'codSeg',
		'unaFechaVencimiento',
		'nombreDeTarjeta',
		'user',
		'mensaje',
		'return',
		'objetivo'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
TarjetaComponent class >> newWithUser:user [ 
^ self new initializeWithUser:user
]

{ #category : #'instance creation' }
TarjetaComponent class >> newWithUser: user andReturn:aReturn [
	^ self new initializeWithUser: user andReturn:aReturn
]

{ #category : #'instance creation' }
TarjetaComponent class >> newWithUser: user andReturnGold: aReturn [
	^ self new initializeWithUser: user andReturnGold: aReturn
]

{ #category : #'as yet unclassified' }
TarjetaComponent >> cargarTarjeta [
	numeroTarjeta ifEmpty: [ ^ self ].
	codSeg ifEmpty: [ ^ self ].
	unaFechaVencimiento ifNil: [ ^ self ].
	"unaFechaVencimiento = Date today
		ifTrue: [ ^ self ]."
	nombreDeTarjeta ifEmpty: [ ^ self ].
	(user
		puedeSerTarjetaWithNumero: numeroTarjeta
		andFechaVencimiento: unaFechaVencimiento)
		ifTrue: [ user
				cargarTarjetaWithNumero: numeroTarjeta
				andCodigoSeguridad: codSeg
				andFechaVencimiento: unaFechaVencimiento
				andNombre: nombreDeTarjeta ]
		ifFalse: [ (user esNumeroValido: numeroTarjeta)
				ifFalse:
					[ mensaje := 'Número de tarjeta inválido, recuerde que son 16 caracteres numéricos' ]
				ifTrue: [ (user estaVigente: unaFechaVencimiento)
						ifFalse: [ mensaje := 'La tarjeta ingresada se encuentra vencida' ] ].
			^ self ].
	return
		ifNil: [ self call: LoginComponent new ]
		ifNotNil: [ self answer:true ]
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
	return := nil.
	objetivo := 'cargar'
]

{ #category : #initialization }
TarjetaComponent >> initializeWithUser: aUser andReturn: aReturn [
	self initializeWithUser: aUser.
	return := aReturn.
	objetivo := 'pagar'
]

{ #category : #initialization }
TarjetaComponent >> initializeWithUser: aUser andReturnGold: aReturn [
	self initializeWithUser: aUser.
	return := aReturn.
	objetivo := 'cargarGold'
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

{ #category : #'as yet unclassified' }
TarjetaComponent >> pagarConTarjeta [
	numeroTarjeta ifEmpty: [ ^ self ].
	codSeg ifEmpty: [ ^ self ].
	unaFechaVencimiento ifNil: [ ^ self ].
	"unaFechaVencimiento = Date today
		ifTrue: [ ^ self ]."
	nombreDeTarjeta ifEmpty: [ ^ self ].
	(user
		puedeSerTarjetaWithNumero: numeroTarjeta
		andFechaVencimiento: unaFechaVencimiento)
		ifTrue: [ self answer: true ]
		ifFalse: [ (user esNumeroValido: numeroTarjeta)
				ifFalse:
					[ mensaje := 'Número de tarjeta inválido, recuerde que son 16 caracteres numéricos' ]
				ifTrue: [ (user estaVigente: unaFechaVencimiento)
						ifFalse: [ mensaje := 'La tarjeta ingresada se encuentra vencida' ] ].
			^ self ].
	return
		ifNil: [ self call: LoginComponent new ]
		ifNotNil: [ self answer: true ]
]

{ #category : #rendering }
TarjetaComponent >> renderContentOn: aCanvas [
	return
		ifNotNil: [ aCanvas
				paragraph:
					(BasicComponent newWithParent: self andHome: HomeComponentPasajero new) ].
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ aCanvas paragraph: 'Numero de tarjeta'.
			aCanvas
				paragraph: [ aCanvas textInput
						maxLength: 16;
						on: #numeroTarjeta of: self ].
			aCanvas paragraph: 'Nombre en la tarjeta'.
			aCanvas
				paragraph: [ aCanvas textInput on: #nombreDeTarjeta of: self ].
			aCanvas paragraph: 'Código de seguridad'.
			aCanvas paragraph: [ aCanvas textInput on: #codSeg of: self ].
			aCanvas paragraph: 'Ingrese fecha de vencimiento mes/año'.
			(aCanvas dateInput options: #(month year))
				on: #unaFechaVencimiento
				of: self.
			aCanvas break.
			objetivo = 'pagar'
				ifTrue: [ aCanvas submitButton
						callback: [ self pagarConTarjeta  ];
						with: 'Pagar' ]
				ifFalse: [ aCanvas submitButton
						callback: [ self cargarTarjeta ];
						with: 'Cargar' ].
			return
				ifNotNil: [ aCanvas submitButton
						callback: [ self answer: false ];
						with: 'Cancelar' ]
				ifNil: [ aCanvas submitButton
						callback: [ self answer ];
						with: 'Cancelar' ] ]
]

{ #category : #accessing }
TarjetaComponent >> unaFechaVencimiento [
	^ unaFechaVencimiento
]

{ #category : #accessing }
TarjetaComponent >> unaFechaVencimiento: anObject [
	unaFechaVencimiento := anObject
]
