"
""LA PUTA MADREEEEE""
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	combis:		<Object>
	insumos:		<Object>
	lugares:		<Object>
	provincias:		<Object>
	rutas:		<Object>
	usuarios:		<Object>
	viajes:		<Object>


    Implementation Points
"
Class {
	#name : #Sistema,
	#superclass : #Object,
	#instVars : [
		'viajes',
		'rutas',
		'lugares',
		'insumos',
		'usuarios',
		'combis',
		'provincias'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : #'IngSoftII-model'
}

{ #category : #'as yet unclassified' }
Sistema class >> clearSoleInstance [
	soleInstance := nil
]

{ #category : #'as yet unclassified' }
Sistema class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self new ]
]

{ #category : #insumo }
Sistema >> agregarInsumoWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio [
|insumo|
	(self existeInsumo: unNombre)
		ifFalse: [ insumos
				add: (insumo:=Insumo newWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio) .^insumo].
			^nil
]

{ #category : #testing }
Sistema >> canBeRuta:unaRuta enFecha:unaFecha [
viajes detect:[:viaje| viaje tieneRuta:unaRuta enFecha:unaFecha]
ifFound:[^false]
ifNone:[^true]
]

{ #category : #accessing }
Sistema >> combis [
	^combis
]

{ #category : #accessing }
Sistema >> combisDisponiblesEnHorario: unHorario [
	|combisNoDisponibles|
	combisNoDisponibles := (rutas select: [ :ruta | ruta tieneHorario: unHorario ]) collect: [:ruta | ruta combi].
	^combis removeAll: combisNoDisponibles
]

{ #category : #'as yet unclassified' }
Sistema >> crearAdmin [
	usuarios
		add: (Administrador
		newWithNombreUsuario: 'admin@admin.com'
		andContraseña: 'admin'
		andNombre: 'Matias'
		andApellido: 'Ocares')
]

{ #category : #usuario }
Sistema >> crearRutaWithLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	| ruta |
	ruta := Ruta
		newWithLugarOrigen: unLugarOrigen
		andLugarDestino: unLugarDestino
		andCombi: unaCombi
		andHorario: unHorario
		andDistancia: unaDistancia.
		^ruta
]

{ #category : #usuario }
Sistema >> crearUsuarioPasajeroWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni andMembresia:unaMembresia [
	| usuario |
	(self
		puedeSerUsuario: unNombreDeUsuario
		conContraseña: unaContraseña
		conFechaNac: unaFecha)
		ifTrue: [ usuarios
				add:
					(usuario := Pasajero
						newWithNombreDeUsuario: unNombreDeUsuario
						andContraseña: unaContraseña
						andFechaNacimiento: unaFecha
						andNombre: unNombre
						andApellido: unApellido
						andDni: unDni andMembresia:unaMembresia).
			^ usuario ].
	^ nil
]

{ #category : #insumo }
Sistema >> eliminarInsumo:unInsumo [
insumos remove:unInsumo
]

{ #category : #usuario }
Sistema >> eliminarRuta: unaRuta [
	(viajes select: [ :viaje | viaje incluyeRuta: unaRuta ])
		ifEmpty: [ rutas remove: unaRuta. ^true ] ifNotEmpty: [^false]
]

{ #category : #usuario }
Sistema >> eliminarUsuario:unUsuario [
	usuarios remove:unUsuario.
(	viajes select:[:viaje| viaje incluyenPasajero:unUsuario]) do:[:viaje| viaje eliminarPasajero:unUsuario].
]

{ #category : #usuario }
Sistema >> esMayorDeEdad: unaFecha [
	^ (Date today - unaFecha)asDays/365 >= 18
]

{ #category : #usuario }
Sistema >> esValidaContraseña: unaContraseña [
^unaContraseña size >=6
]

{ #category : #insumo }
Sistema >> existeInsumo: unNombre [

insumos detect:[:insumo |insumo es:unNombre ]
ifFound:[^true]
ifNone:[^false]
]

{ #category : #usuario }
Sistema >> existeUsuario: unNombreDeUsuario [
	usuarios
		detect: [ :usuario | usuario seLlama:  unNombreDeUsuario ]
		ifFound: [ ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #initialization }
Sistema >> initialize [
	viajes := OrderedCollection new.
	rutas := OrderedCollection new.
	usuarios := OrderedCollection new.
	lugares := OrderedCollection new.
	insumos := OrderedCollection new.
	combis := OrderedCollection new.
	"llenar coleccion provincias"
]

{ #category : #insumo }
Sistema >> insumos [
^insumos

]

{ #category : #insumo }
Sistema >> modificarInsumo: unInsumo withNombre: unNombre andTipo: unTipo andPrecio: unPrecio [
	| insumo |
	(self
		existeInsumo: unNombre)
		ifFalse: [ insumo := unInsumo
				modificarWithNombre: unNombre
				andTipo: unTipo
				andPrecio: unPrecio.
			^ insumo ].
	^ nil
]

{ #category : #'as yet unclassified' }
Sistema >> puedeSerChofer: unNombreDeUsuario conContraseña: unaContraseña [ 
	(self existeUsuario: unNombreDeUsuario)
		ifFalse: [ (self esValidaContraseña: unaContraseña)
				ifTrue: [ ^ true ] ] .
	^ false
]

{ #category : #usuario }
Sistema >> puedeSerUsuario: unNombreDeUsuario conContraseña: unaContraseña conFechaNac: unaFecha [
	
	(self existeUsuario: unNombreDeUsuario)
		ifFalse: [ (self esValidaContraseña: unaContraseña)
				ifTrue: [ (self esMayorDeEdad: unaFecha)
						ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #accessing }
Sistema >> rutas [
^rutas
]

{ #category : #usuario }
Sistema >> userWithEmail: anEmail protectedBy: aPassword [
	^ usuarios
		detect:
			[ :usuario | usuario nombreUsuario = anEmail & (usuario contraseña = aPassword) ]
		ifNone: [ nil ]
]

{ #category : #usuario }
Sistema >> usuarios [
^usuarios
]
