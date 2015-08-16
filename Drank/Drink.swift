//
//  Drink.swift
//  Drank
//
//  Created by sloot on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation

class Drink : NSObject, JSONObject {
    var id:String = ""
    var name:String = ""
    var img_url:String = ""
    var ingredients:[Ingredient] = []
    var liked:Bool = false
    var disliked:Bool = false
    
    required init(json:NSDictionary){
        self.name = json.stringValue("name")
        self.id = json.stringValue("id")
        self.img_url = json.stringValue("img_url")
        self.liked = json.boolValue("liked")
        self.disliked = json.boolValue("disliked")
        if let ingredientsJson = json["ingredients"] as? [NSDictionary] {
            var newIngredients:[Ingredient] = []
            for ingredientJson in ingredientsJson {
                newIngredients.append(Ingredient(json: ingredientJson))
            }
            self.ingredients = newIngredients
        }
    }
    
    /**
    In Completion
    Returns false if error
    Returns true if successful
    */
    static func putLike(drink_id:String, category_id:String, completionHandler: ((Bool) -> Void)) {
        let url:String = SERVER + "/drinks/like.json"
        var inputDict:NSMutableDictionary = NSMutableDictionary()
        inputDict["drink_id"] = drink_id
        inputDict["category_id"] = category_id
        Tool.callREST(inputDict, url: url, method: "PUT") { (response) -> Void in
            if let json = response as? NSDictionary where json.stringValue("status") == "success" {
                completionHandler(true)
            } else {
                completionHandler(false)
                println("ERROR: PUT DRINKS LIKE")
            }
        }
    }
    
    /**
    In Completion
    Returns false if error
    Returns true if successful
    */
    static func putDislike(drink_id:String, category_id:String, completionHandler: ((Bool) -> Void)) {
        let url:String = SERVER + "/drinks/dislike.json"
        var inputDict:NSMutableDictionary = NSMutableDictionary()
        inputDict["drink_id"] = drink_id
        inputDict["category_id"] = category_id
        Tool.callREST(inputDict, url: url, method: "PUT") { (response) -> Void in
            if let json = response as? NSDictionary where json.stringValue("status") == "success" {
                completionHandler(true)
            } else {
                completionHandler(false)
                println("ERROR: PUT DRINKS LIKE")
            }
        }
    }
    
    /**
    In Completion
    Returns nil if error
    Returns array of Drink when successful
    */
    static func getTopDrinks(count:Int, completionHandler: (([Drink]?)) -> Void) {
        let url:String = SERVER + "/drinks/top.json?count=\(count)"
        Tool.callREST(nil, url: url, method: "GET") { (response) -> Void in
            if let json = response as? NSDictionary, drinks = json["drinks"] as? [NSDictionary] {
                var newDrinks:[Drink] = []
                for drinkJson in drinks {
                    newDrinks.append(Drink(json: drinkJson))
                }
                completionHandler(newDrinks)
            } else {
                println("ERROR: GET TOP DRINKS")
                completionHandler(nil)
            }
        }
    }
    
    /**
    In Completion
    Returns false if error
    Returns true if successful
    */
    static func postFavorite(drink_id:String, completionHandler: ((Bool) -> Void)) {
        let url:String = SERVER + "/drinks/like.json"
        var inputDict:NSMutableDictionary = NSMutableDictionary()
        inputDict["drink_id"] = drink_id
        Tool.callREST(inputDict, url: url, method: "POST") { (response) -> Void in
            if let json = response as? NSDictionary where json.stringValue("status") == "success" {
                completionHandler(true)
            } else {
                completionHandler(false)
                println("ERROR: POST DRINKS FAVORITE")
            }
        }
    }
    
    /**
    In Completion
    Returns false if error
    Returns true if successful
    */
    static func deleteFavorite(drink_id:String, completionHandler: ((Bool) -> Void)) {
        let url:String = SERVER + "/drinks/like.json"
        var inputDict:NSMutableDictionary = NSMutableDictionary()
        inputDict["drink_id"] = drink_id
        Tool.callREST(inputDict, url: url, method: "DELETE") { (response) -> Void in
            if let json = response as? NSDictionary where json.stringValue("status") == "success" {
                completionHandler(true)
            } else {
                completionHandler(false)
                println("ERROR: DELETE DRINKS FAVORITE")
            }
        }
    }
    
    /**
    In Completion
    Returns nil if error
    Returns array of Drink when successful
    */
    static func getFavoriteDrinks(completionHandler: (([Drink]?) -> Void)) {
        let url:String = SERVER + "/drinks/favorite_list.json"
        Tool.callREST(nil, url: url, method: "GET") { (response) -> Void in
            if let json = response as? NSDictionary, drinks = json["drinks"] as? [NSDictionary] {
                var newDrinks:[Drink] = []
                for drinkJson in drinks {
                    newDrinks.append(Drink(json: drinkJson))
                }
                completionHandler(newDrinks)
            } else {
                println("ERROR: GET FAVORITE DRINKS")
                completionHandler(nil)
            }
        }
    }
}