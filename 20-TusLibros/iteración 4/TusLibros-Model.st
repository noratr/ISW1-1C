!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'JPF 6/27/2021 12:25:17'!
itemIsNotInTheCart
	
	^ 'item is not present in the cart'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !

!Cart methodsFor: 'assertions' stamp: 'JPF 6/27/2021 12:30:04'!
assertItemIsInTheCart: anItem

	^ (items includes: anItem) ifFalse: [ self error: self itemIsNotInTheCart ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'JPF 6/27/2021 12:42:18'!
remove: itemToRemove

	self assertItemIsInTheCart: itemToRemove.
	
	items := items reject: [ :item | item = itemToRemove ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'JPF 7/7/2021 21:21:29'!
checkOutCart  

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (systemFacade creditCardOf: owner )
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'JPF 6/27/2021 12:50:25'!
remove: anItemToRemove

	cart remove: anItemToRemove! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #ClientInformation category: #'TusLibros-Model'!
Object subclass: #ClientInformation
	instanceVariableNames: 'clientId password creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!ClientInformation methodsFor: 'initialization' stamp: 'JPF 7/7/2021 21:31:45'!
initializeFor: aClientId authenticatedWith: aPassword payingWith: aCreditCard 
	
	clientId := aClientId.
	password := aPassword.
	creditCard := aCreditCard.! !


!ClientInformation methodsFor: 'accessing' stamp: 'JPF 7/7/2021 21:36:21'!
creditCard
	
	^creditCard! !

!ClientInformation methodsFor: 'accessing' stamp: 'JPF 7/7/2021 21:34:26'!
password
	
	^password! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientInformation class' category: #'TusLibros-Model'!
ClientInformation class
	instanceVariableNames: ''!

!ClientInformation class methodsFor: 'instance creation' stamp: 'JPF 7/7/2021 21:31:15'!
for: aClientId authenticatedWith: aPassword payingWith: aCreditCard 
	
	^self new initializeFor: aClientId authenticatedWith: aPassword payingWith: aCreditCard ! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #SystemClock category: #'TusLibros-Model'!
Clock subclass: #SystemClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!SystemClock methodsFor: 'time' stamp: 'JPF 6/24/2021 21:44:12'!
now

	^ DateAndTime now! !

!SystemClock methodsFor: 'time' stamp: 'JPF 6/24/2021 21:44:25'!
today
	
	^ Date today! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'assertions' stamp: 'JPF 7/7/2021 21:08:20'!
assertCreditCardNumberIsValid: aCreditCardNumber

	^ (aCreditCardNumber numberOfDigitsInBase: 10) ~= 16
		ifTrue: [ self error: self class canNotCreateACreditCardWithANumberThatHasNot16Digits ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 7/7/2021 21:08:29'!
assertNameHasNotMoreThan30Characters: aName

	^ aName size > 30 
		ifTrue: [ self error: self class canNotCreateACreditCardWithANameWithMoreThan30Characters ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 7/7/2021 21:08:40'!
assertNameHasNotOnlyWithspaceCharacters: aName

	^ aName withBlanksTrimmed isEmpty
		ifTrue: [ self error: self class canNotCreateACreditCardWithAllWithespaceCharacters ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 7/7/2021 21:08:49'!
assertNameIsNotEmpty: aName

	^ aName isEmpty 
		ifTrue: [ self error: self class canNotCreateACreditCardWithEmptyName ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 7/7/2021 21:09:00'!
assertNameIsValid: aName

	self assertNameIsNotEmpty: aName.
	self assertNameHasNotOnlyWithspaceCharacters: aName.
	self assertNameHasNotMoreThan30Characters: aName! !


!CreditCard methodsFor: 'accessing' stamp: 'JPF 7/8/2021 07:57:14'!
number

	^ number ! !


!CreditCard methodsFor: 'initialization' stamp: 'JPF 7/7/2021 21:07:46'!
initializeWithNumber: aCreditCardNumber of: aName expiringOn: aMonth

	self assertNameIsValid: aName.
	self assertCreditCardNumberIsValid: aCreditCardNumber.
	
	expiration := aMonth.
	number := aCreditCardNumber.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JPF 7/7/2021 21:06:47'!
withNumber: aCreditCardNumber of: aName expiringOn: aMonth 
	
	^self new initializeWithNumber: aCreditCardNumber of: aName expiringOn: aMonth.! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 21:05:49'!
canNotCreateACreditCardWithANameWithMoreThan30Characters
	
	^ 'Credit card can not have a name with more than 30 characters'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 21:05:59'!
canNotCreateACreditCardWithANumberThatHasNot16Digits
	
	^ 'Credit card number should have 16 digits'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 21:06:07'!
canNotCreateACreditCardWithAllWithespaceCharacters
	
	^ 'Credit card can not have a name with all whitespaces characters'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 21:06:15'!
canNotCreateACreditCardWithEmptyName
	
	^ 'Credit card can not have an empty name'! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'JPF 6/27/2021 10:06:39'!
quantity

	^ quantity! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #MerchantProcessorStub category: #'TusLibros-Model'!
MerchantProcessor subclass: #MerchantProcessorStub
	instanceVariableNames: 'debitStrategy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessorStub methodsFor: 'debit' stamp: 'JPF 7/8/2021 07:58:35'!
debit: anAmount from: aCreditCard

	aCreditCard number = self class creditCardNumberWithoutFunds 
		ifTrue: [self error: self class creditCardWithoutFundsErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorStub class' category: #'TusLibros-Model'!
MerchantProcessorStub class
	instanceVariableNames: ''!

!MerchantProcessorStub class methodsFor: 'credit cards' stamp: 'JPF 7/8/2021 07:54:22'!
creditCardNumberWithoutFunds

	^ 1111111111111111! !


!MerchantProcessorStub class methodsFor: 'error descriptions' stamp: 'JPF 7/8/2021 07:53:04'!
creditCardWithoutFundsErrorDescription

	^ 'Credit card without funds'! !


!classDefinition: #PurchasesDetail category: #'TusLibros-Model'!
Object subclass: #PurchasesDetail
	instanceVariableNames: 'itemsAndQuantities total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!PurchasesDetail methodsFor: 'private' stamp: 'JPF 6/27/2021 10:48:31'!
add: aSale

	aSale lineItemsDo: [ :aLineItem | | oldQuantity newQuantity |
		oldQuantity := itemsAndQuantities at: aLineItem item ifAbsentPut: [ 0 ].
		newQuantity := oldQuantity + aLineItem quantity.
		total := total + aLineItem total.
		itemsAndQuantities at: aLineItem item put: newQuantity ].! !


!PurchasesDetail methodsFor: 'initialization' stamp: 'JPF 6/27/2021 10:49:13'!
initializeFor: sales

	total := 0.
	itemsAndQuantities := Dictionary new.
	
	sales do: [ :aSale | self add: aSale ].
	
	! !


!PurchasesDetail methodsFor: 'accessing' stamp: 'JPF 6/27/2021 10:54:35'!
at: item

	^ itemsAndQuantities at: item! !

!PurchasesDetail methodsFor: 'accessing' stamp: 'JPF 6/27/2021 10:57:39'!
isEmpty
	
	^ itemsAndQuantities isEmpty! !

!PurchasesDetail methodsFor: 'accessing' stamp: 'JPF 6/27/2021 11:32:08'!
itemsAndQuantitiesDo: aBlockClosure 
	
	itemsAndQuantities associationsDo: aBlockClosure! !

!PurchasesDetail methodsFor: 'accessing' stamp: 'JPF 6/27/2021 10:55:14'!
total
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasesDetail class' category: #'TusLibros-Model'!
PurchasesDetail class
	instanceVariableNames: ''!

!PurchasesDetail class methodsFor: 'instance creation' stamp: 'JPF 6/27/2021 10:44:16'!
for: sales

	^ self new initializeFor: sales.! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndClientInformation catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'JPF 7/7/2021 21:45:23'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := (validUsersAndClientInformation at: aUser ifAbsent: [ ^false ]) password.
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'JPF 7/7/2021 21:23:00'!
checkOutCartIdentifiedAs: aCartId  

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | ^ cartSession checkOutCart ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'JPF 6/27/2021 10:14:47'!
listCatalog

	^ catalog copy.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'JPF 6/27/2021 10:42:50'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		"
		sales
			inject: PurchasesDetail new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] "
		^ PurchasesDetail for: sales.
			]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'JPF 6/27/2021 12:49:36'!
remove: anItem fromCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession remove: anItem ]
	
	! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'JPF 6/27/2021 10:37:31'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	| total |
	total := 0.
	aSale lineItemsDo: [ :aLineItem | | oldQuantity newQuantity |
		oldQuantity := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newQuantity := oldQuantity + aLineItem quantity.
		total := total + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newQuantity ].
	
	salesOrderedByBook total: total.! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'JPF 7/7/2021 21:45:23'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndClientInformation := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !


!TusLibrosSystemFacade methodsFor: 'user information' stamp: 'JPF 7/7/2021 21:45:23'!
creditCardOf: aClientId

	^ (validUsersAndClientInformation at: aClientId) creditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !


!classDefinition: #TusLibrosSystemFactory category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFactory methodsFor: 'factory protocol' stamp: 'JPF 6/24/2021 21:58:23'!
createCatalog

	self subclassResponsibility! !

!TusLibrosSystemFactory methodsFor: 'factory protocol' stamp: 'JPF 6/24/2021 21:57:44'!
createClock

	self subclassResponsibility! !

!TusLibrosSystemFactory methodsFor: 'factory protocol' stamp: 'JPF 7/7/2021 21:46:27'!
createFacade
	
	^ TusLibrosSystemFacade
		authenticatingWith: self createValidUsersAndClientInformation
		acceptingItemsOf: self createCatalog 
		registeringOn: self createSalesBook 
		debitingThrought: self createMerchantProcessor 
		measuringTimeWith: self createClock
	! !

!TusLibrosSystemFactory methodsFor: 'factory protocol' stamp: 'JPF 6/24/2021 21:58:11'!
createMerchantProcessor

	self subclassResponsibility! !

!TusLibrosSystemFactory methodsFor: 'factory protocol' stamp: 'JPF 6/24/2021 21:57:59'!
createSalesBook

	self subclassResponsibility! !

!TusLibrosSystemFactory methodsFor: 'factory protocol' stamp: 'JPF 7/7/2021 21:46:27'!
createValidUsersAndClientInformation
	
	^ self subclassResponsibility ! !


!classDefinition: #TusLibrosDefaultFactory category: #'TusLibros-Model'!
TusLibrosSystemFactory subclass: #TusLibrosDefaultFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosDefaultFactory methodsFor: 'factory protocol' stamp: 'JPF 6/26/2021 10:21:28'!
createCatalog

	^ Dictionary new
		at: 'Smalltalk, Objects and Design' put: 10;
		at: 'Design Patterns' put: 20;
		at: 'Object Thinking' put: 30;
		at: 'History of Programming Languages' put: 20;
		at: 'The Innovators' put: 25;
		yourself! !

!TusLibrosDefaultFactory methodsFor: 'factory protocol' stamp: 'JPF 6/26/2021 10:09:19'!
createClock

	^ SystemClock new! !

!TusLibrosDefaultFactory methodsFor: 'factory protocol' stamp: 'JPF 6/26/2021 10:08:58'!
createMerchantProcessor

	^ MerchantProcessorStub new! !

!TusLibrosDefaultFactory methodsFor: 'factory protocol' stamp: 'JPF 6/26/2021 10:09:40'!
createSalesBook
	
	^ OrderedCollection new! !

!TusLibrosDefaultFactory methodsFor: 'factory protocol' stamp: 'JPF 7/8/2021 07:55:13'!
createValidUsersAndClientInformation

	| commonPassword juanFerrino noraTrinchero today notExpiredCreditCard 
	juanFerrinoClientInfo expiredCreditCard noraTrincheroClientInfo alanKay notExpiredWithoutFundsCreditCard alanKayClientInfo |
	
	juanFerrino := 'Juan Ferrino'.
	noraTrinchero := 'Nora Trinchero'.
	alanKay := 'Alan Kay'.
	commonPassword := '1234'.
	
	today := DateAndTime now.

	notExpiredCreditCard := CreditCard 
		withNumber: 1111222211112222
		of: juanFerrino 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1).
	juanFerrinoClientInfo := ClientInformation 
		for: juanFerrino 
		authenticatedWith: commonPassword 
		payingWith: notExpiredCreditCard.
		
	expiredCreditCard := CreditCard 
		withNumber: 8888222288882222
		of: noraTrinchero 
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1).
	noraTrincheroClientInfo := ClientInformation 
		for: noraTrinchero 
		authenticatedWith: commonPassword 
		payingWith:  expiredCreditCard.
		
	notExpiredWithoutFundsCreditCard := CreditCard 
		withNumber: MerchantProcessorStub creditCardNumberWithoutFunds
		of: alanKay 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1).
	alanKayClientInfo := ClientInformation 
		for: alanKay
		authenticatedWith: commonPassword 
		payingWith:  notExpiredWithoutFundsCreditCard.
		
	^ Dictionary new
		at: juanFerrino put: juanFerrinoClientInfo;
		at: noraTrinchero put: noraTrincheroClientInfo;
		at: alanKay put: alanKayClientInfo;
		yourself! !
