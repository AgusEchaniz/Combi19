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
	#category : #'IngSoftII-model'
}

{ #category : #'as yet unclassified' }
Sistema >> agregarInsumoWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio [
(	self existeInsumo:unNombre ) ifFalse:[Insumo newWithNombre: unNombre
		andTipo: unTipo
		andPrecio: unPrecio]
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
Sistema >> eliminarInsumo:unInsumo [
insumos remove:unInsumo
]

{ #category : #'as yet unclassified' }
Sistema >> eliminarUsuario:unUsuario [
	usuarios remove:unUsuario.
(	viajes select:[:viaje| viaje incluyenPasajero:unUsuario]) do:[:viaje| viaje eliminarPasajero:unUsuario].
]

{ #category : #'as yet unclassified' }
Sistema >> esMayorDeEdad: unaFecha [
	^ (Date today - unaFecha)asDays/365 >= 18
]

{ #category : #'as yet unclassified' }
Sistema >> esValidaContraseña: unaContraseña [
^unaContraseña size >=6
]

{ #category : #'as yet unclassified' }
Sistema >> existeInsumo: unNombre [

insumos detect:[:insumo |insumo es:unNombre ]
ifFound:[^true]
ifNone:[^false]
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
Sistema >> puedeSerUsuario: unNombreDeUsuario conContraseña: unaContraseña conFechaNac: unaFecha [
	(self existeUsuario: unNombreDeUsuario)
		ifFalse:  [ (self esValidaContraseña: unaContraseña)
				ifTrue: [ (self esMayorDeEdad: unaFecha)
						ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #accessing }
Sistema >> usuarios [
^usuarios
]
