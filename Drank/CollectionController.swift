//
//  CollectionController.swift
//  Drank
//
//  Created by Jessica Jiang on 8/14/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var subscribedCategories:[Category] = []
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var selectedCategory:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Category.getSubscribed { (newCategories) -> Void in
            if let newCategories = newCategories {
                self.subscribedCategories = newCategories
                self.categoryCollectionView.reloadData()
            } else {
                println("error")
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("drinkCell", forIndexPath: indexPath) as! CollectionCell
        let category = subscribedCategories[indexPath.row]
        cell.categoryName.text = category.name
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let category = subscribedCategories[indexPath.row]
        selectedCategory = category
        self.performSegueWithIdentifier("collectionPressed", sender: self)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscribedCategories.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextViewController = segue.destinationViewController as? DrinkBrowserViewController, category = selectedCategory {
            nextViewController.selectedCategory = category
        }
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue){
    
    }
}