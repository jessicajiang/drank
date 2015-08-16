//
//  Bar.swift
//  Drank
//
//  Created by sloot on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Bar : NSObject, JSONObject {
    var name:String = ""
    var isOpened:Bool = false
    var longitude:CGFloat = 0
    var latitude:CGFloat = 0
    var icon_url:String = ""
    var photoRef:String = ""
    
    required init(json:NSDictionary){
        self.name = json.stringValue("name")
        if let openingHours = json["opening_hours"] as? NSDictionary {
            self.isOpened = openingHours.boolValue("open_now")
        }
        if let geometry = json["geometry"] as? NSDictionary, location = geometry["location"] as? NSDictionary {
            self.longitude = location["lng"] as? CGFloat ?? 0
            self.latitude = location["lat"] as? CGFloat ?? 0
        }
        self.icon_url = json.stringValue("icon")
        if let photos = json["photos"] as? [NSDictionary], photo = photos.first {
            self.photoRef = photo.stringValue("photo_reference")
        }
    }
    
    class func getBars(latitude:CGFloat, longitude:CGFloat, completionHandler: (([Bar]?) -> Void)) {
        let url:String = "https://maps.googleapis.com/maps/api/place/search/json?radius=1000&key=AIzaSyClmfaOWfPTif6uSc4TWMMyoyCmesXGJFw&keyword=bar&location=\(latitude),\(longitude)"
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
    
    func barPhotoURL() -> String {
        if count(self.photoRef) > 0 {
            let photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(self.photoRef)&sensor=false&key=AIzaSyClmfaOWfPTif6uSc4TWMMyoyCmesXGJFw"
            return photoURL
        } else {
            return ""
        }
    }
    
    func openMaps(){
        var options:[NSObject : AnyObject] = NSDictionary() as [NSObject : AnyObject]
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
        var pm = MKPlacemark(coordinate: location, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: pm)
        mapItem.name = self.name
        mapItem.openInMapsWithLaunchOptions(options)
    }
}