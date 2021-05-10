Class {
	#name : #CombiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'patente',
		'tipo',
		'chofer',
		'cantidadAsientos',
		'mensaje',
		'objetivo',
		'combi',
		'usarChoferActual'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #'instance creation' }
CombiComponent class >> newWithObjetivo: unObjetivo andCombi: unaCombi [
	^ self new initializeWithObjetivo: unObjetivo andCombi: unaCombi
]

{ #category : #rendering }
CombiComponent >> agregarCombi [
	patente ifEmpty: [ ^ self ].
	tipo ifEmpty: [ ^ self ].
	cantidadAsientos ifEmpty: [ ^ self ].
	chofer ifNil: [ mensaje :='Seleccione un chofer'.^ self ].
	(Sistema soleInstance
		agregarCombiWithPatente: patente
		andTipo: tipo
		andCantAsientos: cantidadAsientos
		andChofer: chofer)
		ifNil: [ mensaje := 'Ya existe una combi con esa patente registrado'.
			^ self ].
	self answer
]

{ #category : #accessing }
CombiComponent >> cantidadAsientos [ ^cantidadAsientos 
]

{ #category : #accessing }
CombiComponent >> cantidadAsientos:unaCantidad [
cantidadAsientos:=unaCantidad 
]

{ #category : #accessing }
CombiComponent >> chofer [ ^chofer
]

{ #category : #accessing }
CombiComponent >> chofer:unChofer [
	 chofer:=unChofer
]

{ #category : #initialization }
CombiComponent >> initialize [
	super initialize.
	objetivo := 'agregar'.
	mensaje := ' '
]

{ #category : #initialization }
CombiComponent >> initializeWithObjetivo: unObjetivo andCombi: unaCombi [
	super initialize.
	mensaje := ' '.
	objetivo := unObjetivo.
	combi := unaCombi.
	patente := unaCombi patente.
	chofer := unaCombi chofer.
	tipo := unaCombi tipo.
	cantidadAsientos := unaCombi cantidadAsientos.
	usarChoferActual :=false.
]

{ #category : #accessing }
CombiComponent >> model [
	^ Sistema soleInstance
]

{ #category : #rendering }
CombiComponent >> modificarCombi [
	patente ifEmpty: [ ^ self ].
	tipo ifEmpty: [ ^ self ].
	cantidadAsientos ifEmpty: [ ^ self ].
	chofer ifNil: [ ^ self ].
	usarChoferActual
		ifTrue: [ self chofer: combi chofer ] .
	patente = combi patente
		ifFalse: [ (Sistema soleInstance
				modificarCombi: combi
				withPatente: patente
				andTipo: tipo
				andCantAsientos: cantidadAsientos
				andChofer: chofer)
				ifNil: [ mensaje := 'Ya existe una combi con esa patente'.
					^ self ] ]
		ifTrue: [ Sistema soleInstance
				modificarCombi: combi
				withTipo: tipo
				andCantAsientos: cantidadAsientos
				andChofer: chofer ].
	self answer
]

{ #category : #accessing }
CombiComponent >> patente [
^patente
]

{ #category : #accessing }
CombiComponent >> patente:unaPatente [
patente:=unaPatente
]

{ #category : #rendering }
CombiComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self agregarCombi ];
		with: 'Agregar'.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
CombiComponent >> renderButtonsOn: aCanvas para: unObjetivo [
	unObjetivo = 'agregar'
		ifTrue: [ aCanvas submitButton
				callback: [ self agregarCombi ];
				with: 'Agregar' ]
		ifFalse: [
			aCanvas submitButton
				callback: [ self modificarCombi ];
				with: 'Modificar' ].
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
CombiComponent >> renderChoferesOn: aCanvas [
	| usuarios |
	usuarios := Sistema soleInstance choferesDisponibles.
	aCanvas paragraph: 'Seleccione un chofer'.
	usuarios
		ifEmpty: [ aCanvas heading level:4;with: 'No hay choferes disponibles' ].
	aCanvas
		unorderedList: [ usuarios
				do: [ :each | 
					aCanvas
						listItem: [ aCanvas
								paragraph: [ aCanvas text: each nombre.
									aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
									aCanvas submitButton
										callback: [ self chofer: each ];
										with: 'Seleccionar'.
									aCanvas break ] ] ] ]
]

{ #category : #rendering }
CombiComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	aCanvas heading
		level: 4;
		with: mensaje.
	aCanvas
		form: [ aCanvas paragraph: 'Ingrese la patente de la combi'.
			aCanvas textArea on: #patente of: self.
			aCanvas paragraph: 'Ingrese el tipo de combi'.
			"aCanvas textArea on: #tipo of: self."
			(aCanvas select list: #('Cama' 'Semi-cama')) on: #tipo of: self.
			aCanvas paragraph: 'Ingrese la cantidad de asientos'.
			aCanvas textArea on: #cantidadAsientos of: self.
			objetivo = 'modificar'
				ifTrue: [ aCanvas paragraph: [aCanvas paragraph:'Chofer actual: ' , chofer nombre.aCanvas submitButton
						callback: [ self usarChoferActual];
						with: 'Seleccionar chofer actual' ] ].
			self renderChoferesOn: aCanvas.
			aCanvas horizontalRule.
			aCanvas break.
			self renderButtonsOn: aCanvas para: objetivo ]
]

{ #category : #accessing }
CombiComponent >> tipo [ 
^tipo
]

{ #category : #accessing }
CombiComponent >> tipo: unTipo [
	 tipo:=unTipo
]

{ #category : #accessing }
CombiComponent >> usarChoferActual [
usarChoferActual:=true 
]
