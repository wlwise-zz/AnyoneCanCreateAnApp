//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var shoppingList = ["paint", "painter tape", "roller", "drop cloth"]

print(shoppingList.count)


print(shoppingList[2])

shoppingList.append("pan")

print(shoppingList.count)

shoppingList += ["putty"]
print(shoppingList.count)

//shoppingList.append(5)

shoppingList.removeLast()

for item in shoppingList{
    print(item)
}

for x in shoppingList{
    print(x)
}


var states = ["GA": "Georgia", "WA": "Washington"]

print(states.count)

states["OR"] = "Orogon"

print(states.count)

states["OR"] = "Oregon"

print(states["IN"])

states["OR"] = nil

print(states.count)

print(states["OR"])

for (stateAbb, stateName) in states{
    print("\(stateAbb) : \(stateName)")
}


