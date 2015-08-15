//
//  JSONObject.swift
//  Drank
//
//  Created by sloot on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation

protocol JSONObject {
    init(json:NSDictionary)
}

/**
Extension of NSDictionary to help parse json
*/
extension NSDictionary {

    func boolValue(key:String) -> Bool {
        if let value = self[key] as? Bool {
            return value
        } else {
            return (self[key] as? String ?? "false") == "true"
        }
    }
    
    func stringValue(key:String) -> String {
        if let value = self[key] as? String {
            return value
        } else {
            let anyObj:AnyObject = self[key] ?? ""
            let str:String = "\(anyObj)"
            return str
        }
    }
}
