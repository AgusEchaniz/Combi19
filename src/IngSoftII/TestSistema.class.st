Class {
	#name : #TestSistema,
	#superclass : #TestCase,
	#instVars : [
		'sistema'
	],
	#category : #'IngSoftII-test'
}

{ #category : #running }
TestSistema >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	sistema:=Sistema new.
]

{ #category : #tests }
TestSistema >> testCrearUsuarioPasajero [
	| usuario usuario1 usuario2 |
	usuario := sistema
		crearUsuarioPasajeroWithNombreDeUsuario: 'hugo@gmail.com'
		andContraseña: '123456789'
		andFechaNacimiento: (Date year: 2000 month: 5 day: 1)
		andNombre: 'Hugo'
		andApellido: 'Perez'
		andDni: '34567754'
		andMembresia:MembresiaBasica  new.
	self assert: (sistema usuarios includes: usuario).
	usuario1 := sistema
		crearUsuarioPasajeroWithNombreDeUsuario: 'hugo@gmail.com'
		andContraseña: '123456789'
		andFechaNacimiento: (Date year: 2000 month: 5 day: 1)
		andNombre: 'Hugo'
		andApellido: 'Perez'
		andDni: '34567754'
		andMembresia:MembresiaBasica  new.
	self deny: (sistema usuarios includes: usuario1).
	usuario2 := sistema
		crearUsuarioPasajeroWithNombreDeUsuario: 'mario@gmail.com'
		andContraseña: '1234'
		andFechaNacimiento: (Date year: 2000 month: 5 day: 1)
		andNombre: 'mario'
		andApellido: 'Perez'
		andDni: '34567754'
		andMembresia:MembresiaBasica  new.
	self deny: (sistema usuarios includes: usuario2).
	usuario1 := sistema
		crearUsuarioPasajeroWithNombreDeUsuario: 'hugo@gmail.com'
		andContraseña: '123456789'
		andFechaNacimiento: (Date year: 2010 month: 5 day: 1)
		andNombre: 'Hugo'
		andApellido: 'Perez'
		andDni: '34567754'
		andMembresia:MembresiaBasica  new.
	self deny: (sistema usuarios includes: usuario1)
]
