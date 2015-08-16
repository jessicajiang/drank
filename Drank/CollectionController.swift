//
//  CollectionController.swift
//  Drank
//
//  Created by Jessica Jiang on 8/14/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let reuseIdentifier = "drinkCell"
    //private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    var subscribedCategories:[Category] = []
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
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
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscribedCategories.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue){
    
    }
}