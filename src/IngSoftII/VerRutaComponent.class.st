Class {
	#name : #VerRutaComponent,
	#superclass : #WAComponent,
	#instVars : [
		'mensaje',
		'eliminar',
		'viajes'
	],
	#category : #'IngSoftII-ui-Admin'
}

{ #category : #'as yet unclassified' }
VerRutaComponent >> chequearVacio [
| rutas |
	rutas := Sistema soleInstance rutas.
	rutas ifEmpty: [ mensaje:='No existen rutas cargadas en el sistema.' ]
]

{ #category : #ruta }
VerRutaComponent >> eliminarRuta: unaRuta [
	viajes := Sistema soleInstance eliminarRuta: unaRuta.
	viajes
		ifNil: [ mensaje := 'La ruta: ' , unaRuta nombre
				, ' ha sido eliminada con éxito' ]
		ifNotNil: [ mensaje := 'No se puede eliminar la ruta ' , unaRuta nombre
				, ' porque esta asignada a 1 o más viajes']
			"(self
				confirm:
					'La ruta que intenta borrar tiene uno o mas viajes asignados, desea ver estos viajes?')
				ifTrue: [ self call: (VerViajesComponent newWithViajes: viajes).
					eliminar := false ] ]"
]

{ #category : #initialization }
VerRutaComponent >> initialize [
	super initialize.
	mensaje := ' '.
	eliminar := true.
	viajes:=nil.
]

{ #category : #rendering }
VerRutaComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: (BasicComponent newWithParent: self andHome: HomeComponentAdmin new).
	aCanvas heading
		level: 2;
		with: 'Rutas: '.
	self chequearVacio.
	aCanvas heading
		level: 4;
		with: mensaje.
	"eliminar
		ifFalse: [ (self
				confirm:
					'La ruta que intenta borrar tiene uno o mas viajes asignados, desea ver estos viajes?')
				ifTrue: [ self call: (VerViajesComponent newWithViajes: viajes)]]."
	self renderRutasOn: aCanvas
]

{ #category : #rendering }
VerRutaComponent >> renderRutasOn: aCanvas [
	| rutas |
	rutas := Sistema soleInstance rutas.
	^ aCanvas
		form: [ aCanvas
				unorderedList: [ rutas
						do: [ :each | 
							aCanvas
								listItem: [ aCanvas
										paragraph: [ aCanvas text: each nombre.
											aCanvas space.	"aCanvas anchor
								callback: [ self call: (self mostrarPasajero: each on: aCanvas) ];
								with: each nombre."
											aCanvas submitButton
												callback: [ self eliminarRuta: each ];
												with: 'Eliminar'.
											aCanvas submitButton
												callback: [ self
														call: (RutaComponent newWithObjetivo: 'modificar' andRuta: each) ];
												with: 'Modificar'  ].
									aCanvas break ] ] ].
			aCanvas horizontalRule.
			aCanvas submitButton
				callback: [ self answer ];
				with: 'Volver' ]
]
