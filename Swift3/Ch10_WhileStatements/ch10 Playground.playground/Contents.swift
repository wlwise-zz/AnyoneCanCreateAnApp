//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var x = 5
var y = 10

//while (x < y){
//    print("\(x) is less than \(y)")
//    x = x + 1
//}

while x < y {
    print("\(x) is less than \(y)")
    y = y - 1
}

var a = 11

switch a {
case 1,3,5,7,11,13:
    print ("value must be a prime")
case 2, 4, 6, 8, 9, 12:
    print ("value is not a prime")
default:
    print("number is not in our range")
}

var heading = "east"

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

