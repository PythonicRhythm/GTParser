Class {
	#name : #MyParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'letters',
		'numbers',
		'letAndNum',
		'symbols',
		'operator',
		'whitespace',
		'assignment',
		'expressions',
		'string',
		'variable'
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
MyParser >> assignment [
	^ (variable, ':' asPParser,  whitespace, (numbers / string), ';' asPParser) ==> [:n | Assignment from: n]
]

{ #category : #accessing }
MyParser >> expressions [
	^ ( assignment/ letAndNum) plus
]

{ #category : #accessing }
MyParser >> letAndNum [
	^ (letters / numbers / operator/ whitespace) plus
]

{ #category : #accessing }
MyParser >> letters [
	^ (#letter asPParser plus) ==> [:n | Letters from: n]
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
	^ expressions
]

{ #category : #accessing }
MyParser >> string [
	^ ('"' asPParser, letters, #any asPParser starLazy, '"' asPParser) ==> [:n | StringType from: n]
]

{ #category : #accessing }
MyParser >> symbols [
	^ ('+' asPParser ) "/ ==> [:n | Symbols from: n]"
]

{ #category : #accessing }
MyParser >> variable [
	^ (
		((#letter asPParser, (letters / numbers / '_' asPParser) plus))
		/ (#letter asPParser)
	)
	==> [:n | VariableType from: n]
]

{ #category : #accessing }
MyParser >> whitespace [
	^ (#space asPParser plus) ==> [:n | Whitespace from: n]
]
