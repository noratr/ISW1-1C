!classDefinition: #MapperTest category: #'TusLibros-Server'!
TestCase subclass: #MapperTest
	instanceVariableNames: 'port webServer tusLibrosSystemFacade ticket lineItem1 lineItem2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!MapperTest methodsFor: 'tests - map purchases detail' stamp: 'JPF 6/27/2021 11:04:09'!
test01ShouldConvertAnEmptyPurchasesDetailToResponseWithTotalZero

	| emptyPurchasesDetail expectedResponse |
	
	expectedResponse := Dictionary with: ('items'->{}) with: ('total'->0).
	emptyPurchasesDetail := PurchasesDetail for: OrderedCollection new.
	
	self 
		assert: expectedResponse 
		equals: (Mapper mapPurchasesDetailToResponse: emptyPurchasesDetail).
	! !

!MapperTest methodsFor: 'tests - map purchases detail' stamp: 'JPF 6/27/2021 11:47:45'!
test02ShouldConvertAPurchasesDetailToResponseWithItemsAndTotal

	| purchasesDetail expectedResponse expectedItems actualResponse |
	
	expectedItems := (OrderedCollection
		with: (Dictionary
			with: ('item'->lineItem1 item)
			with: ('quantity'->lineItem1 quantity))	
		with: (Dictionary 
			with: ('item'->lineItem2 item) 
			with: ('quantity'->lineItem2 quantity))
			) asArray.
	
	expectedResponse := Dictionary 
		with: ('items'->expectedItems)
		with: ('total'->(lineItem1 total + lineItem2 total)).
	
	purchasesDetail := PurchasesDetail
		for: (OrderedCollection with: (Sale doneBy: 'client' certifiedWith: ticket)).
		
	actualResponse := Mapper mapPurchasesDetailToResponse: purchasesDetail.
	
	"self assert: (expectedResponse at: 'items') asSortedCollection equals: (actualResponse at: 'items') asSortedCollection.
	self assert: (expectedResponse at: 'total') equals: (actualResponse at: 'total')."
	self assert: expectedResponse equals: actualResponse.
	! !


!MapperTest methodsFor: 'tests - map ticket' stamp: 'JPF 6/27/2021 10:08:56'!
test01ShouldConvertAnEmptyTicketToAnEmptyArray

	self 
		assert: {} equals: (Mapper mapTicketToResponse: (Ticket of: Array new)).
	! !

!MapperTest methodsFor: 'tests - map ticket' stamp: 'JPF 6/27/2021 11:31:13'!
test02ShouldConvertATicketToTheCorrespondingArrayOfDictionaries

	| expectedResponse |
	
	expectedResponse := (OrderedCollection
		with: (Dictionary
			with: ('item'->lineItem1 item)
			with: ('quantity'->lineItem1 quantity)
			with: ('total'->lineItem1 total))	
		with: (Dictionary 
			with: ('item'->lineItem2 item) 
			with: ('quantity'->lineItem2 quantity)
			with: ('total'->lineItem2 total))
			) asArray.

	self assert: (Mapper mapTicketToResponse: ticket) = expectedResponse.

	! !


!MapperTest methodsFor: 'setUp' stamp: 'JPF 6/27/2021 11:15:41'!
setUp

	lineItem1 := LineItem of: 'item1' quantity: 2 total: 20.
	lineItem2 := LineItem of: 'item2' quantity: 1 total: 30.
	ticket := Ticket of: (OrderedCollection with: lineItem1 with: lineItem2).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MapperTest class' category: #'TusLibros-Server'!
MapperTest class
	instanceVariableNames: 'ticket'!


!classDefinition: #Mapper category: #'TusLibros-Server'!
Object subclass: #Mapper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mapper class' category: #'TusLibros-Server'!
Mapper class
	instanceVariableNames: ''!

!Mapper class methodsFor: 'mapping' stamp: 'JPF 6/27/2021 11:53:34'!
mapPurchasesDetailToResponse: aPurchasesDetail

	| items sortBlock |
	
	items := OrderedCollection new.
	aPurchasesDetail itemsAndQuantitiesDo: [ :itemAndQuantity |
		items add: (Dictionary
			with: ('item'->itemAndQuantity key)
			with: ('quantity'->itemAndQuantity value)) ].
		
	sortBlock := [ :element1 :element2 | (element1 at: 'item') <= (element2 at: 'item')].

	^ Dictionary with: ('items'->(items asSortedCollection: sortBlock) asArray) with: ('total'->aPurchasesDetail total).! !


!Mapper class methodsFor: 'to response' stamp: 'JPF 6/27/2021 10:07:50'!
mapTicketToResponse: aTicket
	
	| response |
	
	response := OrderedCollection new.
	
	aTicket lineItemsDo: [ :lineItem |
		response add: (Dictionary
			with: ('item'->lineItem item)
			with: ('quantity'->lineItem quantity)
			with: ('total'->lineItem total))
		].
		
	^ response asArray .! !


!classDefinition: #TusLibrosRestInterface category: #'TusLibros-Server'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'port webServer tusLibrosSystemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosRestInterface methodsFor: 'accessing' stamp: 'JPF 6/24/2021 21:19:05'!
port
	
	^ port! !


!TusLibrosRestInterface methodsFor: 'private - request handling' stamp: 'JPF 6/29/2021 20:32:50'!
handle: request with: aBlock
		
	[aBlock value]
	on: Error
	do: [ :anError |
		request send400Response: (anError messageText) ]! !


!TusLibrosRestInterface methodsFor: 'error signaling' stamp: 'JPF 6/28/2021 20:50:07'!
signalMissingParameterError: missingParameter

	^ missingParameter, ' parameter must be sended in the request'! !


!TusLibrosRestInterface methodsFor: 'private - parameters handling' stamp: 'JPF 6/28/2021 20:47:58'!
getParameter: aParameter from: aRequest

	^ aRequest fields at: aParameter ifAbsent: [ self signalMissingParameterError: aParameter ]! !


!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 7/1/2021 18:57:42'!
handleAddToCart: request

	self handle: request with: [	 | product quantity cartId |	
		
		cartId := self getParameter: 'cartId' from: request.
		product := self getParameter:  'product' from: request.
		quantity := self getParameter: 'quantity' from: request. 
		
		tusLibrosSystemFacade
			add: quantity asNumber
			of: product
			toCartIdentifiedAs: cartId asNumber.
		
		request send200Response: 'OK'
	]! !

!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 7/7/2021 22:01:41'!
handleCheckOutCart: request

	self handle: request with: [	 | cartId ticket response |	
		
		cartId := self getParameter: 'cartId' from: request.
		
		ticket := tusLibrosSystemFacade
			checkOutCartIdentifiedAs: cartId asNumber
			.
		response := Mapper mapTicketToResponse: ticket.
		
		request send200Response: (WebUtils jsonEncode: response).
	]! !

!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 7/1/2021 18:10:34'!
handleCreateCart: request

	self handle: request with: [	 | cartId clientId password |
	
		clientId := self getParameter: 'clientId' from: request.
		password := self getParameter: 'password' from: request.

		cartId := tusLibrosSystemFacade createCartFor: clientId authenticatedWith: password.

		request send200Response: cartId asString
		]! !

!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 6/28/2021 20:53:57'!
handleListCart: request

	self handle: request with: [	 | cartId cart |	
		
		cartId := self getParameter: 'cartId' from: request.
		
		cart := tusLibrosSystemFacade listCartIdentifiedAs: cartId asNumber.
		
		request send200Response: (WebUtils jsonEncode: cart contents).
	]! !

!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 6/27/2021 10:22:29'!
handleListCatalog: request

	self handle: request with: [	 | catalog response |	
		
		catalog := tusLibrosSystemFacade listCatalog.
		
		response := String streamContents:[ :s| WebUtils jsonMap: catalog on: s].
		
		request send200Response: response.
	]! !

!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 6/28/2021 20:54:38'!
handleListPurchases: request

	self handle: request with: [	 | clientId password purchases response |	
		
		clientId := self getParameter: 'clientId' from: request.
		password := self getParameter: 'password' from: request.
		
		purchases := tusLibrosSystemFacade listPurchasesOf: clientId authenticatingWith: password.
		
		response := Mapper mapPurchasesDetailToResponse: purchases.
		
		request send200Response: (WebUtils jsonEncode: response).
	]! !

!TusLibrosRestInterface methodsFor: 'handlers' stamp: 'JPF 7/6/2021 20:19:39'!
handleRemoveFromCart: request

	self handle: request with: [	 | product cartId |	
		
		cartId := self getParameter: 'cartId' from: request.
		product := self getParameter: 'product' from: request.
		
		tusLibrosSystemFacade
			remove: product
			fromCartIdentifiedAs: cartId asNumber.
		
		request send200Response: 'OK'
	]! !


!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'JPF 6/27/2021 12:54:57'!
initializeWith: aPortNumber

	tusLibrosSystemFacade := TusLibrosDefaultFactory new createFacade.
	
	port:= aPortNumber.
	
	webServer :=
		WebServer new listenOn: self port;
		addService: '/createCart' action:[ :request | self handleCreateCart: request ];
		addService: '/addToCart' action:[ :request | self handleAddToCart: request ];
		addService: '/listCart' action:[ :request | self handleListCart: request ];
		addService: '/listPurchases' action:[ :request | self handleListPurchases: request ];
		addService: '/checkOutCart' action:[ :request | self handleCheckOutCart: request ];
		addService: '/listCatalog' action:[ :request | self handleListCatalog: request ];
		addService: '/removeFromCart' action:[ :request | self handleRemoveFromCart: request ].
		.! !


!TusLibrosRestInterface methodsFor: 'enabling services' stamp: 'JPF 6/24/2021 21:22:18'!
destroy

	webServer ifNotNil:[webServer destroy]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: #'TusLibros-Server'!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'instance creation' stamp: 'JPF 6/24/2021 21:15:53'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
