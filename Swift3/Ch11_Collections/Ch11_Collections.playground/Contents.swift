//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var shoppingList = ["paint", "painter tape", "roller", "drop cloth"]

print(shoppingList.count)

print(shoppingList[2])

shoppingList.append("pan")

print(shoppingList.count)

//shoppingList.append(5) <- this will cause an error

shoppingList.removeLast()

for item in shoppingList {
    print(item)
}

for x in shoppingList {
    print(x)
}

var states = ["GA": "Georgia", "WA": "Washington"]

print(states.count)

states["OR"] = "Orogon"

print(states.count)

states["OR"] = "Oregon"

print(states["OR"])

print(states["IN"])

states["OR"] = nil

print(states["OR"])

for (stateAbb, stateName) in states{
    print("\(stateAbb) : \(stateName)")
}


