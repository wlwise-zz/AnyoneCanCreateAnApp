//
//  Lion.swift
//  LioN
//
//  Created by Wendy Wise on 9/13/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import Foundation

class Lion : NSObject, NSCoding{
    
    var lionName = ""
    var lionDescription = ""
    var like = 1
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(lionName, forKey: "LionName")
        aCoder.encodeObject(lionDescription, forKey: "LionDescription")
        aCoder.encodeInteger(like, forKey: "Like")
    }
    
    required init(coder aDecoder: NSCoder){
        super.init()
        lionName = aDecoder.decodeObjectForKey("LionName") as! String
        lionDescription = aDecoder.decodeObjectForKey("LionDescription") as! String
        like = aDecoder.decodeIntegerForKey("Like")
    }
    
    override init(){
        super.init()
    }
    
}