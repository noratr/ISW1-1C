!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'jpf 4/17/2021 16:26:19'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 22:17:15'!
addFraction: fractionalAdder
	
	self subclassResponsibility! !

!Numero methodsFor: 'auxiliar operations' stamp: 'JPF 4/19/2021 20:45:23'!
addInteger: integerAdder

	self subclassResponsibility.
	
	! !

!Numero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 22:18:31'!
divideFraction: fractionalDividend
	
	self subclassResponsibility! !

!Numero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 22:18:16'!
divideInteger: integerDividend
	
	self subclassResponsibility! !

!Numero methodsFor: 'auxiliar operations' stamp: 'JPF 4/19/2021 21:10:29'!
multiplyFraction: fractionalMultiplier

	self subclassResponsibility.! !

!Numero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 21:54:32'!
multiplyInteger: integerMultiplier
	
	self subclassResponsibility.! !

!Numero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 22:17:43'!
subtractFromFraction: fractionalMinuend
	
	self subclassResponsibility! !

!Numero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 22:18:00'!
subtractFromInteger: integerMinuend
	
	self subclassResponsibility! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 07:39:35'!
addFraction: fractionalAdder

	^fractionalAdder addInteger: self.! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 18:18:56'!
addInteger: integerAdder

	^self class with: self integerValue + integerAdder integerValue.! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 21:23:29'!
divideFraction: fractionalDividend
	
	^Fraccion 
		with: fractionalDividend numerator 
		over: fractionalDividend denominator * self.! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 21:14:19'!
divideInteger: integerDividend
	
	^Fraccion with: integerDividend over: self.! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 07:41:02'!
multiplyFraction: fractionalMultiplier
	
	^fractionalMultiplier multiplyInteger: self.! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 18:19:15'!
multiplyInteger: integerMultiplier
	
	^self class with: (self integerValue * integerMultiplier integerValue).! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 18:23:29'!
subtractFromFraction: fractionalMinuend

	^Fraccion 
		with: fractionalMinuend numerator - (self * fractionalMinuend denominator)
		over: fractionalMinuend denominator.! !

!Entero methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 20:36:01'!
subtractFromInteger: integerMinuend
	
	^self class with: (integerMinuend integerValue - self integerValue).! !


!Entero methodsFor: 'arithmetic operations' stamp: 'jpf 4/21/2021 18:19:42'!
* aMultiplier
	
	^aMultiplier multiplyInteger: (self class with: self integerValue).
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jpf 4/21/2021 18:19:56'!
+ anAdder

	^anAdder addInteger: (self class with: self integerValue).
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 20:33:32'!
- aSubtrahend
	
	^aSubtrahend subtractFromInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 21:11:27'!
/ aDivisor 
	
	^aDivisor divideInteger: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jpf 4/21/2021 18:20:14'!
// aDivisor 
	
	^self class with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JPF 4/19/2021 21:32:06'!
fibonacci

	self subclassResponsibility.
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jpf 4/21/2021 18:20:29'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (self integerValue gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'jpf 4/21/2021 18:18:08'!
= anObject

	^(anObject isKindOf: self class) and: [ self integerValue = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'jpf 4/21/2021 18:18:27'!
hash

	^self integerValue hash! !


!Entero methodsFor: 'value' stamp: 'jpf 4/21/2021 18:34:05'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	self subclassResponsibility.! !


!Entero methodsFor: 'printing' stamp: 'jpf 4/21/2021 18:21:09'!
printOn: aStream

	aStream print: self integerValue. ! !


!Entero methodsFor: 'testing' stamp: 'jpf 4/21/2021 18:21:23'!
isNegative
	
	^self integerValue < 0! !

!Entero methodsFor: 'testing' stamp: 'jpf 4/21/2021 18:21:33'!
isOne
	
	^self integerValue = 1! !

!Entero methodsFor: 'testing' stamp: 'jpf 4/21/2021 18:21:45'!
isZero
	
	^self integerValue = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'jpf 4/21/2021 19:00:01'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	(aValue < 0) ifTrue: [^ Negativo new initializeWith: aValue].
	(aValue = 0) ifTrue: [^ Cero new].
	(aValue = 1) ifTrue: [^ Uno new].
	
	^ NaturalMayorAUno new initializeWith: aValue.! !


!Entero class methodsFor: 'error descriptions' stamp: 'jpf 4/21/2021 19:04:40'!
negativeFibonacciErrorDescription
	"Este mensaje nosotros pensamos que deberia ir en Negativo, pero no lo cambiamos ya que en un test se accedia desde Entero"
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 21:39:50'!
fibonacci

	^self class with: 1.! !


!Cero methodsFor: 'value' stamp: 'jpf 4/21/2021 18:12:53'!
integerValue
	
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'value' stamp: 'jpf 4/21/2021 18:10:23'!
integerValue
	
	^0.! !


!classDefinition: #EnteroMayorAUnoOMenorACero category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUnoOMenorACero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUnoOMenorACero methodsFor: 'initialization' stamp: 'jpf 4/21/2021 18:50:32'!
initializeWith: aValue 
	
	value := aValue! !


!EnteroMayorAUnoOMenorACero methodsFor: 'value' stamp: 'jpf 4/21/2021 18:38:31'!
integerValue
	
	^value.! !


!classDefinition: #NaturalMayorAUno category: 'Numero-Exercise'!
EnteroMayorAUnoOMenorACero subclass: #NaturalMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NaturalMayorAUno methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 22:40:46'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci.! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
EnteroMayorAUnoOMenorACero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 22:25:09'!
fibonacci

	^self error: Entero negativeFibonacciErrorDescription.! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'jpf 4/21/2021 18:13:39'!
fibonacci
	
	^self class new.! !


!Uno methodsFor: 'value' stamp: 'jpf 4/21/2021 18:12:19'!
integerValue
	
	^1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 20:55:38'!
addFraction: fractionalAdder
	
	^self class 
		with: (numerator * fractionalAdder denominator) + (denominator * fractionalAdder numerator)
		over: denominator * fractionalAdder denominator.! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 07:40:07'!
addInteger: integerAdder

	^self class with: denominator * integerAdder + numerator over: denominator.
	
! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 21:19:50'!
divideFraction: fractionalDividend

	^self class 
		with: fractionalDividend numerator * denominator
		over: fractionalDividend denominator * numerator.
	! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 21:16:26'!
divideInteger: integerDividend
	
	^self class
		with: integerDividend * denominator 
		over: numerator.! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/18/2021 20:37:14'!
multiplyFraction: fractionalMultiplier 
	
	^self class with: (numerator * fractionalMultiplier numerator) over: (denominator * fractionalMultiplier denominator).
	! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/21/2021 07:41:44'!
multiplyInteger: integerMultiplier
	
	^self class with: numerator * integerMultiplier over: denominator.! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 20:59:57'!
subtractFromFraction: fractionalMinuend
	
	^self class
		with: (denominator * fractionalMinuend numerator) - (numerator * fractionalMinuend denominator) 
		over: denominator * fractionalMinuend denominator.! !

!Fraccion methodsFor: 'auxiliar operations' stamp: 'jpf 4/20/2021 21:01:23'!
subtractFromInteger: integerMinuend
	
	^self class with: integerMinuend * denominator - numerator over: denominator.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'jpf 4/18/2021 20:38:16'!
* aMultiplier 
	
	^aMultiplier multiplyFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jpf 4/18/2021 20:35:00'!
+ anAdder

	^anAdder addFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 20:41:57'!
- aSubtrahend 
	
	^aSubtrahend subtractFromFraction: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jpf 4/20/2021 21:22:45'!
/ aDivisor 
	
	^aDivisor divideFraction: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
