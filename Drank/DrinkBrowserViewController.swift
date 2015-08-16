//
//  DrinkBrowserViewController.swift
//  Drank
//
//  Created by Jessica Jiang on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit

class DrinkBrowserViewController: UIViewController {

    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var drinkImageView: UIImageView!
    
    var newDrink:Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func favoritePressed(sender: AnyObject) {
        let heartImage = "BitMap"
        //backgroundColor = UIColor.colorWithPatternImage(UIImage(named:heartImage))
    }
    
    @IBAction func thumbsDown(sender: AnyObject) {
    }
    
    @IBAction func thumbsUp(sender: AnyObject) {
    }

    @IBAction func saveButton(sender: AnyObject) {
        
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
