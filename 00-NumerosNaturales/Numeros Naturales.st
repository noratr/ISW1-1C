!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:14:24'!
* unFactor

	^unFactor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:25:43'!
+ unSumando

	^unSumando next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:14:19'!
- unSustraendo

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:24:01'!
/ unDivisor

	unDivisor == self ifTrue: [^self] ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.].! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:12:47'!
> unNumero

	^false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:22:18'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	
	^'No se puede dividir por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:19:12'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'Numeros negativos y cero no soportados'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:25:43'!
next

	^II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:26:57'!
restarA: unMinuendo

	^unMinuendo previous.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:48:41'!
* unFactor

	^self previous * unFactor + unFactor.! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:24:29'!
+ unSumando

	^self previous + unSumando next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:22:53'!
- unSustraendo

	^unSustraendo restarA: self.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:28:01'!
/ unDivisor

	| dividendoRestado |
	unDivisor > self ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.].
	self == unDivisor ifTrue: [^I].
	unDivisor + unDivisor > self ifTrue: [^I].
	dividendoRestado _ self - unDivisor.
	dividendoRestado > unDivisor ifTrue: [^(dividendoRestado / unDivisor) next.] ifFalse: [^II].! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:15:10'!
> unNumero

	^(self isDescendantOf: unNumero) or: [unNumero == I].! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:22:27'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	
	^'No se puede dividir por un numero mayor'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:27:35'!
next

	next ifNil:[
		next _ self createChildNamed: self name, 'I'.
		next previous: self.
		].
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:24:51'!
previous

	^previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:24:29'!
restarA: unMinuendo

	^unMinuendo previous - self previous.
	! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'jpf 4/6/2021 22:25:19'!
previous: unNumero

	previous _ unNumero.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIII.
	previous := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numeros Naturales'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIII.
	previous := IIIIIIII.! !


!classDefinition: #IIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIII.
	previous := IIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIII.
	previous := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIII.
	previous := IIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIII subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIII.
	previous := IIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIII subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jpf 4/7/2021 19:29:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIIIIIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!