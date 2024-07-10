Class {
	#name : #Whitespace,
	#superclass : #ParseNode,
	#instVars : [
		'trim'
	],
	#category : #MyParser
}

{ #category : #accessing }
Whitespace class >> trim: anOrderedCollection [
	^ anOrderedCollection do: [:each | Transcript show: each; cr].
]
