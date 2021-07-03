Class {
	#name : #VerViajesComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viajes',
		'mensaje'
	],
	#category : #'IngSoftII-ui-Admin'
}

{ #category : #'instance creation' }
VerViajesComponent class >> newWithViajes: viajes [
^self new initializeWithViajes: viajes
]

{ #category : #'as yet unclassified' }
VerViajesComponent >> chequearVacio [ 
	viajes ifEmpty: [ mensaje := 'No existen viajes cargados en el sistema.' ]
]

{ #category : #'as yet unclassified' }
VerViajesComponent >> eliminarViaje: unViaje [
	(Sistema soleInstance sePuedeEliminarViaje: unViaje)
		ifTrue: [ 
			unViaje cantidadVendidos = 0
				ifTrue: [ Sistema soleInstance eliminarViaje: unViaje ]
				ifFalse: [ (self
						confirm:
							'El viaje seleccionado tiene: ' , unViaje cantidadVendidos asString
								, ' pasajes vendidos, desea eliminarlo? ')
						ifTrue: [ Sistema soleInstance eliminarViaje: unViaje ] ] ]
		ifFalse: [ mensaje := 'No se pudo eliminar el viaje porque esta en curso' ]
]

{ #category : #initialization }
VerViajesComponent >> initialize [
	super initialize.
	viajes := (Sistema soleInstance viajes)sort:[:viajeA :viajeB| viajeA estado< viajeB estado]
]

{ #category : #initialization }
VerViajesComponent >> initializeWithViajes: unosViajes [
	super initialize.
	viajes := unosViajes
]

{ #category : #rendering }
VerViajesComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self andHome: HomeComponentAdmin new).
	aCanvas heading
		level: 2;
		with: 'Viajes: '.
	"aCanvas big: 'Viajes: '."
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	self renderViajesOn: aCanvas
]

{ #category : #rendering }
VerViajesComponent >> renderViajesOn: aCanvas [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ viajes
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas strong: each estado , ' '.
											aCanvas text: each nombre.
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											each finalizado | each cancelado | each enCurso
												ifFalse: [ aCanvas submitButton
														callback: [ self eliminarViaje: each ];
														with: 'Eliminar'.
													aCanvas submitButton
														callback: [ self
																call: (ViajeComponent newWithObjetivo: 'modificar' andViaje: each) ];
														with: 'Modificar' ]
												ifTrue: [ each finalizado
														ifTrue: [ aCanvas submitButton
																callback: [ self call: (VerPasajerosRechazadosComponent newWithViaje: each) ];
																with: 'Ver pasajeros rechazados' ] ].
											aCanvas break ] ] ].
					aCanvas horizontalRule.
					aCanvas submitButton
						callback: [ self answer ];
						with: 'Volver' ] ]
]
