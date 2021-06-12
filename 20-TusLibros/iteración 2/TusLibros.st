!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:28:52'!
test01NewCartsAreCreatedEmpty

	self assert: testSupport createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:08'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [ cart add: testSupport itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:19'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:28'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 0 of: testSupport itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:38'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 2 of: testSupport itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:49'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self assert: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:57'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	self deny: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:30:08'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	self assert: (cart occurrencesOf: testSupport itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp' stamp: 'JPF 6/12/2021 09:27:46'!
setUp
	
	testSupport := MarketTestSupport new! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 10:22:24'!
test01ShouldRaiseAnExceptionWhenTryToCheckoutAnEmptyCart

	| cart cashier |
	
	cart := testSupport createCart.
	
	cashier := testSupport createCashier.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport validCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier canNotCheckoutEmptyCartErrorDescription
	
	
	

	! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:58:45'!
test02ShouldCalculateTheCorrectTotalOfTheCart

	| cart cashier |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	
	cashier := testSupport createCashier.
	
	self assert: 100 equals: (cashier checkout: cart payingWith: testSupport validCreditCard)
		

	! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 10:05:29'!
test03ShouldRaiseAnExceptionIfTheCreditCardIsExpired

	| cart cashier |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	
	cashier := testSupport createCashier.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport expiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier canNotCheckoutWithAnExpiredCreditCard
		

	! !


!CashierTest methodsFor: 'set up' stamp: 'JPF 6/12/2021 09:27:46'!
setUp

	testSupport := MarketTestSupport new! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setUp' stamp: 'JPF 6/12/2021 09:48:47'!
setUp
	
	testSupport := MarketTestSupport new! !


!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:45:21'!
test01ShouldRaiseAnExceptionWhenCreatesACardWithAnEmptyName

	self 
		should: [ 
			CreditCard
				withName: ''
				number: testSupport validCardNumber
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithEmptyName! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:45:57'!
test02ShouldRaiseAnExceptionWhenCreatesACardWithANameWithMoreThan30Characters

	self 
		should: [ 
			CreditCard
				withName: 'NameWithMoreThanThirtyCharacter'
				number: testSupport validCardNumber
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANameWithMoreThan30Characters.! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:46:20'!
test03ShouldRaiseAnExceptionWhenCreatesACardWithANumberWithMoreThan16Digits

	self 
		should: [ 
			CreditCard
				withName: testSupport validCardName
				number: '11118888111188881'
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANumberWithMoreThan16Digits.! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:49:48'!
test04ShouldRaiseAnExceptionWhenCreatesACardWithANumberWithLessThan13Digits

	self 
		should: [ 
			CreditCard
				withName: testSupport validCardName
				number: '111188881111'
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANumberWithLessThan13Digits.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:25:22'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'JPF 6/12/2021 09:16:19'!
total
	
	^ items sum: [ :item | catalog at: item ] ifEmpty: [ 0 ]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'JPF 6/12/2021 10:09:58'!
checkout: aCart payingWith: aCreditCard
	
	self assertCartIsNotEmpty: aCart.
	(aCreditCard isExpiredComparingTo: today) ifTrue: [ self error: self class canNotCheckoutWithAnExpiredCreditCard ].
	
	^ aCart total! !


!Cashier methodsFor: 'assertions' stamp: 'JPF 6/10/2021 20:00:05'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [ self error: self class canNotCheckoutEmptyCartErrorDescription ]! !


!Cashier methodsFor: 'initialization' stamp: 'JPF 6/12/2021 10:20:30'!
initializeFor: aDate
	
	today := aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'JPF 6/10/2021 19:57:42'!
canNotCheckoutEmptyCartErrorDescription
	
	^ 'Can not checkout an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 10:06:20'!
canNotCheckoutWithAnExpiredCreditCard
	
	^ 'Can not checkout with an expired credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'JPF 6/12/2021 10:21:14'!
for: aDate
	
	^ self new initializeFor: aDate! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'name creditCardNumber month'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JPF 6/12/2021 09:52:57'!
initializeWithName: aName number: aCreditCardNumber expiration: aMonth
	
	self assertNameIsValid: aName.
	self assertNumberIsValid: aCreditCardNumber.
	
	name := aName.
	creditCardNumber := aCreditCardNumber.
	month := aMonth.! !


!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:52:25'!
assertCreditCardNumberHasNotLessThan13Digits: aCreditCardNumber

	^ aCreditCardNumber size < 13 ifTrue: [ self error: self class canNotCreateACreditCardWithANumberWithLessThan13Digits ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:41:48'!
assertCreditCardNumberHasNotMoreThan16Digits: aCreditCardNumber

	^ aCreditCardNumber size > 16 ifTrue: [ self error: self class canNotCreateACreditCardWithANumberWithMoreThan16Digits ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:34:36'!
assertNameHasNotMoreThan30Characters: aName

	^ aName size > 30 
		ifTrue: [ self error: self class canNotCreateACreditCardWithANameWithMoreThan30Characters ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/10/2021 20:48:10'!
assertNameIsNotEmpty: aName

	^ aName isEmpty 
		ifTrue: [ self error: self class canNotCreateACreditCardWithEmptyName ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:34:56'!
assertNameIsValid: aName

	self assertNameIsNotEmpty: aName.
	self assertNameHasNotMoreThan30Characters: aName! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:52:57'!
assertNumberIsValid: aCreditCardNumber

	self assertCreditCardNumberHasNotMoreThan16Digits: aCreditCardNumber.
	self assertCreditCardNumberHasNotLessThan13Digits: aCreditCardNumber! !


!CreditCard methodsFor: 'testing' stamp: 'JPF 6/12/2021 10:18:12'!
isExpiredComparingTo: aDate
	
	^ aDate > month lastDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 09:09:58'!
canNotCreateACreditCardWithANameWithMoreThan30Characters

	^ 'Can not create a credit card with a name with more than 30 characters'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 09:50:25'!
canNotCreateACreditCardWithANumberWithLessThan13Digits
	
	^ 'Can not create a credit card with a number with less than 13 digits'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 09:39:53'!
canNotCreateACreditCardWithANumberWithMoreThan16Digits
	
	^ 'Can not create a credit card with a number with more than 16 digits'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/10/2021 20:44:07'!
canNotCreateACreditCardWithEmptyName

	^ 'Can not create a credit card with an empty name'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'JPF 6/10/2021 20:45:18'!
withName: aName number: aCreditCardNumber expiration: aMonth
	
	^self new initializeWithName: aName number: aCreditCardNumber expiration: aMonth! !


!classDefinition: #MarketTestSupport category: 'TusLibros'!
Object subclass: #MarketTestSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/12/2021 09:12:19'!
defaultCatalog
	
	^ Dictionary with: (self itemSellByTheStore -> self itemSellByTheStorePrice)! !

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/10/2021 19:50:19'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/12/2021 09:23:05'!
itemSellByTheStore
	
	^ 'validItem'! !

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/12/2021 09:13:07'!
itemSellByTheStorePrice

	^ 50! !


!MarketTestSupport methodsFor: 'cart' stamp: 'JPF 6/10/2021 19:49:06'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!MarketTestSupport methodsFor: 'cashier' stamp: 'JPF 6/12/2021 10:25:01'!
createCashier
	
	^ Cashier for: July / 1 / 2020.! !


!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:54:24'!
expirationMonth

	^ June ofYear: (GregorianYear number: 2022)! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:02:24'!
expiredCreditCard

	^ CreditCard
		withName: self validCardName
		number: self validCardNumber
		expiration: self expiredMonth.! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:54:46'!
expiredMonth

	^ June ofYear: (GregorianYear number: 2020)! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 09:44:13'!
validCardName

	^ 'Valid Name'! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 09:43:21'!
validCardNumber

	^ '1111888811118888'! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:02:02'!
validCreditCard

	^ CreditCard
		withName: self validCardName
		number: self validCardNumber
		expiration: self expirationMonth.! !
