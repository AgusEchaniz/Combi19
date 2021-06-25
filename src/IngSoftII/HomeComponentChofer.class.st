Class {
	#name : #HomeComponentChofer,
	#superclass : #HomeComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
HomeComponentChofer >> renderContentOn: aCanvas [
	"super renderContentOn: aCanvas."

	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	aCanvas anchor
		callback: [ self
				call:
					(VerViajesChoferComponent
						newWithViajes: (Sistema soleInstance obtenerViajesChofer: self session user)) ];
		with: [ aCanvas button: 'Ver viajes' ].
		"para probar: "
		aCanvas anchor
		callback: [ self
				call:
					(RegistrarSintomasComponent new) ];
		with: [ aCanvas button: 'Registrar sintomas' ]
]
