//
//  ViewController.swift
//  TinderCollectionView
//
//  Created by Aseem 20 on 13/04/16.
//  Copyright © 2016 Aseem 20. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
   var photos = ["01","02","03",
                 "04","05","06","07","08","09","10","11","12","Busted"]
    var screensize:CGRect!
    var indexw : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screensize = UIScreen.mainScreen().bounds
    collectionView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCollectionViewCell", forIndexPath: indexPath) as! MyCollectionViewCell
        indexw = indexPath.row
        cell.photo.image = UIImage(named:photos[indexPath.row])
        return cell
    }

    func collectionView(collectionView: UICollectionView, allowMoveAtIndexPath indexPath: NSIndexPath) -> Bool {
      return true
        
    }
    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
         var photo: String
        photo = photos.removeAtIndex(atIndexPath.item)
        photos.insert(photo, atIndex: toIndexPath.item)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   

}

