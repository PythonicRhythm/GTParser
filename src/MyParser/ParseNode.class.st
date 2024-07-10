Class {
	#name : #ParseNode,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #MyParser
}

{ #category : #accessing }
ParseNode class >> from: anOrderedCollection [
	| temp |
	temp:= self new.
	temp data: ('' join: anOrderedCollection).
	^temp
]

{ #category : #'as yet unclassified' }
ParseNode >> data: aString [ 
	data := aString
]
