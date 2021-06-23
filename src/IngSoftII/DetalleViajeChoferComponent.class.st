Class {
	#name : #DetalleViajeChoferComponent,
	#superclass : #WAComponent,
	#instVars : [
		'viaje',
		'mensaje'
	],
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #'instance creation' }
DetalleViajeChoferComponent class >> newWithViaje: unViaje [
	^self new initializeWithViaje: unViaje
]

{ #category : #initialization }
DetalleViajeChoferComponent >> initializeWithViaje: unViaje [
	super initialize.
	viaje := unViaje.
	mensaje := ' '.
]

{ #category : #initialization }
DetalleViajeChoferComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph:
			(BasicComponent newWithParent: self andHome: HomeComponentPasajero new).
	aCanvas heading
		level: 2;
		with: 'Viaje: '.

	aCanvas heading
		level: 4;
		with: mensaje.
]
