//
//  Ingredient.swift
//  Drank
//
//  Created by sloot on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation

class Ingredient : NSObject, JSONObject {
    var name:String = ""
    var amount:String = ""
    
    required init(json:NSDictionary){
        self.name = json.stringValue("name")
        self.amount = json.stringValue("amount")
    }
}