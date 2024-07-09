Class {
	#name : #BaselineOfGTParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTParser
}

{ #category : #loading }
BaselineOfGTParser class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'GTParser' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGTParser >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GTParser'
		]
]
