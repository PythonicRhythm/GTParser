Class {
	#name : #MyParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'letters',
		'numbers',
		'letAndNum',
		'symbols',
		'operator',
		'whitespace'
	],
	#category : #MyParser
}

{ #category : #accessing }
MyParser class >> noWhiteSpaceParse: aString [
	^ (self parse: aString) reject: [:o | o class = Whitespace]
]

{ #category : #accessing }
MyParser class >> trimParse: aString [
	^ (self parse: aString) allButFirst allButLast
]

{ #category : #accessing }
MyParser >> letAndNum [
	^ (letters / numbers / operator/ whitespace) plus
]

{ #category : #accessing }
MyParser >> letters [
	^ (#letter asPParser plus) ==> [:n | Letters from:n]
]

{ #category : #accessing }
MyParser >> numbers [
	^ (#digit asPParser plus) ==> [:n | Numbers from: n]
]

{ #category : #accessing }
MyParser >> operator [
	^ (('+' asPParser ) / ('-' asPParser) 
	/ ('/' asPParser) / ('*' asPParser) /
	('%' asPParser) / ('^' asPParser))
	==> [:n | Operator from: n]
]

{ #category : #accessing }
MyParser >> start [
	^ letAndNum
]

{ #category : #accessing }
MyParser >> symbols [
	^ ('+' asPParser ) "/ ==> [:n | Symbols from: n]"
]

{ #category : #accessing }
MyParser >> whitespace [
	^ (#space asPParser plus) ==> [:n | Whitespace from: n]
]
