Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombreUsuario',
		'contraseña',
		'nombre',
		'apellido'
	],
	#category : #'IngSoftII-model'
}

{ #category : #accessing }
Usuario >> apellido [ 
	^apellido
]

{ #category : #accessing }
Usuario >> contraseña [
	^ contraseña
]

{ #category : #'as yet unclassified' }
Usuario >> es:unTipo [
^self soy=unTipo
]

{ #category : #initialization }
Usuario >> initializeWithNombreDeUsuario: unNombreDeUsuario
		andContraseña: unaContraseña
		andNombre: unNombre
		andApellido: unApellido [
		
	nombreUsuario :=unNombreDeUsuario .
	contraseña :=unaContraseña .
	nombre :=unNombre .
	apellido:=unApellido 
]

{ #category : #accessing }
Usuario >> nombre [ ^nombre
]

{ #category : #accessing }
Usuario >> nombreUsuario [
^nombreUsuario
]

{ #category : #accessing }
Usuario >> pertenezcoAlViaje: unViaje [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
Usuario >> seLlama: unNombreDeUsuario [
	^ unNombreDeUsuario asUppercase = nombreUsuario asUppercase	
]

{ #category : #'as yet unclassified' }
Usuario >> soy [
self subclassResponsibility 
]
