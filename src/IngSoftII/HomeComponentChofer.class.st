Class {
	#name : #HomeComponentChofer,
	#superclass : #HomeComponent,
	#category : #'IngSoftII-ui'
}

{ #category : #rendering }
HomeComponentChofer >> renderContentOn: aCanvas [
	"super renderContentOn: aCanvas."

	aCanvas paragraph: (BasicComponent newWithParent: self andHome: HomeComponentChofer new)
]
