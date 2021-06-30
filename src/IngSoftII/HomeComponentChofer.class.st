Class {
	#name : #HomeComponentChofer,
	#superclass : #HomeComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
HomeComponentChofer >> renderContentOn: aCanvas [
	| proxViajeChofer viajesChofer viajesPendientesChofer |
	viajesPendientesChofer := Sistema soleInstance
		obtenerViajesPendientesChofer: self session user.
	viajesChofer := Sistema soleInstance
		obtenerViajesChofer: self session user.
	"	viajesPendientesChofer"
	viajesPendientesChofer
		ifNotEmpty: [ proxViajeChofer := ((viajesPendientesChofer
				select: [ :each | each estado = 'pendiente' ])
				sort: [ :viajeA :viajeB | 
					viajeA fechaCompleta < viajeB fechaCompleta
						"& (viajeA ruta horario < viajeB ruta horario)" ]) first	"viajesPendientesChofer" ].

	"super renderContentOn: aCanvas."
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas anchor
		callback: [ self call: (VerViajesChoferComponent newWithViajes: viajesChofer) ];
		with: [ aCanvas button: 'Ver viajes' ].
	"para probar: "
	aCanvas anchor
		callback: [ self call: RegistrarSintomasComponent new ];
		with: [ aCanvas button: 'Registrar sintomas' ].
	aCanvas horizontalRule.
	viajesChofer
		detect: [ :viaje | viaje estado = 'En curso' ]
		ifFound: [ :viaje | 
			aCanvas heading: 'Viaje iniciado:'.
			aCanvas break.
			self renderProxViajeOn: aCanvas paraViaje: viaje ]
		ifNone: [  ].
	aCanvas heading: 'Proximo Viaje'.
	aCanvas break.
	proxViajeChofer
		ifNil: [ aCanvas strong: 'No tiene viajes pendientes asignados' ]
		ifNotNil: [ self renderProxViajeOn: aCanvas paraViaje: proxViajeChofer ]
]

{ #category : #rendering }
HomeComponentChofer >> renderProxViajeOn: aCanvas paraViaje: proxViajeChofer [
	aCanvas
		strong:
			'Viaje ' , proxViajeChofer ruta lugarOrigen nombre asString , ' a '
				, proxViajeChofer ruta lugarDestino nombre asString.
	aCanvas break.
	aCanvas
		text: 'Asientos vendidos:' , proxViajeChofer cantidadVendidos printString.
	aCanvas space.
	aCanvas
		text:
			'Asientos Disponibles:'
				, proxViajeChofer cantidadAsientosDisponibles printString.
	aCanvas break.
	aCanvas
		text:
			'Fecha: ' , proxViajeChofer fecha printString , ' Horario: '
				, proxViajeChofer ruta horario printString.
	aCanvas break.
	proxViajeChofer estado = 'En curso'
		ifTrue: [ aCanvas anchor
				callback: [proxViajeChofer finalizar];
				with: [ aCanvas button: 'Finalizar viaje' ] ].
	(DateAndTime now - proxViajeChofer fechaCompleta) abs
		<=
			(Duration
				days: 0
				hours: 0
				minutes: 15
				seconds: 0)
		ifTrue: [ aCanvas anchor
				callback: [ self
						call: (DetalleViajeChoferComponent newWithViaje: proxViajeChofer) ];
				with: [ aCanvas button: 'Ver detalle viaje' ] ]
]
