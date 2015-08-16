//
//  SearchBarViewController.swift
//  Drank
//
//  Created by Jessica Jiang on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit
import CoreLocation

class SearchBarViewController: UIViewController {
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchBarViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {

    }
}