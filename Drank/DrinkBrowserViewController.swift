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
    
    var isFavorited:Bool = false
    
    var selectedCategory:Category! {
        didSet {
            Category.getDrinkRecommendation(selectedCategory.id, completionHandler: { (drink) -> Void in
                self.selectedDrink = drink
            })
        }
    }
    
    var selectedDrink:Drink? {
        didSet {
            if let drink = selectedDrink {
                drinkLabel.text = drink.name
                drinkImageView.smartLoad(drink.img_url)
            } else {
                println("No drink")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //drinkImageView.smartLoad(<#imgurl: String#>)
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func favoritePressed(sender: AnyObject) {
        if let drink = selectedDrink {
            if isFavorited {
                isFavorited = false
                Drink.deleteFavorite(drink.id, completionHandler: { (success) -> Void in
                    //nothing to do in completion for now
                })
            } else {
                isFavorited = true
                Drink.postFavorite(drink.id, completionHandler: { (success) -> Void in
                    println("favorited")
                })
            }
        }
    }
    
    @IBAction func thumbsDown(sender: AnyObject) {
        if let drink = selectedDrink {
            Drink.putDislike(drink.id, category_id: selectedCategory.id, completionHandler: { (success) -> Void in
                println("disliked")
            })
        }
    }
    
    @IBAction func thumbsUp(sender: AnyObject) {
        if let drink = selectedDrink {
            Drink.putLike(drink.id, category_id: selectedCategory.id, completionHandler: { (success) -> Void in
                //nothing to do in completion for now
                println("liked")
            })
        }
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
