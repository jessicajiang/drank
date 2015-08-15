//
//  Tool.swift
//  Drank
//
//  Created by Masakazu Bando on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit
import Foundation

private let _ToolSharedInstance = Tool()
private let _StandardUserDefaultsInstance = NSUserDefaults.standardUserDefaults()
private let SESSION_NAME:String = "_drank_server_session"
var SERVERNAME = "sl5.herokuapp.com"
var SERVER = "http://sl5.herokuapp.com"

class Tool {
    class var sharedInstance: Tool {
        return _ToolSharedInstance
    }
    
    class func callREST(params : NSDictionary?, url : String, method: String, completionHandler: ((AnyObject?) -> Void)?) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.URL = NSURL(string: url)!
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        if(params != nil){
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            var err: NSError?
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params!, options: nil, error: &err)
        }
        let vnum:String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        request.addValue("iphone-\(vnum)", forHTTPHeaderField: "Referer")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var jsonerr: NSError?
            var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves, error: &jsonerr)
            if let completion = completionHandler {
                dispatch_async(dispatch_get_main_queue()){
                    if let parseJSON: AnyObject = json {
                        completion(json)
                    } else {
                        completion(nil)
                    }
                }
            }
        })
        task.resume()
    }
    
    class func userDefaults() -> NSUserDefaults {
        return _StandardUserDefaultsInstance
    }
    
    class func setUpCookie(){
        let userProfile = Tool.userDefaults()
        var cookieProperties:NSMutableDictionary = NSMutableDictionary()
        cookieProperties[NSHTTPCookieDomain] = SERVERNAME
        cookieProperties[NSHTTPCookiePath] = "/"
        if(userProfile.stringForKey(SESSION_NAME) != nil){
            cookieProperties[NSHTTPCookieValue] = userProfile.stringForKey(SESSION_NAME)
            cookieProperties[NSHTTPCookieName] = SESSION_NAME
            if let cookie:NSHTTPCookie = NSHTTPCookie(properties: cookieProperties as [NSObject : AnyObject]) {
                NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie)
            }
        }
    }
    
    func saveCookies() {
        var storage:NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        var cookieArray:NSArray = storage.cookies!
        
        let userProfile = Tool.userDefaults()
        
        for cookie in cookieArray{
            if(cookie.name == SESSION_NAME){
                userProfile.setObject((cookie as! NSHTTPCookie).value!, forKey: SESSION_NAME)
            }
        }
        Tool.userDefaults().synchronize()
    }
}

func clearCookies(){
    var storage:NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    var cookieArray:NSArray = storage.cookies!
    for cookie in cookieArray{
        storage.deleteCookie(cookie as! NSHTTPCookie)
    }
    NSUserDefaults.standardUserDefaults().synchronize()
    Tool.userDefaults().removeObjectForKey(SESSION_NAME)
    Tool.userDefaults().synchronize()
}
