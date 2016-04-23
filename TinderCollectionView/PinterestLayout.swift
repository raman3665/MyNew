//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by ernesto on 01/06/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit
class PinteresrLayout:UICollectionViewLayout {
    //2. Configurable properties
    var numberOfColumns = 2
    var cellPadding: CGFloat!
    var photoHeight: CGFloat!
    var itemSpacing: CGFloat!
    var lineSpacing: CGFloat!
    var sectionSpacing: CGFloat!
    var collectionViewSize: CGSize?
    var insets: UIEdgeInsets!
    var largeCellSize:CGSize?
    var smallCellSize:CGSize?
    var ptx : CGFloat?
    var pty : CGFloat?
    var height : CGFloat?
    var width : CGFloat?

    //3. Array to keep a cache of attributes.
    private var cache = [UICollectionViewLayoutAttributes]()
    //4. Content height and size
    private var contentHeight:CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }

    override func prepareLayout() {
        collectionViewSize = self.collectionView?.bounds.size
        cellPadding = 6.0
        itemSpacing = 5.0
        lineSpacing = 5.0
        sectionSpacing = 5.0
        insets = UIEdgeInsetsMake(5.0, 0, 5.0, 0)
        // 1. Only calculate once
        if cache.isEmpty {
        for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
    let indexPath = NSIndexPath(forItem: item, inSection: 0)
    // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
    let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
   attributes.frame = setcontentframe(indexPath)
    cache.append(attributes)
            }
            
        }
    }
    
    func setcontentframe(indexPath:NSIndexPath)->CGRect{
        
        var attribute: UICollectionViewLayoutAttributes?
        
        let largeCellSideLength: CGFloat = (2.0 * (collectionViewSize!.width - insets!.left - insets!.right) - itemSpacing!) / 3.0
        let smallCellSideLength: CGFloat = (largeCellSideLength - itemSpacing!) / 2.0
        let line: Int = indexPath.item / 3
        let line1 : Int = indexPath.item/6
        
        let linespaceforindexpath:CGFloat = lineSpacing * CGFloat(line1)
        let lineOriginY: CGFloat = largeCellSideLength+insets.top
        let lineoriginYy : CGFloat = (largeCellSideLength + smallCellSideLength + insets.top) * CGFloat(line1) + linespaceforindexpath
        var rightSideLargeCellOriginX: CGFloat = collectionViewSize!.width - largeCellSideLength - insets.right
        let  rightSideSmallCellOriginX: CGFloat = collectionViewSize!.width - smallCellSideLength - insets.right
        if indexPath.item % 6 == 0 {
            ptx = insets.left
            pty = lineoriginYy
            height = largeCellSideLength
            width = largeCellSideLength
        }
        else if (indexPath.item + 1) % 6 == 0 {
            ptx = insets.left + (smallCellSideLength + itemSpacing)*2
            pty = lineOriginY+lineoriginYy
            height = smallCellSideLength
            width = smallCellSideLength
        }
        else if line % 2 == 0 {
            if indexPath.item % 2 != 0 {
            ptx = rightSideSmallCellOriginX
            pty = lineoriginYy
            height = smallCellSideLength
            width = smallCellSideLength
            }
            else {
            ptx = rightSideSmallCellOriginX
            pty = lineoriginYy + smallCellSideLength + itemSpacing
            width = smallCellSideLength
            height = smallCellSideLength
            }
        }
        else {
            if indexPath
                .item % 2 != 0 {
                ptx = insets.left
                pty = lineOriginY+lineoriginYy
                width = smallCellSideLength
                height = smallCellSideLength
            }
            else {
                ptx = insets.left + smallCellSideLength + itemSpacing
                pty = lineOriginY+lineoriginYy
                width = smallCellSideLength
                height = smallCellSideLength
            }
                //self.smallCellSizeArr[indexPath.row] = CGSizeMake(smallCellSize!.width, smallCellSize!.height)
        }
        let rect = CGRectMake(ptx!, pty!, width!, height!)
                return rect
        
            
    }
//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
//        
//    }
    
    override func collectionViewContentSize() -> CGSize {
        var largeCellSideLength: CGFloat = (2.0 * (collectionViewSize!.width - insets!.left - insets!.right) - itemSpacing!) / 3.0
        var numberoflines:Int = (self.collectionView?.numberOfItemsInSection(0))!/3 + 1
         var lineheight:CGFloat = CGFloat(numberoflines)*(largeCellSideLength + lineSpacing) - lineSpacing
        contentHeight = insets.top + insets.bottom + lineheight
        return CGSize(width: contentWidth, height: contentHeight)
        
    }
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
     return true
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}



