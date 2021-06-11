"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftII,
	#superclass : #PackageManifest,
	#category : #'IngSoftII-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftII class >> ruleRBAssignmentInIfTrueRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DatosPasajeroComponent #renderInputElementsOn: #false)) #'2021-06-11T02:37:38.777541-03:00') )
]
