//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var x = 5
var y = 10

if x < y {
    print("yes")
}

var a = 5

var b = 10

var c = 15

if a > b || b < c {
    print("yes")
}

var d = 5
var e = 10
var f = 15

if (d < e && e < f){
    print("yes")
}

//or you can write it this way

if (d < e) && (e < f) {
    print("yes")
}

var g = 5
var h = 10

if g < h {
    print("\(g) is less than \(h)")
} else if g > h {
    print ("\(g) is greater than \(h)")
}

var i = 5
var j = 5

if (i < j) {
    print("\(i) is less than \(j)")
} else if g > h {
    print ("\(i) is greater than \(j)")
}
else {
    print("\(i) must be equal to \(j)")
}
