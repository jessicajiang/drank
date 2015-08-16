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
    
    @IBOutlet weak var barTableView: UITableView!
    var locationManager:CLLocationManager!
    
    var bars:[Bar] = [] {
        didSet {
            println(bars.count)
            barTableView.reloadData()
        }
    }
    
    var currentLocation:CLLocation? {
        didSet {
            if let currentLocation = currentLocation {
                let longitude = CGFloat(currentLocation.coordinate.longitude)
                let latitude = CGFloat(currentLocation.coordinate.latitude)
                Bar.getBars(latitude, longitude: longitude) { (newBars) -> Void in
                    if let newBars = newBars {
                        self.bars = newBars
                    } else {
                        println("error")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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

extension SearchBarViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell:BarCellTableViewCell = tableView.dequeueReusableCellWithIdentifier(
                "barCell",
                forIndexPath: indexPath) as! BarCellTableViewCell
            let bar = bars[indexPath.row]
            cell.barNameLabel.text = bar.name
            cell.barImageView.smartLoad(bar.barPhotoURL())
            return cell
    }
}

extension SearchBarViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.stopUpdatingLocation()
        currentLocation = manager.location
    }
}