Class {
	#name : #HomeComponentPasajero,
	#superclass : #HomeComponent,
	#instVars : [
		'origenFilt',
		'destinoFilt',
		'fechaFilt',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #utility }
HomeComponentPasajero >> buscarViajes: aCanvas [
	" validarFecha."

	fechaFilt
		ifNil: [ mensaje := 'Por favor ingrese una fecha'.
			^ self ].
	(fechaFilt isBefore: Date today)
		ifTrue: [ mensaje := 'Por favor ingrese una fecha actual o posterior'.
			^ self ].
	"	 validarLugares."
	origenFilt = destinoFilt
		ifTrue: [ mensaje := 'Los lugares deben ser distintos'.
			^ self ].
	"nuevo componente para mostrar viajes al pasajero"
	self
		call: (VerViajesComponent newWithViajes: self obtenerViajesFiltrados).
	mensaje := ''
]

{ #category : #accessing }
HomeComponentPasajero >> destinoFilt [
	^ destinoFilt
]

{ #category : #accessing }
HomeComponentPasajero >> destinoFilt: unDestino [
	destinoFilt := unDestino
]

{ #category : #accessing }
HomeComponentPasajero >> fechaFilt [
	^ fechaFilt
]

{ #category : #accessing }
HomeComponentPasajero >> fechaFilt: unaFecha [ 
	fechaFilt := unaFecha
]

{ #category : #utility }
HomeComponentPasajero >> obtenerViajesFiltrados [
	| viajes |
	viajes := Sistema soleInstance viajes.
	^ (viajes
		select: [ :each | 
			each ruta lugarOrigen = origenFilt
				& (each ruta lugarDestino = destinoFilt)
				& (fechaFilt <= each fecha) ])
		asSortedCollection: [ :viaje1 :viaje2 | viaje1 fecha < viaje2 fecha ]
]

{ #category : #accessing }
HomeComponentPasajero >> origenFilt [
^origenFilt
]

{ #category : #accessing }
HomeComponentPasajero >> origenFilt:unOrigen [
 origenFilt:=unOrigen 
]

{ #category : #rendering }
HomeComponentPasajero >> renderContentOn: aCanvas [

	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	self renderViajesOn: aCanvas
]

{ #category : #rendering }
HomeComponentPasajero >> renderFechaOn:aCanvas [ 
aCanvas paragraph: 'Ingrese fecha del viaje  dia/mes/año'.
			(aCanvas dateInput options: #(day month year))
				on: #fechaFilt
				of: self  
]

{ #category : #rendering }
HomeComponentPasajero >> renderFormualrio: aCanvas [
	aCanvas
		form: [ self renderFechaOn: aCanvas.
			self renderLugaresOn: aCanvas .
			aCanvas break.
				aCanvas submitButton 
		callback: [ self buscarViajes: aCanvas ];
		with:  'Buscar Viajes' .]
]

{ #category : #rendering }
HomeComponentPasajero >> renderListaViajes: listado on: aCanvas [
	listado ifEmpty: [ ^ self ].
	"listado do: [ :each | self renderViaje: each on: aCanvas ]"
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ listado
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas
												text: each ruta lugarOrigen nombre , ' a ' , each ruta lugarDestino nombre.
											aCanvas break.
											aCanvas strong: 'El dia' , each fecha printString.
											aCanvas break.
											aCanvas
												strong: 'Asientos disponibles:' , each cantidadAsientosDisponibles printString.
											aCanvas submitButton
												callback: [ self call:ComprarPasajeComponent  ];
												with: 'Comprar pasaje'.

									aCanvas break.
aCanvas horizontalRule.
									aCanvas break ] ] ].
			aCanvas horizontalRule.
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]]
]

{ #category : #rendering }
HomeComponentPasajero >> renderLugaresOn: aCanvas [
	aCanvas paragraph: 'Seleccione el lugar de partida de la ruta'.
	Sistema soleInstance lugares
		ifNotEmpty: [ (aCanvas select
				list: Sistema soleInstance lugares;
				labels: [ :each | each nombre ]) on: #origenFilt of: self ]
		ifEmpty: [ aCanvas heading
				level: 4;
				with: 'No hay lugares registrados en el sistema' ].
			"".
	aCanvas paragraph: 'Seleccione el lugar de destino de la ruta'.
	Sistema soleInstance lugares
		ifNotEmpty: [ (aCanvas select
				list: Sistema soleInstance lugares;
				labels: [ :each | each nombre ]) on: #destinoFilt of: self ]
		ifEmpty: [ aCanvas heading
				level: 4;
				with: 'No hay lugares registrados en el sistema' ]
]

{ #category : #rendering }
HomeComponentPasajero >> renderViaje: unViaje on: aCanvas [
	aCanvas strong: 'Viaje de '.
	aCanvas heading
		level: 3;
		with: unViaje lugarOrigen printString.
	aCanvas strong: ' a '.
	aCanvas heading
		level: 3;
		with: unViaje lugarDestino printString.
	aCanvas break.
	aCanvas strong: 'El dia' , unViaje fecha printString.
	aCanvas break.
	aCanvas strong:'Asientos disponibles:' "asientos disponibles".
	aCanvas anchor
			callback: [];
			with: [ aCanvas button:'Comprar Pasaje/s' ].
	
	aCanvas horizontalRule
]

{ #category : #rendering }
HomeComponentPasajero >> renderViajesOn: aCanvas [
	aCanvas heading
		level: 4;
		with: mensaje.
	self renderFormualrio: aCanvas.
	aCanvas break.
"	aCanvas anchor
		callback: [ self buscarViajes: aCanvas ];
		with: [ aCanvas button: 'Buscar Viajes' ]."
	aCanvas horizontalRule
]

{ #category : #utility }
HomeComponentPasajero >> validarFecha [
	fechaFilt
		ifNil: [ mensaje := 'Por favor ingrese una fecha'.
			^ self ].
	(fechaFilt isBefore: Date today)
		ifTrue: [ 
	mensaje := 'Por favor ingrese una fecha actual o posterior'.^ self .]
]

{ #category : #utility }
HomeComponentPasajero >> validarLugares [
	(origenFilt = destinoFilt )
		ifTrue: [ mensaje:='Los lugares deben ser distintos' ]
]
