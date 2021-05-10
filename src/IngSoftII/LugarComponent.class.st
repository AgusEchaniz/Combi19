Class {
	#name : #LugarComponent,
	#superclass : #WAComponent,
	#instVars : [
		'localidad',
		'provincia',
		'lugar',
		'mensaje',
		'objetivo'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
LugarComponent class >> newWithObjetivo: unObjetivo andLugar: unLugar [
	^ self new initializeWithObjetivo: unObjetivo andLugar:unLugar 
]

{ #category : #rendering }
LugarComponent >> agregarLugar [
	localidad ifEmpty: [ ^ self ].
	provincia ifNil: [ ^ self ].
	(Sistema soleInstance
		agregarLugarWithLocalidad: localidad
		andProvincia: provincia)
		ifNil: [ mensaje := 'Ya existe localidad con ese nombre registrado'.
			^ self ].
	self answer
]

{ #category : #initialization }
LugarComponent >> initialize [
	super initialize.
	mensaje := ' '.
	objetivo := 'agregar'
]

{ #category : #initialization }
LugarComponent >> initializeWithObjetivo: unObjetivo andLugar: unLugar [
	super initialize.
	mensaje := ' '.
	objetivo := unObjetivo.
	lugar := unLugar.
	localidad:= unLugar localidad.
	provincia:= unLugar provincia.
]

{ #category : #accessing }
LugarComponent >> localidad [ ^localidad
]

{ #category : #accessing }
LugarComponent >> localidad:unaLocalidad [
localidad:=unaLocalidad 
]

{ #category : #rendering }
LugarComponent >> modificarLugar [
	localidad ifEmpty: [ ^ self ].
	provincia ifEmpty: [ ^ self ].
	localidad = lugar localidad
		ifFalse: [ (Sistema soleInstance
				modificarLugar: lugar
				withLocalidad: localidad
				andProvincia: provincia)
				ifNil:
					[ mensaje := 'Ya existe un lugar con esa localidad registrada para esa provincia'.
					^ self ] ]
		ifTrue: [ Sistema soleInstance
				modificarLugar: lugar
				withProvincia: provincia ].
	self answer
]

{ #category : #accessing }
LugarComponent >> provincia [ 
	^ provincia
]

{ #category : #accessing }
LugarComponent >> provincia: unaProvincia [ 
provincia:=unaProvincia 
]

{ #category : #rendering }
LugarComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self agregarLugar ];
		with: 'Agregar'.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
LugarComponent >> renderButtonsOn: aCanvas para: unObjetivo [
	unObjetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarLugar];
				with: 'Agregar' ]
		ifFalse: [ aCanvas submitButton
				callback: [ self modificarLugar];
				with: 'Modificar' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
LugarComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese localidad del lugar'.
			aCanvas textArea on: #localidad of: self.
			aCanvas break.
			aCanvas paragraph: 'Seleccione la provincia del lugar'.
			(aCanvas select list: Sistema soleInstance provincias)
				on: #provincia
				of: self.
			aCanvas horizontalRule.
			aCanvas break.
			self renderButtonsOn: aCanvas para: objetivo ]
]
