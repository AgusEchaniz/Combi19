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
	(self existeInsumo: unNombre)
		ifFalse:
			[ insumos add:(Insumo newWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio )]
]

{ #category : #usuario }
Sistema >> crearUsuarioPasajeroWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andFechaNacimiento: unaFecha andNombre: unNombre andApellido: unApellido andDni: unDni [
	|usuario|
	(self
		puedeSerUsuario: unNombreDeUsuario
		conContraseña: unaContraseña
		conFechaNac: unaFecha)
		ifTrue: [ usuarios
				add:
					(usuario:=Pasajero
						newWithNombreDeUsuario: unNombreDeUsuario
						andContraseña: unaContraseña
						andFechaNacimiento: unaFecha
						andNombre: unNombre
						andApellido: unApellido
						andDni: unDni). ^usuario ].
^nil
					
				
]

{ #category : #insumo }
Sistema >> eliminarInsumo:unInsumo [
insumos remove:unInsumo
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
	 usuarios detect: [ :usuario | usuario es: unNombreDeUsuario ]
	ifFound:[^true]
	ifNone:[^false]
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
Sistema >> modificarInsumo:unInsumo withNombre: unNombre andTipo: unTipo andPrecio: unPrecio [
	unInsumo modificarWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio
]

{ #category : #usuario }
Sistema >> puedeSerUsuario: unNombreDeUsuario conContraseña: unaContraseña conFechaNac: unaFecha [
	(self existeUsuario: unNombreDeUsuario)
		ifFalse:  [ (self esValidaContraseña: unaContraseña)
				ifTrue: [ (self esMayorDeEdad: unaFecha)
						ifTrue: [ ^ true ] ] ].
	^ false
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
