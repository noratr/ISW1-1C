!classDefinition: #ErrorWindow category: #'TusLibros-Client'!
Panel subclass: #ErrorWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!ErrorWindow methodsFor: 'initialization' stamp: 'JPF 7/7/2021 20:35:08'!
defaultExtent
	
	^1000@100
! !

!ErrorWindow methodsFor: 'initialization' stamp: 'JPF 7/7/2021 20:35:37'!
initializeTitled: aTitle withModel: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self openInWorld.
! !


!ErrorWindow methodsFor: 'GUI building' stamp: 'JPF 7/7/2021 20:31:12'!
buildMorphicWindow

	self layoutMorph 
		beColumn;
		separation: 15;
		axisEdgeWeight: 0;
		addMorph: (LabelMorph contents: self model errorMessage).
	self layoutMorph 
		layoutSpec 
		fixedHeight: 300; 
		fixedWidth: 300.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorWindow class' category: #'TusLibros-Client'!
ErrorWindow class
	instanceVariableNames: ''!

!ErrorWindow class methodsFor: 'instance creation' stamp: 'JPF 7/7/2021 19:50:21'!
openWith: aModel

	^ self new initializeTitled: 'Error' withModel: aModel.! !


!classDefinition: #LoginWindow category: #'TusLibros-Client'!
Panel subclass: #LoginWindow
	instanceVariableNames: 'clientIdTextBoxMorph passwordTextBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!LoginWindow methodsFor: 'GUI building' stamp: 'JPF 6/28/2021 19:36:59'!
buildClientIdRow

	| clientIdRowLayoutMorph |
	
	clientIdTextBoxMorph := TextModelMorph
		textProvider: self model
		textGetter: #clientId
		textSetter: #clientId:.
		
	clientIdTextBoxMorph textMorph 
		setProperty: #keyStroke: 
		toValue: [ :key | clientIdTextBoxMorph textMorph acceptContents ].
		
	clientIdTextBoxMorph 
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 300.
		
	clientIdRowLayoutMorph := LayoutMorph newRow.
	clientIdRowLayoutMorph
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: 'Client ID:');
		addMorph: clientIdTextBoxMorph.
		
	^ clientIdRowLayoutMorph

	! !

!LoginWindow methodsFor: 'GUI building' stamp: 'JPF 6/28/2021 19:55:49'!
buildMorphicWindow

	self 
		layoutMorph beColumn;
		separation: 15;
		axisEdgeWeight: 0.5;
		addMorph: self buildClientIdRow;
		addMorph: self buildPasswordRow;
		addMorph: self buildSubmitButton.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'JPF 6/28/2021 19:40:32'!
buildPasswordRow

	| passwordRowLayoutMorph |
	
	passwordTextBoxMorph := TextModelMorph
		textProvider: self model
		textGetter: #password
		textSetter: #password:.
		
	passwordTextBoxMorph textMorph 
		setProperty: #keyStroke: 
		toValue: [ :key | passwordTextBoxMorph textMorph acceptContents ].
		
	passwordTextBoxMorph 
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 300.
		
	passwordRowLayoutMorph := LayoutMorph newRow.
	passwordRowLayoutMorph
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: 'Password:');
		addMorph: passwordTextBoxMorph.
		
	^ passwordRowLayoutMorph! !

!LoginWindow methodsFor: 'GUI building' stamp: 'JPF 7/7/2021 18:43:53'!
buildSubmitButton

	| submitButtonMorph |
	
	submitButtonMorph := PluggableButtonMorph
		model: self model
		stateGetter: nil 
		action: #login 
		label: 'Login'.
	
	^ submitButtonMorph! !


!LoginWindow methodsFor: 'windows navigation' stamp: 'JPF 7/7/2021 20:02:44'!
openErrorWindow

	ErrorWindow openWith: self model.! !

!LoginWindow methodsFor: 'windows navigation' stamp: 'JPF 7/8/2021 00:04:04'!
openMarketWindow
	
	MarketWindow openWith: self model from: self.
	self delete.! !


!LoginWindow methodsFor: 'initialization' stamp: 'JPF 6/28/2021 19:14:55'!
defaultExtent

	^ 485@485! !

!LoginWindow methodsFor: 'initialization' stamp: 'JPF 7/8/2021 07:22:45'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (MarketModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.

			
	self model when: #successfulLogin send: #openMarketWindow to: self.
	self model when: #errorOccurred send: #openErrorWindow to: self.
	self model when: #logoutDone send: #updateFields to: self.! !


!LoginWindow methodsFor: 'as yet unclassified' stamp: 'JPF 7/8/2021 07:34:49'!
updateFields

	clientIdTextBoxMorph model actualContents: model clientId.
	passwordTextBoxMorph model actualContents: model password.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: #'TusLibros-Client'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'instance creation' stamp: 'JPF 6/28/2021 19:11:55'!
open

	^ self new initializeWith: 'Tus Libros - Login'.! !


!classDefinition: #MarketWindow category: #'TusLibros-Client'!
Panel subclass: #MarketWindow
	instanceVariableNames: 'catalogListMorph quantityToAddTextBoxMorph cartListMorph loginWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!MarketWindow methodsFor: 'windows navigation' stamp: 'JPF 7/8/2021 07:04:18'!
openLoginWindow

	loginWindow openInWorld.
	self delete.! !

!MarketWindow methodsFor: 'windows navigation' stamp: 'JPF 7/8/2021 00:03:11'!
openTicketWindow

	TicketWindow openWith: self model from: loginWindow.
	self delete.! !


!MarketWindow methodsFor: 'initialization' stamp: 'JPF 6/28/2021 21:11:25'!
defaultExtent

	^ 1000@700! !

!MarketWindow methodsFor: 'initialization' stamp: 'JPF 7/8/2021 07:37:32'!
initializeTitled: aTitle withModel: aModel from: aLoginWindow

	loginWindow := aLoginWindow.

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self openInWorld.
	
	self model when: #cartHasChanged send: #refreshCart to: self.
	self model when: #purchaseDone send: #openTicketWindow to: self.
	self model when: #logoutDone send: #logout to: self.! !


!MarketWindow methodsFor: 'GUI building' stamp: 'JPF 7/8/2021 07:03:10'!
buildCartColumn

	| removeFromCartButtonMorph checkoutButtonMorph listPurchasesButtonMorph 
		cartColumnLayout logOutButtonMorph |
	
	cartListMorph := PluggableListMorph 
		model: self model 
		listGetter: #cartList
		indexGetter: #cartListIndex 
		indexSetter: #cartListIndex:.
	cartListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	cartListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
		
	removeFromCartButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #removeFromCart  
		label: 'Remove from cart'.	
		
	checkoutButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #checkOut  
		label: 'Check out'.	
		
	listPurchasesButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #listPurchases  
		label: 'Purchase history'.	
		
	logOutButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #logout  
		label: 'Log out'.	
		
	cartColumnLayout := LayoutMorph newColumn.
	cartColumnLayout 
		addMorph: (LabelMorph contents: 'Cart');
		addMorph: cartListMorph;
		addMorph: removeFromCartButtonMorph;
		addMorph: checkoutButtonMorph;
		addMorph: listPurchasesButtonMorph;
		addMorph: logOutButtonMorph.
		
	^ cartColumnLayout! !

!MarketWindow methodsFor: 'GUI building' stamp: 'JPF 7/1/2021 18:49:04'!
buildCatalogColumn

	| productSelectionLayoutMorph |
	
	catalogListMorph := PluggableListMorph 
		model: self model 
		listGetter: #catalog
		indexGetter: #catalogListIndex 
		indexSetter: #catalogListIndex:.
	catalogListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	catalogListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
		
	productSelectionLayoutMorph := LayoutMorph newColumn.
	productSelectionLayoutMorph 
		separation: 10;
		axisEdgeWeight: 0;
		addMorph: (LabelMorph contents: 'Catalog');
		addMorph: catalogListMorph;
		addMorph: self buildQuantitySelectionRow.
		
	^ productSelectionLayoutMorph ! !

!MarketWindow methodsFor: 'GUI building' stamp: 'JPF 7/1/2021 17:41:43'!
buildMorphicWindow

	self layoutMorph beRow;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildCatalogColumn;
	addMorph: self buildCartColumn.! !

!MarketWindow methodsFor: 'GUI building' stamp: 'JPF 7/7/2021 18:42:45'!
buildQuantitySelectionRow

	| addProductButtonMorph quantitySelectionRowLayout |
	
	quantityToAddTextBoxMorph := TextModelMorph 
		textProvider: self model 
		textGetter: #quantityToAdd 
		textSetter: #quantityToAdd:. 
	quantityToAddTextBoxMorph textMorph
		setProperty: #keyStroke:
		toValue: [ :key | quantityToAddTextBoxMorph textMorph acceptContents ].
	quantityToAddTextBoxMorph 
		borderWidth: 1;
		borderColor: Color skyBlue.
	
	addProductButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #addToCart  
		label: 'Add to cart'.	
		
	quantitySelectionRowLayout := LayoutMorph newRow.
	quantitySelectionRowLayout
		addMorph: (LabelMorph contents: 'Quantity');
		addMorph: quantityToAddTextBoxMorph;
		addMorph: addProductButtonMorph.
		
	^ quantitySelectionRowLayout.
		
	
	
	
! !


!MarketWindow methodsFor: 'actions' stamp: 'JPF 7/8/2021 07:37:21'!
logout

	self updateFields.
	self openLoginWindow.! !

!MarketWindow methodsFor: 'actions' stamp: 'JPF 7/6/2021 19:58:35'!
refreshCart
	
	cartListMorph updateList.
	catalogListMorph setSelectionIndex: 0.! !

!MarketWindow methodsFor: 'actions' stamp: 'JPF 7/8/2021 07:36:19'!
updateFields

	quantityToAddTextBoxMorph model actualContents: model quantityToAdd.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarketWindow class' category: #'TusLibros-Client'!
MarketWindow class
	instanceVariableNames: ''!

!MarketWindow class methodsFor: 'instance creation' stamp: 'JPF 7/7/2021 23:57:24'!
openWith: aModel from: aLoginWindow

	^ self new initializeTitled: 'Tus Libros Market' withModel: aModel from: aLoginWindow.! !


!classDefinition: #PurchaseHistoryWindow category: #'TusLibros-Client'!
Panel subclass: #PurchaseHistoryWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!PurchaseHistoryWindow methodsFor: 'GUI building' stamp: 'JPF 7/6/2021 20:31:13'!
buildMorphicWindow

	| purchaseHistoryListMorph |
	
	purchaseHistoryListMorph := PluggableListMorph 
		model: self model 
		listGetter: #purchaseHistoryList
		indexGetter: #purchaseHistoryListIndex 
		indexSetter: #purchaseHistoryListIndex:.
	purchaseHistoryListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	purchaseHistoryListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
	
	self layoutMorph beRow;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: purchaseHistoryListMorph.! !


!PurchaseHistoryWindow methodsFor: 'initialization' stamp: 'JPF 7/7/2021 18:22:48'!
defaultExtent

	^ 500@700! !

!PurchaseHistoryWindow methodsFor: 'initialization' stamp: 'JPF 7/8/2021 07:40:37'!
initializeTitled: aTitle withModel: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self openInWorld.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseHistoryWindow class' category: #'TusLibros-Client'!
PurchaseHistoryWindow class
	instanceVariableNames: ''!

!PurchaseHistoryWindow class methodsFor: 'instance creation' stamp: 'JPF 7/6/2021 20:24:04'!
openWith: aModel

	^ self new initializeTitled: 'Purchase History' withModel: aModel.! !


!classDefinition: #TicketWindow category: #'TusLibros-Client'!
Panel subclass: #TicketWindow
	instanceVariableNames: 'loginWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TicketWindow methodsFor: 'GUI building' stamp: 'JPF 7/7/2021 19:33:41'!
buildMorphicWindow

	| ticketListMorph buttonsLayoutMorph logOutButtonMorph newShoppingCartButtonMorph |
	
	ticketListMorph := PluggableListMorph 
		model: self model 
		listGetter: #ticketList
		indexGetter: #ticketListIndex 
		indexSetter: #ticketListIndex:.
	ticketListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	ticketListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
		
	newShoppingCartButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #newShoppingCart  
		label: 'New shopping cart'.	
	
	logOutButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #logout  
		label: 'Log out'.	
	
	buttonsLayoutMorph := LayoutMorph newRow.
	buttonsLayoutMorph
		separation: 10;
		axisEdgeWeight: 0.5;
		addMorph: newShoppingCartButtonMorph;
		addMorph: logOutButtonMorph.
	
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents: 'Purchase detail');
	addMorph: ticketListMorph;
	addMorph: buttonsLayoutMorph.! !


!TicketWindow methodsFor: 'initialization' stamp: 'JPF 7/7/2021 18:23:50'!
defaultExtent

	^ 500@700! !

!TicketWindow methodsFor: 'initialization' stamp: 'JPF 7/8/2021 00:02:23'!
initializeTitled: aTitle withModel: aModel from: aLoginWindow

	loginWindow := aLoginWindow .

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self openInWorld.
	
	self model when: #newShoppingCartCreated send: #openMarketWindow to: self.
	self model when: #logoutDone send: #openLoginWindow to: self.! !


!TicketWindow methodsFor: 'windows navigation' stamp: 'JPF 7/8/2021 00:15:16'!
openLoginWindow

	loginWindow openInWorld.
	self delete.! !

!TicketWindow methodsFor: 'windows navigation' stamp: 'JPF 7/8/2021 00:19:54'!
openMarketWindow

	MarketWindow openWith: self model from: loginWindow.
	self delete.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketWindow class' category: #'TusLibros-Client'!
TicketWindow class
	instanceVariableNames: ''!

!TicketWindow class methodsFor: 'instance creation' stamp: 'JPF 7/8/2021 00:01:59'!
openWith: aModel from: aLoginWindow

	^ self new initializeTitled: 'Purchase done' withModel: aModel from: aLoginWindow.! !


!classDefinition: #MarketModel category: #'TusLibros-Client'!
Object subclass: #MarketModel
	instanceVariableNames: 'quantityToAdd catalogList catalogListIndex cartListIndex cartList cartId restInterface clientId password purchaseHistoryList ticketList errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!MarketModel methodsFor: 'initialization' stamp: 'JPF 7/7/2021 20:01:29'!
initialize

	errorMessage := ''.
	clientId := ''.
	password := ''.
	restInterface := MarketRestInterface new.
	quantityToAdd := '1'.
	catalogList := OrderedCollection new.
	catalogListIndex := 0.
	cartList := OrderedCollection new.
	cartListIndex := 0.
	purchaseHistoryList := OrderedCollection new.
	ticketList := OrderedCollection new.

	! !


!MarketModel methodsFor: 'cart' stamp: 'JPF 7/6/2021 19:51:29'!
cartList

	^ cartList collect: [ :keyAndValue | (keyAndValue at: 1), '    ', (keyAndValue at: 2) asString ]! !

!MarketModel methodsFor: 'cart' stamp: 'JPF 7/1/2021 17:37:58'!
cartListIndex

	^ cartListIndex! !

!MarketModel methodsFor: 'cart' stamp: 'JPF 7/1/2021 17:37:44'!
cartListIndex: newIndex

	cartListIndex := newIndex! !

!MarketModel methodsFor: 'cart' stamp: 'JPF 7/7/2021 19:01:00'!
cleanCart

	cartList removeAll.
	self cartListIndex: 0! !

!MarketModel methodsFor: 'cart' stamp: 'JPF 7/7/2021 23:37:00'!
selectedProductFromCart

	cartList isEmpty ifTrue: [ self error: self class cartIsEmptyErrorDescription ].
	cartListIndex < 1 ifTrue: [ self error: self class noSelectedCartItemErrorDescription ].

	^ (cartList at: cartListIndex) at: 1.! !


!MarketModel methodsFor: 'client' stamp: 'JPF 7/1/2021 17:53:03'!
clientId

	^ clientId! !

!MarketModel methodsFor: 'client' stamp: 'JPF 7/1/2021 17:53:23'!
clientId: newClientId

	clientId := newClientId! !

!MarketModel methodsFor: 'client' stamp: 'JPF 7/1/2021 17:53:43'!
password

	^ password! !

!MarketModel methodsFor: 'client' stamp: 'JPF 7/1/2021 17:54:03'!
password: newPassword

	password := newPassword! !


!MarketModel methodsFor: 'response mapping' stamp: 'JPF 7/7/2021 23:52:30'!
mapCatalogResponse: catalogDictionary
	
	catalogList removeAll.	
	catalogDictionary keysAndValuesDo: [ :key :value | catalogList add: {key. value}].
! !

!MarketModel methodsFor: 'response mapping' stamp: 'JPF 7/7/2021 23:52:46'!
mapPurchasesResponse: purchaseHistoryDictionary

	|  items total |
	
	purchaseHistoryList removeAll.
	
	items := purchaseHistoryDictionary at: 'items'.
	total := purchaseHistoryDictionary at: 'total'.
	
	items do: [ :itemAndQuantity | purchaseHistoryList add: (itemAndQuantity at: 'item') , '    ' , (itemAndQuantity at: 'quantity') asString ].
	purchaseHistoryList add: ('Total:   $' , total asString ).

	! !

!MarketModel methodsFor: 'response mapping' stamp: 'JPF 7/7/2021 23:52:58'!
mapTicketResponse: ticket 
	
	| ticketTotal |
	
	ticketList removeAll.
	
	ticketTotal := 0.
	
	ticket do: [ :itemAndTotal | | total | 
		total := itemAndTotal at: 'total'.
		ticketList add: (itemAndTotal at: 'item') , '    $' , total asString.
		ticketTotal := ticketTotal + total.
		].
	ticketList add: 'Total:    $' , ticketTotal asString.
	
	! !


!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 23:18:23'!
addToCart

	self doSignalingError: [ | aProduct  |
		
		aProduct := self selectedProductFromCatalog.
		
		restInterface sendAddToCartRequestFor: (self convertToNumber: quantityToAdd) of: aProduct in: cartId.
		
		self listCartCart.
		]


! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 23:52:58'!
checkOut

	self doSignalingError: [ | ticket |
	
		ticket := restInterface sendCheckOutRequestFor: cartId.
		
		self mapTicketResponse: ticket.
		
		self cleanCart.
		
		self triggerEvent: #purchaseDone with: self.
	]
	
	! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 22:15:43'!
listCartCart

	self doSignalingError: [ |  cartDictionary |
	
		cartDictionary := restInterface sendListCartRequestFor: cartId.
		
		cartList removeAll.	
		cartDictionary keysAndValuesDo: [ :key :value | cartList add: {key. value}].
		
		self triggerEvent: #cartHasChanged with: self.
	]
	
	

! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 23:52:46'!
listPurchases

	self doSignalingError: [ | purchaseHistoryDictionary |
	
		purchaseHistoryList removeAll.
		
		purchaseHistoryDictionary := restInterface sendListPurchasesRequestFor: clientId authenticatedWith: password.
		
		self mapPurchasesResponse: purchaseHistoryDictionary.
		
		PurchaseHistoryWindow openWith: self.
	]
	
	! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 23:52:30'!
login

	self doSignalingError: [ | catalogDictionary |
	
		cartId := restInterface 
			sendCreateCartRequestFor: clientId 
			authenticatedWith: password.
			
		catalogDictionary := restInterface sendListCatalogRequest.
		
		self mapCatalogResponse: catalogDictionary.
			
		self triggerEvent: #successfulLogin with: self.
	]! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/8/2021 07:18:38'!
logout

	self doSignalingError: [
		self initialize.
		self triggerEvent: #logoutDone with: self.
		]
! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 20:08:04'!
newShoppingCart

	self doSignalingError: [
		cartId := restInterface 
		sendCreateCartRequestFor: clientId 
		authenticatedWith: password.
		
		self triggerEvent: #newShoppingCartCreated with: self.
		]

! !

!MarketModel methodsFor: 'actions' stamp: 'JPF 7/7/2021 20:08:28'!
removeFromCart

	self doSignalingError: [
		restInterface sendRemoveFromCartRequestFor: self selectedProductFromCart in: cartId.
	
		self listCartCart.
		]

! !


!MarketModel methodsFor: 'product selection' stamp: 'JPF 7/6/2021 19:34:59'!
catalog
	
	^ catalogList collect: [ :productAndPrice | (productAndPrice at: 1), '    $', (productAndPrice at: 2) asString ]! !

!MarketModel methodsFor: 'product selection' stamp: 'JPF 6/28/2021 21:47:06'!
catalogListIndex

	^ catalogListIndex! !

!MarketModel methodsFor: 'product selection' stamp: 'JPF 7/1/2021 17:38:38'!
catalogListIndex: newIndex

	catalogListIndex := newIndex! !

!MarketModel methodsFor: 'product selection' stamp: 'JPF 7/7/2021 23:28:55'!
convertToNumber: value

	| number errorMsg |
	
	errorMsg := 'value must be an integer greater than zero'.
	
	[ number := value asNumber.
	(number isInteger not or: [ number < 1 ]) 
		ifTrue: [self error: errorMsg ] ]
	on: Error 
	do: [:error | self error: errorMsg ].
	
	^ number! !

!MarketModel methodsFor: 'product selection' stamp: 'JPF 6/28/2021 21:54:06'!
quantityToAdd
	
	^ quantityToAdd.! !

!MarketModel methodsFor: 'product selection' stamp: 'JPF 7/1/2021 17:38:53'!
quantityToAdd: newQuantity
	
	quantityToAdd := newQuantity.! !

!MarketModel methodsFor: 'product selection' stamp: 'JPF 7/7/2021 23:38:37'!
selectedProductFromCatalog

	catalogList isEmpty ifTrue: [ self error: self class catalogIsEmptyErrorDescription ].
	catalogListIndex < 1 ifTrue: [ self error: self class noSelectedCatalogItemErrorDescription ].

	^ (catalogList at: catalogListIndex) at: 1.! !


!MarketModel methodsFor: 'ticket' stamp: 'JPF 7/7/2021 18:41:18'!
ticketList

	^ ticketList

	! !

!MarketModel methodsFor: 'ticket' stamp: 'JPF 7/7/2021 18:41:45'!
ticketListIndex

	^ 0

	! !

!MarketModel methodsFor: 'ticket' stamp: 'JPF 7/7/2021 18:41:53'!
ticketListIndex: newIndex

	! !


!MarketModel methodsFor: 'purchase history' stamp: 'JPF 7/6/2021 20:32:27'!
purchaseHistoryList

	^ purchaseHistoryList.! !

!MarketModel methodsFor: 'purchase history' stamp: 'JPF 7/6/2021 20:32:44'!
purchaseHistoryListIndex

	^ 0! !

!MarketModel methodsFor: 'purchase history' stamp: 'JPF 7/6/2021 20:32:56'!
purchaseHistoryListIndex: aNewIndex! !


!MarketModel methodsFor: 'error management' stamp: 'JPF 7/7/2021 22:15:21'!
doSignalingError: aClosure

	[^ aClosure value ] on: Error do: [ :error |
		
		self errorMessage: error messageText.
		self triggerEvent: #errorOccurred with: self.
		]
	! !

!MarketModel methodsFor: 'error management' stamp: 'JPF 7/7/2021 22:11:01'!
doSignalingLoginError: aClosure

	[^ aClosure value ] on: Error do: [ :error |
		
		self errorMessage: error messageText.
		self triggerEvent: #loginErrorOccurred with: self.
		]
	! !

!MarketModel methodsFor: 'error management' stamp: 'JPF 7/7/2021 22:15:16'!
doSignalingMarketError: aClosure

	[^ aClosure value ] on: Error do: [ :error |
		
		self errorMessage: error messageText.
		self triggerEvent: #errorOccurred with: self.
		]
	! !

!MarketModel methodsFor: 'error management' stamp: 'JPF 7/7/2021 20:01:09'!
errorMessage

	^ errorMessage
	! !

!MarketModel methodsFor: 'error management' stamp: 'JPF 7/7/2021 20:00:58'!
errorMessage: anErrorMessage

	errorMessage := anErrorMessage
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarketModel class' category: #'TusLibros-Client'!
MarketModel class
	instanceVariableNames: ''!

!MarketModel class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 23:36:05'!
cartIsEmptyErrorDescription
	
	^ 'The cart is empty'! !

!MarketModel class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 23:38:53'!
catalogIsEmptyErrorDescription
	
	^ 'The catalog is empty'! !

!MarketModel class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 23:36:37'!
noSelectedCartItemErrorDescription

	^ 'No selected cart item'! !

!MarketModel class methodsFor: 'error descriptions' stamp: 'JPF 7/7/2021 23:39:07'!
noSelectedCatalogItemErrorDescription

	^ 'No selected catalog item'! !


!classDefinition: #MarketRestInterface category: #'TusLibros-Client'!
Object subclass: #MarketRestInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!MarketRestInterface methodsFor: 'accessing' stamp: 'JPF 6/28/2021 20:04:05'!
port

	^ port! !

!MarketRestInterface methodsFor: 'accessing' stamp: 'JPF 6/28/2021 20:03:49'!
url
	
	^'http://localhost:', self port asString! !


!MarketRestInterface methodsFor: 'initialization' stamp: 'JPF 6/28/2021 20:03:29'!
initialize

	port := 8080.! !


!MarketRestInterface methodsFor: 'encoding' stamp: 'JPF 6/28/2021 20:36:38'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !


!MarketRestInterface methodsFor: 'utils' stamp: 'JPF 7/7/2021 22:51:56'!
errorMessageFromHtml: htmlText

	| textSeparatedByParagraphs |
	
	textSeparatedByParagraphs := htmlText findBetweenSubStrs: {'<p>'. '</p>'}.
	textSeparatedByParagraphs size > 1 
		ifTrue: [^ textSeparatedByParagraphs at: 2]
		ifFalse: [^ htmlText ]! !

!MarketRestInterface methodsFor: 'utils' stamp: 'JPF 7/7/2021 22:53:46'!
handleJsonResponse: response

	response isSuccess 
		ifTrue:[ ^WebUtils jsonDecode: ((response content) readStream). ] 
		ifFalse:[ ^self error: (self errorMessageFromHtml: response content) ].! !

!MarketRestInterface methodsFor: 'utils' stamp: 'JPF 7/7/2021 22:54:15'!
handleTextResponse: response

	response isSuccess 
		ifTrue:[ ^ (response content) readStream. ] 
		ifFalse:[ ^self error: (self errorMessageFromHtml: response content) ].! !


!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 23:29:19'!
sendAddToCartRequestFor: aQuantity of: aProduct in: aCartId

	| fieldDict response  urlEncodedProduct |

	urlEncodedProduct := self
		correctlyEncodeSpacesForUrlRequestParameter: aProduct.
	fieldDict := Dictionary 
		with: ('quantity'->aQuantity asString)
		with: ('product'->urlEncodedProduct)
		with: ('cartId'->aCartId asString).
	
	response := WebClient htmlSubmit: (self url,'/addToCart') fields: fieldDict method: 'POST'.
	
	self handleTextResponse: response! !

!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 22:53:46'!
sendCheckOutRequestFor: aCartId

	| fieldDict response |

	fieldDict := Dictionary with: ('cartId'->aCartId ).

	response := WebClient htmlSubmit: (self url,'/checkOutCart') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 22:53:46'!
sendCreateCartRequestFor: aClientId authenticatedWith: aPassword

	| fieldDict response urlEncodedClientId urlEncodedPassword |

	urlEncodedClientId := self 
		correctlyEncodeSpacesForUrlRequestParameter: aClientId.	
	urlEncodedPassword := self
		correctlyEncodeSpacesForUrlRequestParameter: aPassword.
	fieldDict := Dictionary 
		with: ('clientId'->urlEncodedClientId)
		with: ('password'->urlEncodedPassword).
	
	response := WebClient htmlSubmit: (self url,'/createCart') fields: fieldDict method: 'POST'.
	
	^ self handleJsonResponse: response.! !

!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 23:26:03'!
sendListCartRequestFor: aCartId

	| fieldDict response |

	fieldDict := Dictionary with: ('cartId'->aCartId ).

	response := WebClient htmlSubmit: (self url,'/listCart') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 22:53:46'!
sendListCatalogRequest

	| response |
	
	response := WebClient htmlSubmit: (self url,'/listCatalog') fields: Dictionary new.
	
	^ self handleJsonResponse: response.! !

!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 22:53:46'!
sendListPurchasesRequestFor: aClientId authenticatedWith: aPassword

	| fieldDict response urlEncodedClientId urlEncodedPassword |

	urlEncodedClientId := self 
		correctlyEncodeSpacesForUrlRequestParameter: aClientId.	
	urlEncodedPassword := self
		correctlyEncodeSpacesForUrlRequestParameter: aPassword.
	fieldDict := Dictionary 
		with: ('clientId'->urlEncodedClientId)
		with: ('password'->urlEncodedPassword).
	
	response := WebClient htmlSubmit: (self url,'/listPurchases') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!MarketRestInterface methodsFor: 'requests' stamp: 'JPF 7/7/2021 22:54:59'!
sendRemoveFromCartRequestFor: aProduct in: aCartId

	| fieldDict response urlEncodedProduct urlEncodedCartId |

	urlEncodedProduct := self
		correctlyEncodeSpacesForUrlRequestParameter: aProduct.
	urlEncodedCartId := aCartId asString.
	
	fieldDict := Dictionary 
		with: ('product'->urlEncodedProduct)
		with: ('cartId'->urlEncodedCartId).
	
	response := WebClient htmlSubmit: (self url,'/removeFromCart') fields: fieldDict method: 'POST'.
	
	self handleTextResponse: response! !
