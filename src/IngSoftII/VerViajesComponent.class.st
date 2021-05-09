Class {
	#name : #VerViajesComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viajes',
		'mensaje'
	],
	#category : #'IngSoftII-ui'
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
		ifTrue: [ Sistema soleInstance eliminarViaje: unViaje ]
		ifFalse:[mensaje:= 'No se pudo eliminar el viaje porque esta en curso']
]

{ #category : #initialization }
VerViajesComponent >> initialize [
super initialize.
viajes:=Sistema soleInstance viajes
]

{ #category : #initialization }
VerViajesComponent >> initializeWithViajes: unosViajes [
	super initialize.
	viajes := unosViajes
]

{ #category : #rendering }
VerViajesComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self).
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	self renderViajesOn: aCanvas
]

{ #category : #rendering }
VerViajesComponent >> renderViajesOn:aCanvas [
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ viajes
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each nombre.
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarViaje: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self
														call: (ViajeComponent  newWithObjetivo: 'modificar' andViaje: each) ];
												with: 'Modificar' ].
									aCanvas break.
									aCanvas break ] ] ].
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]
