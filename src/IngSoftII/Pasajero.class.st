Class {
	#name : #Pasajero,
	#superclass : #Usuario,
	#instVars : [
		'fechaNac',
		'dni',
		'membresia',
		'tarjeta',
		'nombreCompleto',
		'pasajes',
		'cambioMembresia',
		'fechaCambio',
		'rechazado',
		'rechazadoHasta'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'instance creation' }
Pasajero class >> newWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni andMembresia:unaMembresia [
	^ self new
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andFechaNacimiento: unaFecha
		andNombre: unNombre
		andApellido: unApellido
		andDni: unDni andMembresia:unaMembresia
]

{ #category : #'as yet unclassified' }
Pasajero >> agregarPasaje:unPasaje [
pasajes add:unPasaje
]

{ #category : #accessing }
Pasajero >> borrarTarjeta [
	tarjeta:= nil
]

{ #category : #accessing }
Pasajero >> cambiarMembresia [
	cambioMembresia
		ifTrue: [ fechaCambio < Date today
				ifTrue: [ membresia := MembresiaBasica new.
					self borrarTarjeta . cambioMembresia :=false] ]
]

{ #category : #accessing }
Pasajero >> cambioMembresia [
^cambioMembresia 
]

{ #category : #'as yet unclassified' }
Pasajero >> cancelarPasajesDelViaje: unViaje [
	|pasajesA|
	pasajesA :=self pasajesDelViaje: unViaje.
	pasajesA
		ifEmpty: [ ^ self ]
		ifNotEmpty: [pasajesA 	do: [ :pasaje | pasaje cancelarPasaje ] ]
]

{ #category : #'as yet unclassified' }
Pasajero >> cargarTarjetaWithNumero: unNumero andCodigoSeguridad: unCodigo andFechaVencimiento: unaFecha andNombre: unNombre [
	(self
		puedeSerTarjetaWithNumero: unNumero
		andFechaVencimiento: unaFecha)
		ifTrue: [ tarjeta:= Tarjeta
				newWithNumero: unNumero
				andCodigoSeguridad: unCodigo
				andFechaVencimiento: unaFecha
				andNombre: unNombre. ^tarjeta].
	^ nil
]

{ #category : #'as yet unclassified' }
Pasajero >> conCondicion: unaCondicion viajarA: unViaje [
	(unaCondicion = 'Rechazado por fiebre'
		or: unaCondicion = 'Rechazado por sintomas')
		ifTrue: [ self rechazarPasajesDelViaje: unViaje.
			unViaje rechazarPasajero: self ]
		ifFalse: [ unaCondicion = 'Ausente'
				ifTrue: [ self cancelarPasajesDelViaje: unViaje ]
				ifFalse: [ self iniciarViaje: unViaje ] ]
]

{ #category : #accessing }
Pasajero >> dni [
	^ dni
]

{ #category : #'as yet unclassified' }
Pasajero >> esNumeroValido: unNumero [
	^ unNumero asInteger asString size = 16
]

{ #category : #'as yet unclassified' }
Pasajero >> estaVigente: unaFecha [
	^ unaFecha  isOnOrAfter: Date today
]

{ #category : #accessing }
Pasajero >> fechaCambio [
^fechaCambio 
]

{ #category : #accessing }
Pasajero >> fechaNac [
	^ fechaNac
]

{ #category : #'as yet unclassified' }
Pasajero >> iniciarViaje: unViaje [
	| pasajesA |
	pasajesA := self pasajesDelViaje: unViaje.
	pasajesA
		ifNotEmpty: [ pasajesA do: [ :pasaje | pasaje iniciarPasaje ] ]
]

{ #category : #initialization }
Pasajero >> initializeWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni andMembresia: unaMembresia [
	self initialize
		initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido.
	fechaNac := unaFecha.
	dni := unDni.
	membresia := unaMembresia.
	pasajes := OrderedCollection new.
	cambioMembresia := false.
	rechazado:=false
]

{ #category : #accessing }
Pasajero >> membresia [
	^ membresia
]

{ #category : #accessing }
Pasajero >> membresia: unaMembresia [
membresia := unaMembresia 
]

{ #category : #'as yet unclassified' }
Pasajero >> modificarWithNombre: unNombre
				andApellido: unApellido
				andContraseña: unaContraseña
				andFechaNacimiento: unaFechaNac
				andDNI: unDNI [
	nombre := unNombre.
	apellido := unApellido.
	contraseña := unaContraseña.
	fechaNac := unaFechaNac.
	dni := unDNI
]

{ #category : #'as yet unclassified' }
Pasajero >> modificarWithNombreUsuario: unNombreUsuario andNombre: unNombre andApellido: unApellido andContraseña: unaContraseña andFechaNacimiento: unaFechaNac andDNI: unDNI [
	nombreUsuario := unNombreUsuario.
	nombre := unNombre.
	apellido:= unApellido.
	contraseña := unaContraseña .
	fechaNac := unaFechaNac .
	dni := unDNI
]

{ #category : #accessing }
Pasajero >> nombreCompleto [
^nombre,' ',apellido
]

{ #category : #accessing }
Pasajero >> pasajes [
	^ pasajes
		sort: [ :pasajeA :pasajeB | pasajeA viaje fecha < pasajeB viaje fecha ]
]

{ #category : #'as yet unclassified' }
Pasajero >> pasajesDelViaje: unViaje [
	^self pasajes select: [:pasaje | pasaje tieneViaje: unViaje  ]
]

{ #category : #accessing }
Pasajero >> pertenezcoAlViaje: unViaje [
	^ self tengoEsteViaje: unViaje
]

{ #category : #'as yet unclassified' }
Pasajero >> puedeSerTarjetaWithNumero: unNumero andFechaVencimiento: unaFecha [
	(self esNumeroValido: unNumero)
		ifTrue: [ (self estaVigente: unaFecha)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
Pasajero >> puedeSerUsuario: unNombreDeUsuario conContraseña: unaContraseña conFechaNac: unaFecha [
	self
		existeUsuario: unNombreDeUsuario
		ifFalse: [ self
				esValidaContraseña: unaContraseña
				ifTrue: [ self esMayorDeEdad: unaFecha ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #accessing }
Pasajero >> reanudarMembresia [

	cambioMembresia := false.

]

{ #category : #accessing }
Pasajero >> rechazado [
^rechazado
]

{ #category : #accessing }
Pasajero >> rechazadoHasta [
^rechazadoHasta
]

{ #category : #'as yet unclassified' }
Pasajero >> rechazar [
	rechazado:=true.
	rechazadoHasta:=Date today addDays: 14.
]

{ #category : #'as yet unclassified' }
Pasajero >> rechazarPasajesDelViaje: unViaje [
	| pasajesA |
	pasajesA := self pasajesDelViaje: unViaje.
	pasajesA
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ pasajesA do: [ :pasaje | pasaje rechazarPasaje ] ]
]

{ #category : #accessing }
Pasajero >> setearCambiarMembresia [
	| año mesSig primerDia |
	cambioMembresia := true.
	año := Date today year.
	mesSig := Date today monthIndex.
	primerDia := membresia fechaInicio dayOfMonth .
	fechaCambio := Date year: año month: mesSig day: primerDia.
	fechaCambio := fechaCambio addMonths: 1
]

{ #category : #'as yet unclassified' }
Pasajero >> soy [ 
^'pasajero'
]

{ #category : #accessing }
Pasajero >> tarjeta [
	^ tarjeta
]

{ #category : #'as yet unclassified' }
Pasajero >> tengoEsteViaje: unViaje [
	pasajes detect: [:pasaje | pasaje viaje = unViaje  ] ifFound:[^true]  ifNone: [^false]
]
