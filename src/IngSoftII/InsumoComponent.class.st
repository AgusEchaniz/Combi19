Class {
	#name : #InsumoComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombre',
		'tipo',
		'precio',
		'mensaje',
		'objetivo',
		'insumo'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
InsumoComponent class >> newWithObjetivo: unObjetivo andInsumo:unInsumo [
	^ self new initializeWithObjetivo: unObjetivo andInsumo:unInsumo 
]

{ #category : #'as yet unclassified' }
InsumoComponent >> agregarInsumo [
	nombre ifEmpty: [ ^ self ].
	tipo ifEmpty: [ ^ self ].
	precio ifEmpty: [ ^ self ].
	(Sistema soleInstance
		agregarInsumoWithNombre: nombre
		andTipo: tipo
		andPrecio: precio)
		ifNil: [ mensaje := 'Ya existe un insumo con ese nombre registrado'.
			^ self ].
		self answer
]

{ #category : #initialization }
InsumoComponent >> initialize [
	super initialize.
	mensaje := ' '.
	objetivo:='agregar'
]

{ #category : #initialization }
InsumoComponent >> initializeWithObjetivo: unObjetivo andInsumo:unInsumo [
	super initialize.
	mensaje := ' '.
	objetivo := unObjetivo.
	insumo:=unInsumo 
]

{ #category : #'as yet unclassified' }
InsumoComponent >> modificarInsumo [
	nombre ifEmpty: [ ^ self ].
	tipo ifEmpty: [ ^ self ].
	precio ifEmpty: [ ^ self ].
	(Sistema soleInstance
		modificarInsumo: insumo
		withNombre: nombre
		andTipo: tipo
		andPrecio: precio)
		ifNil: [ mensaje := 'Ya existe un insumo con ese nombre registrado'.
			^ self ].
	self answer
]

{ #category : #accessing }
InsumoComponent >> nombre [
	^ nombre
]

{ #category : #accessing }
InsumoComponent >> nombre: anObject [
	nombre := anObject
]

{ #category : #accessing }
InsumoComponent >> precio [
	^ precio
]

{ #category : #accessing }
InsumoComponent >> precio: anObject [
	precio := anObject
]

{ #category : #rendering }
InsumoComponent >> renderButtonsOn: aCanvas [
aCanvas submitButton
		callback: [ self agregarInsumo ];
		with: 'Agregar'.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
InsumoComponent >> renderButtonsOn: aCanvas para: unObjetivo [
	unObjetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarInsumo ];
				with: 'Agregar' ]
		ifFalse: [ aCanvas submitButton
				callback: [ self modificarInsumo ];
				with: 'Modificar' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
InsumoComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese el nombre del insumo'.
			aCanvas textArea on: #nombre of: self.
			aCanvas paragraph: 'Ingrese el tipo de insumo'.
			aCanvas textArea on: #tipo of: self.
			aCanvas paragraph: 'Ingrese el precio del insumo'.
			aCanvas textArea on: #precio of: self.
			aCanvas horizontalRule.
			aCanvas break.
			self renderButtonsOn: aCanvas para:objetivo]
]

{ #category : #accessing }
InsumoComponent >> tipo [
	^ tipo
]

{ #category : #accessing }
InsumoComponent >> tipo: anObject [
	tipo := anObject
]
