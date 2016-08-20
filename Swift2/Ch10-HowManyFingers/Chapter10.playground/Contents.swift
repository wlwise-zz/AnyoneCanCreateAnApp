//: Playground - noun: a place where people can play

import UIKit


var x = 5
var y = 10
while (x < 10){
    print("\(x) is less the \(y)")
    x = x+1
    //y--
    //x++
}


var a = 11

switch a {
case 1, 3, 5, 7, 11, 13:
    print("value is a prime number")
case 2, 4, 6, 8, 9, 10, 12:
    print("value is not a prime number")
default:
    print("value is not wihtin range")
}

var heading = "East"

switch heading {
case "north":
    print("heading north")
case "south":
    print("heading south")
case "east":
    print("heading east")
case "west":
    print("heading west")
default:
    print("where are you headed again?")
}


var myRange = 1...31

for i in myRange {
    print("the number is \(i)")
}

var range = Range(start: 1, end: 31)

for i in range {
    print("range value is \(i)")
}




let greeting = "Apps for Anyone is wicked awesome!"

var i = 0

while i < 10 {
    print("\(i) - \(greeting)")
    i++
}


for i in 1...10 {
    if i == 3{
        print(greeting.uppercaseString)
    }else if i == 5 {
        print(greeting.lowercaseString)
    }else {
        print(greeting.capitalizedString)
    }
}






switch heading {
    case "north", "south":
        print("heading vertical")
    case "east", "west":
        print("heading horizontal")
    default:
        print("where are you going???")
}


var grade = 85

switch grade {
case 90..<100:
    print("you got an A")
case 80..<90:
    print("you got a B")
case 70..<80:
    print("you got a C")
case 60..<70:
    print("you got a D")
case 1..<60:
    print("you got an F")
default:
    print("you did not take the quiz, therefore you got a 0")
}

var myArray : [AnyObject] = [AnyObject]()

myArray.append("hello")
myArray.append(1)
