//
//  LioN.swift
//  LioN
//
//  Created by Wendy Wise on 9/24/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import Foundation

class Lion : NSObject, NSCoding {
    var lionName = ""
    var lionDescription = ""
    var like : Bool = true
    
    required init(coder aDecoder : NSCoder) {
        super.init()
        lionName = aDecoder.decodeObject(forKey: "lionName") as! String
        lionDescription = aDecoder.decodeObject(forKey: "lionDescription") as! String
        like = aDecoder.decodeBool(forKey: "like") 
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lionName, forKey: "lionName")
        aCoder.encode(lionDescription, forKey: "lionDescription")
        aCoder.encode(like, forKey: "like")
    }
    
    override init() {
        super.init()
    }
}
