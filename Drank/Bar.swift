//
//  Bar.swift
//  Drank
//
//  Created by sloot on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation

class Bar : NSObject, JSONObject {
    var name:String = ""
    var isOpened:Bool = false
    var longitude:CGFloat = 0
    var latitude:CGFloat = 0
    var icon_url:String = ""
    
    required init(json:NSDictionary){
        self.name = json.stringValue("name")
        if let openingHours = json["opening_hours"] as? NSDictionary {
            self.isOpened = openingHours.boolValue("open_now")
        }
        if let geometry = json["geometry"] as? NSDictionary, location = geometry["location"] as? NSDictionary {
            self.longitude = location["lat"] as? CGFloat ?? 0
            self.latitude = location["lng"] as? CGFloat ?? 0
        }
        self.icon_url = json.stringValue("icon")
    }
    
    class func getBars(latitude:CGFloat, longitude:CGFloat, completionHandler: (([Bar]?) -> Void)) {
        let url:String = "https://maps.googleapis.com/maps/api/place/search/json?radius=100&key=AIzaSyClmfaOWfPTif6uSc4TWMMyoyCmesXGJFw&keyword=bar&location=\(latitude),\(longitude)"
        Tool.callREST(nil, url: url, method: "GET") { (response) -> Void in
            if let json = response as? NSDictionary, barsDict = json["results"] as? [NSDictionary] {
                var newBars:[Bar] = []
                for barDict in barsDict {
                    let newBar = Bar(json:barDict)
                    newBars.append(newBar)
                }
                completionHandler(newBars)
            } else {
                completionHandler(nil)
            }
        }
    }
}