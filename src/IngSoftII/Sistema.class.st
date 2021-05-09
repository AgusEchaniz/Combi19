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

{ #category : #accessing }
Sistema >> CrearViajeWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos [
	
]

{ #category : #combi }
Sistema >> agregarCombiWithPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantAsientos andChofer: unChofer [
	| combi |
	(self existeCombi: unaPatente)
		ifFalse: [ combis
				add:
					(combi := Combi
						newWithPatente: unaPatente
						andTipo: unTipo
						andCantAsientos: unaCantAsientos
						andChofer: unChofer).
			
			^ combi ].
	^ nil

	"patente tipo chofer cantidadAsientos"
]

{ #category : #insumo }
Sistema >> agregarInsumoWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio [
|insumo|
	(self existeInsumo: unNombre)
		ifFalse: [ insumos
				add: (insumo:=Insumo newWithNombre: unNombre andTipo: unTipo andPrecio: unPrecio) .^insumo].
			^nil
]

{ #category : #lugar }
Sistema >> agregarLugarWithLocalidad: unaLocalidad  andProvincia: unaProvincia [ 
	| lugar  |
	(self existeLocalidad:unaLocalidad  paraProv:unaProvincia )
		ifFalse: [ lugares
				add:
					(lugar := Lugar 
						newWithLocalidad: unaLocalidad
						andProvincia: unaProvincia).
			^ lugar ].
	^ nil
]

{ #category : #ruta }
Sistema >> canBeRuta:unaRuta enFecha:unaFecha [
viajes detect:[:viaje| viaje tieneRuta:unaRuta enFecha:unaFecha]
ifFound:[^false]
ifNone:[^true]
]

{ #category : #combi }
Sistema >> choferesDisponibles [
	^(usuarios select: [ :usuario | usuario es: 'chofer' ]) reject: [ :chofer | chofer estaAsignado ]
]

{ #category : #accessing }
Sistema >> combis [
	^combis
]

{ #category : #accessing }
Sistema >> combisDisponiblesEnHorario: unHorario [
	| combisNoDisponibles |
	combisNoDisponibles := (rutas
		select: [ :ruta | ruta tieneHorario: unHorario ])
		collect: [ :ruta | ruta combi ].

	 ^combis	reject: [:combi | combisNoDisponibles includes: combi]
]

{ #category : #utility }
Sistema >> crearAdmin [
	usuarios
		add: (Administrador
		newWithNombreUsuario: 'admin@admin.com'
		andContraseña: 'admin'
		andNombre: 'Matias'
		andApellido: 'Ocares')
]

{ #category : #ruta }
Sistema >> crearProvincias [
	provincias
		add: 'Buenos Aires';
		add: 'Entre Rios';
		add: 'Corrientes';
		add: 'Misiones';
		add: 'Formosa';
		add: 'La Pampa';
		add: 'Salta';
		add: 'Tucuman';
		add: 'Jujuy';
		add: 'Chaco';
		add: 'Santiago del Estero';
		add: 'Catamarca';
		add: 'La Rioja';
		add: 'Cordoba';
		add: 'Santa fe';
		add: 'San Juan';
		add: 'Mendoza';
		add: 'Rio Negro';
		add: 'San Luis';
		add: 'Neuquen';
		add: 'Santa Cruz';
		add: 'Chubut';
		add: 'Tierra Del Fuego';
		add:'C.A.B.A'
]

{ #category : #ruta }
Sistema >> crearRutaWithLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	| ruta |
	unLugarOrigen = unLugarDestino
		ifTrue: [ ^ false ].
	(self puedeSerCombi: unaCombi enHorario: unHorario)
		ifTrue: [ rutas
				add:
					(ruta := Ruta
						newWithLugarOrigen: unLugarOrigen
						andLugarDestino: unLugarDestino
						andCombi: unaCombi
						andHorario: unHorario
						andDistancia: unaDistancia).
			^ ruta ].
	^ nil
]

{ #category : #chofer }
Sistema >> crearUsuarioChoferWithNombreDeUsuario: unNombreDeUsuario andContraseña: unaContraseña andNombre: unNombre andApellido: unApellido andTelefono:unTelefono [
	| chofer |
	(self
		puedeSerChofer: unNombreDeUsuario conContraseña: unaContraseña )
		ifTrue: [ usuarios 
				add:
					(chofer := Chofer 
						newWithNombreDeUsuario: unNombreDeUsuario
						andContraseña: unaContraseña
						andNombre: unNombre
						andApellido: unApellido
						andTelefono:unTelefono).
			^ chofer ].
	^ nil
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

{ #category : #viaje }
Sistema >> crearViajeWithRuta: unaRuta andFecha: unaFecha andCantidadAsientos: unaCantidadAsientos [
	| viaje |
	(self puedeSerViajeConRuta: unaRuta andFecha: unaFecha)
		ifTrue: [ viajes
				add:
					(viaje := Viaje
						newWithRuta: unaRuta
						andFecha: unaFecha
						andCantidadAsientos: unaCantidadAsientos). ^viaje ].
					^nil
]

{ #category : #chofer }
Sistema >> eliminarChofer: unChofer [
	"chofer no debe estar asignado a ninguna combi"

	(self sePuedeEliminarChofer: unChofer)
		ifTrue: [ usuarios remove: unChofer. ^true ].
		^false
]

{ #category : #combi }
Sistema >> eliminarCombi: unaCombi [
"combi no debe estar asignada a una ruta(ni tener un chofer asignado?)"
	combis remove: unaCombi
]

{ #category : #insumo }
Sistema >> eliminarInsumo:unInsumo [
insumos remove:unInsumo
]

{ #category : #lugar }
Sistema >> eliminarLugar: unLugar [
	lugares remove: unLugar
]

{ #category : #ruta }
Sistema >> eliminarRuta: unaRuta [
|viajesIncluyenRuta|
	(viajesIncluyenRuta:=viajes select: [ :viaje | viaje incluyeRuta: unaRuta ])
		ifEmpty: [ rutas remove: unaRuta.
			^ nil ]
		ifNotEmpty: [ ^ viajesIncluyenRuta  ]
]

{ #category : #usuario }
Sistema >> eliminarUsuario: unUsuario [
	usuarios remove: unUsuario ifAbsent:[].
	(viajes select: [ :viaje | viaje incluyenPasajero: unUsuario ])
		do: [ :viaje | viaje eliminarPasajero: unUsuario ]
]

{ #category : #viaje }
Sistema >> eliminarViaje: unViaje [
	viajes remove: unViaje.
	^unViaje cantidadVendidos.
]

{ #category : #usuario }
Sistema >> esMayorDeEdad: unaFecha [
	^ (Date today - unaFecha)asDays/365 >= 18
]

{ #category : #usuario }
Sistema >> esValidaContraseña: unaContraseña [
^unaContraseña size >=6
]

{ #category : #combi }
Sistema >> existeCombi: unaPatente [
	combis
		detect: [ :combi | combi patente = unaPatente]
		ifFound: [ ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #insumo }
Sistema >> existeInsumo: unNombre [

insumos detect:[:insumo |insumo es:unNombre ]
ifFound:[^true]
ifNone:[^false]
]

{ #category : #lugar }
Sistema >> existeLocalidad: unaLocalidad paraProv: unaProvincia [
	^(lugares select: [ :lugar | lugar localidadEs:unaLocalidad ])
	anySatisfy: [ :lugar | lugar provinciaEs:unaProvincia  ]
	
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
	provincias := OrderedCollection new.
	self crearProvincias

]

{ #category : #insumo }
Sistema >> insumos [
^insumos

]

{ #category : #lugar }
Sistema >> lugares [ ^lugares
]

{ #category : #chofer }
Sistema >> modificarChofer: unChofer withNombre: unNombre	andApellido: unApellido	andTelefono: unTelefono [
	
unChofer
				modificarWithNombre: unNombre
				andApellido: unApellido
				andTelefono: unTelefono.


]

{ #category : #chofer }
Sistema >> modificarChofer: unChofer withNombreUsuario: unNombreUsuario andNombre: unNombre andApellido: unApellido andTelefono: unTelefono [
	| chofer  |
	(self existeUsuario: unNombreUsuario)
		ifFalse: [ chofer := unChofer
				modificarWithNombreUsuario: unNombreUsuario
				andNombre:unNombre 
				andApellido: unApellido 
				andTelefono: unTelefono.
			^ chofer ].
	^ nil
	
]

{ #category : #combi }
Sistema >> modificarCombi: unaCombi withPatente: unaPatente andTipo: unTipo andCantAsientos: unaCantidad andChofer:unChofer [
	| combi |
	(self existeCombi: unaPatente)
		ifFalse: [ combi := unaCombi
				modificarWithPatente: unaPatente
				andTipo: unTipo
				andCantAsientos: unaCantidad
				andChofer:unChofer.
			^ combi ].
	^ nil
]

{ #category : #combi }
Sistema >> modificarCombi: unaCombi withTipo: unTipo andCantAsientos: unaCantidad andChofer:unChofer [
	unaCombi modificarWithTipo: unTipo andCantAsientos: unaCantidad andChofer:unChofer
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

{ #category : #insumo }
Sistema >> modificarInsumo: unInsumo withTipo: unTipo andPrecio: unPrecio [
unInsumo modificarWithTipo: unTipo andPrecio: unPrecio
]

{ #category : #lugar }
Sistema >> modificarLugar: unLugar withLocalidad: unaLocalidad andProvincia:unaProvincia [
	| lugar |
	(self existeLocalidad: unaLocalidad  paraProv:  unaProvincia )
		ifFalse: [ lugar := unLugar
				modificarWithLocalidad: unaLocalidad
				andProvincia:unaProvincia.
			^ lugar ].
	^ nil
	

]

{ #category : #lugar }
Sistema >> modificarLugar: unLugar withProvincia: unaProvincia [
 unLugar modificarWithProvincia: unaProvincia.


]

{ #category : #chofer }
Sistema >> modificarRuta: unaRuta withCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	unaRuta modificarCombi: unaCombi andHorario: unHorario  andDistancia: unaDistancia
	
]

{ #category : #ruta }
Sistema >> modificarRuta: unaRuta withLugarOrigen: unLugarOrigen andLugarDestino: unLugarDestino andCombi: unaCombi andHorario: unHorario andDistancia: unaDistancia [
	| ruta |
	(self
		noPuedeSerRutaConOrigen: unLugarOrigen
		andUnDestino: unLugarDestino
		andHorario: unHorario
		andCombi: unaCombi)
		ifTrue: [ (self puedeSerCombi: unaCombi enHorario: unHorario)
				ifTrue: [ ruta := unaRuta
						modificarRutaWithLugarOrigen: unLugarOrigen
						andLugarDestino: unLugarDestino
						andCombi: unaCombi
						andHorario: unHorario
						andDistancia: unaDistancia.
					^ ruta ] ].
	^ nil
]

{ #category : #ruta }
Sistema >> noPuedeSerRutaConOrigen: unLugarOrigen
		andUnDestino: unLugarDestino
		andHorario: unHorario
		andCombi: unaCombi [
		
^(	rutas select:[:ruta | ruta tieneOrigen: unLugarOrigen
		andUnDestino: unLugarDestino
		andHorario: unHorario])anySatisfy:[:ruta| ruta tieneCombi:unaCombi]
]

{ #category : #lugar }
Sistema >> provincias [
	^ provincias asSortedCollection: [:provincia1 :provincia2 | provincia1 <= provincia2  ]
]

{ #category : #chofer }
Sistema >> puedeSerChofer: unNombreDeUsuario conContraseña: unaContraseña [ 
	(self existeUsuario: unNombreDeUsuario)
		ifFalse: [ (self esValidaContraseña: unaContraseña)
				ifTrue: [ ^ true ] ] .
	^ false
]

{ #category : #chofer }
Sistema >> puedeSerCombi: unaCombi enHorario: unHorario [
	^(self combisDisponiblesEnHorario: unHorario) includes: unaCombi
]

{ #category : #usuario }
Sistema >> puedeSerUsuario: unNombreDeUsuario conContraseña: unaContraseña conFechaNac: unaFecha [
	
	(self existeUsuario: unNombreDeUsuario)
		ifFalse: [ (self esValidaContraseña: unaContraseña)
				ifTrue: [ (self esMayorDeEdad: unaFecha)
						ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #viaje }
Sistema >> puedeSerViajeConRuta: unaRuta andFecha: unaFecha [
	viajes detect: [:viaje | viaje tieneRuta: unaRuta enFecha: unaFecha]  ifFound:[^false ] ifNone: [^true  ]
	
]

{ #category : #ruta }
Sistema >> rutas [
^rutas
]

{ #category : #'as yet unclassified' }
Sistema >> sePuedeEliminarChofer: unChofer [
^( combis anySatisfy: [ :combi| combi tieneChofer:unChofer ])not
]

{ #category : #viaje }
Sistema >> sePuedeEliminarViaje: unViaje [
^ (unViaje tieneFecha: Date today)not
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

{ #category : #viaje }
Sistema >> viajes [
^viajes
]
