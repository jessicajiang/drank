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
    
    /**
    In Completion
    Returns nil if error
    Returns array of Category when successful
    */
    static func getList(completionHandler: (([Category]?) -> Void)) {
        let url:String = SERVER + "/categories/list.json"
        Tool.callREST(nil, url: url, method: "GET") { (response) -> Void in
            if let json = response as? NSDictionary, categories = json["categories"] as? [NSDictionary] {
                var newCategories:[Category] = []
                for categoryJson in categories {
                    newCategories.append(Category(json: categoryJson))
                }
                completionHandler(newCategories)
            } else {
                println("ERROR: GET CATEGORIES LIST")
                completionHandler(nil)
            }
        }
    }

    /**
    In Completion
    Returns nil if error
    Returns array of Category when successful
    */
    static func getSubscribed(completionHandler: (([Category]?) -> Void)) {
        let url:String = SERVER + "/categories/subscribed.json"
        Tool.callREST(nil, url: url, method: "GET") { (response) -> Void in
            if let json = response as? NSDictionary, categories = json["categories"] as? [NSDictionary] {
                var newCategories:[Category] = []
                for categoryJson in categories {
                    newCategories.append(Category(json: categoryJson))
                }
                completionHandler(newCategories)
            } else {
                println("ERROR: GET CATEGORIES SUBSCRIBED")
                completionHandler(nil)
            }
        }
    }

    /**
    In Completion
    Returns false if error
    Returns true if successful
    */
    static func putSubscribe(category_id:String, completionHandler: ((Bool) -> Void)) {
        let url:String = SERVER + "/categories/subscribe.json"
        var inputDict:NSMutableDictionary = NSMutableDictionary()
        inputDict["category_id"] = category_id
        Tool.callREST(inputDict, url: url, method: "PUT") { (response) -> Void in
            if let json = response as? NSDictionary where json.stringValue("status") == "success" {
                completionHandler(true)
            } else {
                completionHandler(false)
                println("ERROR: PUT CATEGORIES SUBSCRIBE")
            }
        }
    }

    /**
    In Completion
    Returns nil if error
    Returns Drink Object if successful
    */
    static func getDrinkRecommendation(category_id:String, completionHandler: ((Drink?) -> Void)) {
        let url:String = SERVER + "/categories/recommend_drink.json?category_id=" + category_id
        Tool.callREST(nil, url: url, method: "GET") { (response) -> Void in
            if let json = response as? NSDictionary, drinkJson = json["drink"] as? NSDictionary {
                let drink = Drink(json:drinkJson)
                completionHandler(drink)
            } else {
                completionHandler(nil)
                println("ERROR: GET CATEGORIES RECOMMEND DRINK")
            }
        }
    }
}