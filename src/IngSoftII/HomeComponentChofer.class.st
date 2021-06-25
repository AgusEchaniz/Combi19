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
	viajesPendientesChofer
		ifNotEmpty: [ proxViajeChofer := ((viajesPendientesChofer
				select: [ :each | each estado = 'pendiente' ])
				sort: [ :viajeA :viajeB | 
					viajeA fecha < viajeB fecha
						& (viajeA ruta horario < viajeB ruta horario) ]) first ].

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
	proxViajeChofer
		ifNil: [ aCanvas strong: 'No tiene viajes pendientes asignados' ]
		ifNotNil: [ self renderProxViajeOn: aCanvas paraViaje: proxViajeChofer ]
]

{ #category : #rendering }
HomeComponentChofer >> renderProxViajeOn: aCanvas paraViaje: proxViajeChofer [
	aCanvas heading: 'Proximo Viaje'.
	aCanvas break.
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
	DateAndTime now minute - proxViajeChofer horario minute <= 15
		ifTrue: [ aCanvas anchor
				callback: [ self
						call: (DetalleViajeChoferComponent newWithViaje: proxViajeChofer) ];
				with: [ aCanvas button: 'Ver proximo viaje' ] ]
]
