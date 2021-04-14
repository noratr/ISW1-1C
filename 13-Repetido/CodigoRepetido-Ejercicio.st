!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 17:35:43'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.

	self assertThatTheExecutionTimeOf: [customerBook addCustomerNamed: 'John Lennon'.] isLessThan: 50 In: millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 18:21:38'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self createACustomerBookWith: paulMcCartney.
	
	self assertThatTheExecutionTimeOf: [customerBook removeCustomerNamed: paulMcCartney.] isLessThan: 100 In: millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 18:44:29'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook _ self createACustomerBookWith: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError |
			self assertThatTheOnlyCustomerIn: customerBook isTheCustomerNamed: johnLennon. ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 18:22:59'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self createACustomerBookWith: paulMcCartney.

	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook theNumberOfActiveCustomersIs: 0 andTheNumberOfSuspendedCustomersIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 18:31:54'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self createACustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook theNumberOfActiveCustomersIs: 0 andTheNumberOfSuspendedCustomersIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 18:46:42'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook _ self createACustomerBookWith: johnLennon.
	
	self assertThatIn: customerBook cantSuspendTheCustomerNamed: 'George Harrison' andTheOnlyCustomerInTheBookIsTheCustomerNamed: johnLennon.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpf 4/14/2021 18:46:42'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook _ self createACustomerBookWith: johnLennon.

	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThatIn: customerBook cantSuspendTheCustomerNamed: johnLennon andTheOnlyCustomerInTheBookIsTheCustomerNamed: johnLennon.
! !


!CustomerBookTest methodsFor: 'instance creation' stamp: 'jpf 4/14/2021 18:26:42'!
createACustomerBookWith: aCustomerName

	| customerBook |
	
	customerBook _ CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook.! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'jpf 4/14/2021 18:47:11'!
assertThatIn: aCustomerBook cantSuspendTheCustomerNamed: aCustomerNameThatCantBeSuspended andTheOnlyCustomerInTheBookIsTheCustomerNamed: aCustomerNameInTheBook

	[ aCustomerBook suspendCustomerNamed: aCustomerNameThatCantBeSuspended.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assertThatTheOnlyCustomerIn: aCustomerBook isTheCustomerNamed: aCustomerNameInTheBook. ].! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'jpf 4/14/2021 18:00:33'!
assertThatIn: aCustomerBook theNumberOfActiveCustomersIs: aNumberOfActiveCustomers andTheNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveCustomers + aNumberOfSuspendedCustomers equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'jpf 4/14/2021 17:41:44'!
assertThatTheExecutionTimeOf: aBlock isLessThan: aNumber In: aUnitOfTime

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning convertTo: aUnitOfTime) < (aNumber * aUnitOfTime).
	! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'jpf 4/14/2021 18:45:00'!
assertThatTheOnlyCustomerIn: aCustomerBook isTheCustomerNamed: aCustomerName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomerName).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'jpf 4/14/2021 18:34:55'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jpf 4/14/2021 19:20:06'!
removeCustomerNamed: aName

	| customerAbsentInActive customerAbsentInSuspended |

	customerAbsentInActive _ false.
	customerAbsentInSuspended _ false.
	
	self remove: aName from: active ifAbsent: [ customerAbsentInActive _ true.].
	self remove: aName from: suspended ifAbsent: [ customerAbsentInSuspended _ true.].
	
	(customerAbsentInActive and: [ customerAbsentInSuspended ]) ifTrue: [ ^NotFound signal. ].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'private' stamp: 'jpf 4/14/2021 19:07:04'!
remove: anElement from: aCollection.
	
	1 to: aCollection size do: 
	[ :index |
		anElement = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ anElement. 
			] 
	].
	^nil.! !

!CustomerBook methodsFor: 'private' stamp: 'jpf 4/14/2021 19:10:25'!
remove: anElement from: aCollection ifAbsent: aBlock
	
	1 to: aCollection size do: 
	[ :index |
		anElement = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ anElement. 
			] 
	].
	^aBlock value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
