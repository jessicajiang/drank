//
//  SubscriptionViewController.swift
//  Drank
//
//  Created by Jessica Jiang on 8/15/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit

class SubscriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var categories:[Category] = []
    
    @IBOutlet weak var categorySubscriptionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Category.getList { (newCategories) -> Void in
            if let newCategories = newCategories {
                self.categories = newCategories
                self.categorySubscriptionCollectionView.reloadData()
            } else {
                println("error")
            }
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath) as! CollectionCell
        let category = categories[indexPath.row]
        cell.categoryName.text = category.name
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let category = categories[indexPath.row]
        Category.putSubscribe(category.id, completionHandler: { (success) -> Void in
            if success {
                
            } else {
                println("something")
            }
        })
        println("hi")
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
