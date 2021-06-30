Class {
	#name : #VenderViajeComponent,
	#superclass : #WAComponent,
	#category : #'IngSoftII-ui-Chofer'
}

{ #category : #rendering }
VenderViajeComponent >> renderContentOn: aCanvas [
	aCanvas
		paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new).
	"aCanvas heading
		level: 2;
		with: 'Viajes: '."
]
