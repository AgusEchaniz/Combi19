Class {
	#name : #SessionWithUser,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'IngSoftII-ui'
}

{ #category : #accessing }
SessionWithUser >> user [
	^ user
]

{ #category : #accessing }
SessionWithUser >> user: aUser [
	user := aUser
]
