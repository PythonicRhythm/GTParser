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
		'variable',
		'expression',
		'term',
		'factor'
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
	^ whitespace optional,
	(variable, ':' asPParser,  whitespace, (numbers / string)) ==> [:n | Assignment from: n]
]

{ #category : #accessing }
MyParser >> expression [
	^ whitespace optional,
	(
		(term, whitespace optional, '+' asPParser, whitespace optional, term) /
		(term, whitespace optional, '-' asPParser, whitespace optional, term) /		 
		(term)
	 ),
	 whitespace optional
 ==> [:n | Expression from: n]
]

{ #category : #accessing }
MyParser >> expressionTest [
	<gtExample>
	^
	MyParser parse: '-4 * (   5 +  (  5  /  (  25  *  5  ))  )' startingAt: #expression
]

{ #category : #accessing }
MyParser >> expressions [
	"Expressions resembles assignment, mathematical, and functional expressions "
	^ (
		(assignment, whitespace optional, ';' asPParser) /
		(expression, whitespace optional, ';' asPParser) /
		(letAndNum, whitespace optional, ';' asPParser) /
		whitespace
	) plus
]

{ #category : #accessing }
MyParser >> factor [
	^
	(
		variable/
		numbers /
		('(' asPParser, expression, ')' asPParser) /
		('-' asPParser, whitespace optional, factor)
	)
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
	^ expressions ==> [:n | n collect: [:e | e at: 1]]
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
MyParser >> term [
	| temp |
	temp:= [:s | (factor, whitespace optional, s asPParser, whitespace optional, term)].
	^(
		(temp value: '*') /
		(temp value: '/') /
		(temp value: '%') /
		factor
	)
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
