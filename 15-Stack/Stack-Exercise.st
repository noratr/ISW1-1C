!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stackWith4Sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'JPF 4/26/2021 21:36:28'!
shouldLeaveTheStackWith4SentencesUnchanged
	
	self assert: stackWith4Sentences size = 4.
	self assert: stackWith4Sentences pop = 'Winter is here'.
	self assert: stackWith4Sentences pop = 'The winds of Winter'.
	self assert: stackWith4Sentences pop = 'winning is everything'.
	self assert: stackWith4Sentences pop = 'winter is coming'.

! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:25:06'!
test01FindShouldNotFindAnySentenceInAnEmptyStack
	
	| emptyStack sentenceFinder |
	
	emptyStack _ OOStack new.
	
	sentenceFinder _ SentenceFinderByPrefix with: emptyStack.
	
	self assert: (sentenceFinder find: 'the') = #().! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:25:37'!
test02FindShouldNotFindAnySentence
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self assert: (sentenceFinder find: 'the') = #().
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:26:52'!
test03FindShouldFindOneSentence
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self assert: (sentenceFinder find: 'Wint') = #('Winter is here').
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:27:13'!
test04FindShouldFindOneSentenceTwice
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self assert: (sentenceFinder find: 'Wint') = #('Winter is here').
	self assert: (sentenceFinder find: 'Wint') = #('Winter is here').
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:27:32'!
test05FindShouldFindMoreThanOneSentence
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self assert: (sentenceFinder find: 'win') = #('winning is everything' 'winter is coming').
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:27:53'!
test06FindShouldFindOneSentenceBecauseIsCaseSensitive
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self assert: (sentenceFinder find: 'Win') = #('Winter is here').
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:28:27'!
test07FindShouldFailWhenPrefixIsEmpty
	
	| sentenceFinder |

	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self
		should: [ sentenceFinder find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:28:48'!
test08FindShouldFailWhenPrefixHasEmptySpaces
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	self
		should: [ sentenceFinder find: 'Wint is' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithEmptySpaceErrorDescription ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:36:28'!
test09FindShouldLeaveTheStackUnchangedWhenASentenceIsFound
	
	| sentenceFinder |
	
	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	sentenceFinder find: 'Wint'.
	
	self shouldLeaveTheStackWith4SentencesUnchanged.

! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:36:28'!
test10FindShouldLeaveTheStackUnchangedWhenMoreThanOneSentenceIsFound
	
	| sentenceFinder |

	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences .
	
	sentenceFinder find: 'win'.
	
	self shouldLeaveTheStackWith4SentencesUnchanged.

! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JPF 4/26/2021 21:36:28'!
test11FindShouldLeaveTheStackUnchangedWhenDoNotFindAnySentence
	
	| sentenceFinder |

	sentenceFinder _ SentenceFinderByPrefix with: stackWith4Sentences.
	
	sentenceFinder find: 'Wix'.

	self shouldLeaveTheStackWith4SentencesUnchanged.

! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JPF 4/26/2021 21:24:27'!
setUp

	stackWith4Sentences _ OOStack new.
	stackWith4Sentences
		push: 'winter is coming';
		push: 'winning is everything';
		push: 'The winds of Winter';
		push: 'Winter is here'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'jpf 4/24/2021 10:56:00'!
initialize
	
	topElement _ EmptyOOStackElement new.
	size _ 0.! !


!OOStack methodsFor: 'testing' stamp: 'JPF 4/27/2021 21:27:26'!
isEmpty
	
	^ self size = 0.! !


!OOStack methodsFor: 'actions' stamp: 'JPF 4/27/2021 21:27:35'!
pop
	
	| poppedValue |
	
	poppedValue _ self top.
	topElement _ topElement belowElement.
	^ poppedValue.! !

!OOStack methodsFor: 'actions' stamp: 'JPF 4/26/2021 17:43:21'!
push: aValue
	
	| newElement |
	
	newElement _ RealOOStackElement withValue: aValue over: topElement.
	topElement _ newElement.
	! !


!OOStack methodsFor: 'accessing' stamp: 'JPF 4/27/2021 21:27:46'!
size
	
	^ topElement position.! !

!OOStack methodsFor: 'accessing' stamp: 'JPF 4/27/2021 21:27:51'!
top
	
	^ topElement value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'instance creation' stamp: 'jpf 4/24/2021 10:40:56'!
new
	^super new initialize.! !


!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'jpf 4/24/2021 11:13:32'!
belowElement
	
	self subclassResponsibility.! !

!OOStackElement methodsFor: 'accessing' stamp: 'JPF 4/26/2021 17:40:04'!
position

	self subclassResponsibility.! !

!OOStackElement methodsFor: 'accessing' stamp: 'jpf 4/24/2021 10:43:19'!
value
	
	self subclassResponsibility.! !


!classDefinition: #EmptyOOStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #EmptyOOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyOOStackElement methodsFor: 'accessing' stamp: 'JPF 4/27/2021 21:26:56'!
belowElement
	
	^ self.! !

!EmptyOOStackElement methodsFor: 'accessing' stamp: 'JPF 4/26/2021 17:40:30'!
position
	
	^ 0.! !

!EmptyOOStackElement methodsFor: 'accessing' stamp: 'JPF 4/27/2021 21:27:07'!
value

	self error: OOStack stackEmptyErrorDescription.
	! !


!classDefinition: #RealOOStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #RealOOStackElement
	instanceVariableNames: 'value belowElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealOOStackElement methodsFor: 'initialization' stamp: 'jpf 4/24/2021 11:06:24'!
initializeWith: aValue over: anElement.

	value _ aValue.
	belowElement _ anElement.

	! !


!RealOOStackElement methodsFor: 'accessing' stamp: 'JPF 4/27/2021 21:26:50'!
belowElement
	
	^ belowElement.! !

!RealOOStackElement methodsFor: 'accessing' stamp: 'JPF 4/26/2021 17:41:12'!
position
	
	^ belowElement position + 1.! !

!RealOOStackElement methodsFor: 'accessing' stamp: 'JPF 4/27/2021 21:26:44'!
value
	
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RealOOStackElement class' category: 'Stack-Exercise'!
RealOOStackElement class
	instanceVariableNames: ''!

!RealOOStackElement class methodsFor: 'instance creation' stamp: 'jpf 4/24/2021 11:03:50'!
withValue: aValue over: anElement
	
	^self new initializeWith: aValue over: anElement.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackOfSentencesToSearch auxiliarStackOfSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'validation' stamp: 'JPF 4/26/2021 20:59:47'!
validatePrefixToSearch: aPrefixToSearch
	
	self validatePrefixToSearchIsNotEmpty: aPrefixToSearch.
	self validatePrefixToSearchHasNotEmptySpaces: aPrefixToSearch.

	
	! !

!SentenceFinderByPrefix methodsFor: 'validation' stamp: 'JPF 4/26/2021 20:57:37'!
validatePrefixToSearchHasNotEmptySpaces: aPrefixToSearch
	
	(aPrefixToSearch indexOf: $ ) > 0 ifTrue: [self error: self class prefixWithEmptySpaceErrorDescription].
	
	! !

!SentenceFinderByPrefix methodsFor: 'validation' stamp: 'JPF 4/26/2021 20:57:11'!
validatePrefixToSearchIsNotEmpty: aPrefixToSearch
	
	aPrefixToSearch isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription].
	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JPF 4/26/2021 18:35:38'!
moveSentencesFrom: sourceStack to: targetStack selecting: aConditionToSelect

	| selectedSentences |
	
	selectedSentences _ OrderedCollection new.
	
	[ sourceStack isEmpty not ] whileTrue: [ | currentSentece |
		currentSentece _ sourceStack pop.
		targetStack push: currentSentece.
		(aConditionToSelect value: currentSentece) ifTrue: [
			selectedSentences add: currentSentece.
			].
		].
	
	^ selectedSentences.
	
	
	
	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JPF 4/26/2021 20:54:15'!
moveSentencesToAuxiliarStackSelectingTheOnesHavingPrefix: aPrefixToSearch

	^ self moveSentencesFrom: stackOfSentencesToSearch to: auxiliarStackOfSentences selecting: [:aSentence |
		self sentence: aSentence hasPrefix: aPrefixToSearch.
		].
	
	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JPF 4/26/2021 18:43:10'!
restoreStackOfSentencesToSearchFromAuxiliarStack

	self moveSentencesFrom: auxiliarStackOfSentences to: stackOfSentencesToSearch selecting: [:sentence | false].

	
	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JPF 4/26/2021 20:54:15'!
sentence: aSentence hasPrefix: aPrefix

	^ (aSentence commonPrefixWith: aPrefix) = aPrefix size.

	
	! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'JPF 4/27/2021 21:28:03'!
find: aPrefixToSearch

	| matchSentences |
	
	self validatePrefixToSearch: aPrefixToSearch.
	
	matchSentences _ self moveSentencesToAuxiliarStackSelectingTheOnesHavingPrefix: aPrefixToSearch.
	
	self restoreStackOfSentencesToSearchFromAuxiliarStack.
	
	^ matchSentences asArray.
	
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'JPF 4/26/2021 18:07:59'!
initializeWith: aStackOfSentences
	
	stackOfSentencesToSearch _ aStackOfSentences.
	auxiliarStackOfSentences _ OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'jpf 4/24/2021 11:49:24'!
with: aStackWithSentences
	
	^self new initializeWith: aStackWithSentences.! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JPF 4/24/2021 13:06:13'!
emptyPrefixErrorDescription
	
	^ 'The prefix cannot be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JPF 4/24/2021 13:10:35'!
prefixWithEmptySpaceErrorDescription
	
	^ 'The prefix cannot have empty spaces'.! !
