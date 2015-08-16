//
//  Extension.swift
//  Drank
//
//  Created by Jessica Jiang on 8/14/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func circleCrop() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2.0
    }
}

var imageCache:NSCache = NSCache()
extension UIImageView {
    func smartLoad(imgurl:String){
        image = nil
        
        var newtag = Int(arc4random_uniform(1048575))
        tag = newtag
        if let img = imageCache.objectForKey(imgurl) as? UIImage {
            self.image = img
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                if let url = NSURL(string: imgurl) {
                    let request: NSURLRequest = NSURLRequest(URL: url)
                    NSURLConnection.sendAsynchronousRequest(
                        request, queue: NSOperationQueue.mainQueue(),
                        completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                            if error == nil {
                                if let retrievedImage = UIImage(data: data) {
                                    if self.tag == newtag {
                                        dispatch_async(dispatch_get_main_queue()){
                                            self.image = retrievedImage
                                        }
                                    }
                                    imageCache.setObject(retrievedImage, forKey: imgurl, cost: 0)
                                }
                            }
                    })
                }
            }
        }
    }
}