//
//  Category.swift
//  Drank
//
//  Created by sloot on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation

class Category : NSObject, JSONObject {
    var id:String = ""
    var name:String = ""
    var subscribed:Bool = false
    
    required init(json:NSDictionary){
        self.name = json.stringValue("name")
        self.id = json.stringValue("id")
        self.subscribed = json.boolValue("subscribed")
    }
}