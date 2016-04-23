////
////  RAReorderableLayout.swift
////  RAReorderableLayout
////
////  Created by Ryo Aoyama on 10/12/14.
////  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
////
//
//import UIKit
//
//@objc public protocol RAReorderableLayoutDelegate: UICollectionViewDelegateFlowLayout {
//   optional func collectionView(collectionView: UICollectionView, sizeForLargeItemsInSection section: Int) -> CGSize
//   optional func insetsForCollectionView(collectionView: UICollectionView) -> UIEdgeInsets
//    
//   optional func sectionSpacingForCollectionView(collectionView: UICollectionView) -> CGFloat
//    
//   optional func minimumInteritemSpacingForCollectionView(collectionView: UICollectionView) -> CGFloat
//    
//   optional func minimumLineSpacingForCollectionView(collectionView: UICollectionView) -> CGFloat
//}
//
//@objc public protocol RAReorderableLayoutDataSource: UICollectionViewDataSource {
//}
//
//public class RAReorderableLayout: UICollectionViewFlowLayout, UIGestureRecognizerDelegate {
//    var numberOfCells: Int?
//    var numberOfLines: CGFloat?
//    var itemSpacing: CGFloat?
//    var lineSpacing: CGFloat?
//    var sectionSpacing: CGFloat?
//    var collectionViewSize: CGSize?
//    var insets: UIEdgeInsets?
//    var oldRect: CGRect?
//    var largeCellSize:CGSize?
//    var smallCellSize:CGSize?
//    var arr = []
//    var largeCellSizeArr = []
//
//    var smallCellSizeArr = []
//    public weak var delegate: RAReorderableLayoutDelegate? {
//        get { return collectionView?.delegate as? RAReorderableLayoutDelegate }
//        set { collectionView?.delegate = delegate }
//    }
//    
//    public weak var datasource: RAReorderableLayoutDataSource? {
//        set { collectionView?.delegate = delegate }
//        get { return collectionView?.dataSource as? RAReorderableLayoutDataSource }
//    }
//  
//    override public func prepareLayout() {
//        collectionViewSize = self.collectionView?.bounds.size;
//        //some values
//        itemSpacing = 0
//        lineSpacing = 0
//        sectionSpacing = 0
//        insets = UIEdgeInsetsMake(0, 0, 0, 0)
//    if(self.delegate!.respondsToSelector("minimumInteritemSpacingForCollectionView:")){
//          itemSpacing = self.delegate?.minimumInteritemSpacingForCollectionView!(self.collectionView!)
//        }
//        if(self.delegate!.respondsToSelector("minimumLineSpacingForCollectionView:")){
//        lineSpacing = self.delegate?.minimumLineSpacingForCollectionView!(self.collectionView!)
//        }
//        if(self.delegate!.respondsToSelector("sectionSpacingForCollectionView:")){
//        sectionSpacing = self.delegate?.sectionSpacingForCollectionView!(self.collectionView!)
//        }
//    if(self.delegate!.respondsToSelector("insetsForCollectionView:")){
//         insets = self.delegate?.insetsForCollectionView!(self.collectionView!)
//        }
//    }
//    
//    func contentHeight() -> CGFloat {
//        var content_height:CGFloat = 0
//        var insets:UIEdgeInsets = UIEdgeInsetsZero
//        var sectionSpacing:CGFloat = 0
//        var lineSpacing :CGFloat = 0
//        var itemSpacing:CGFloat = 0
//        var collectionViewSize:CGSize = (self.collectionView?.bounds.size)!
//    if(self.delegate!.respondsToSelector("minimumInteritemSpacingForCollectionView:")){
//            itemSpacing = (self.delegate?.minimumInteritemSpacingForCollectionView!(self.collectionView!))!
//        }
//    if(self.delegate!.respondsToSelector("minimumLineSpacingForCollectionView:")){
//            lineSpacing = (self.delegate?.minimumLineSpacingForCollectionView!(self.collectionView!))!
//        }
//    if(self.delegate!.respondsToSelector("sectionSpacingForCollectionView:")){
//            sectionSpacing = (self.delegate?.sectionSpacingForCollectionView!(self.collectionView!))!
//        }
//    if(self.delegate!.respondsToSelector("insetsForCollectionView:")){
//            insets = (self.delegate?.insetsForCollectionView!(self.collectionView!))!
//        }
//
//    content_height += insets.top + insets.bottom
//        var lastsmallcellHeight:CGFloat = 0
//        var numberoflines:Int = (self.collectionView?.numberOfItemsInSection(0))!/3 + 1
//        var largeCellSideLength:CGFloat = (2*(collectionViewSize.width - insets.left - insets.right)-itemSpacing)/3.0
//        var smallCellSideLength:CGFloat = (largeCellSideLength - itemSpacing)/2.0
//        var largeCellSize: CGSize = CGSizeMake(largeCellSideLength, largeCellSideLength)
//        var smallCellSize: CGSize = CGSizeMake(smallCellSideLength, smallCellSideLength)
//        
//        if self.delegate!.respondsToSelector("collectionView:sizeForLargeItemsInSection:") {
//            if !CGSizeEqualToSize(self.delegate!.collectionView!(self.collectionView!, sizeForLargeItemsInSection: 0), CGSizeZero) {
//        largeCellSize = self.delegate!.collectionView!(self.collectionView!, sizeForLargeItemsInSection: 0)
//        smallCellSize = CGSizeMake(collectionViewSize.width - largeCellSize.width - itemSpacing - insets.left - insets.right, (largeCellSize.height / 2.0) - (itemSpacing / 2.0))
//            }
//        }
//       lastsmallcellHeight = smallCellSize.height
//        var largecellHeight:CGFloat = largeCellSize.height
//        var lineHeight:CGFloat = CGFloat(numberoflines)*(largecellHeight+lineSpacing)-lineSpacing
//        content_height += lineHeight
//        
//        var numberOfItemsInLastSection:Int = (self.collectionView?.numberOfItemsInSection(0))!
//        if ((numberOfItemsInLastSection-1)%3 == 0 && (numberOfItemsInLastSection-1)%6 != 0 ) {
//          content_height -= lastsmallcellHeight + itemSpacing
//        }
//       return content_height
//    }
//    
//    public override func collectionViewContentSize() -> CGSize {
//        var contentSize:CGSize = CGSizeMake((collectionViewSize?.width)!, 0)
//       var numberoflines:Int = (self.collectionView?.numberOfItemsInSection(0))!/3 + 1
//        var lineHeight:CGFloat = CGFloat(numberOfLines!) * (largeCellSizeArr[0].CGSizeValue().height + lineSpacing!) - lineSpacing!
//       contentSize.height += lineHeight
//    contentSize.height += insets!.top + insets!.bottom
//        var numberOfItemsInLastSection:Int = (self.collectionView?.numberOfItemsInSection(0))!
//        if ((numberOfItemsInLastSection-1)%3 == 0 && (numberOfItemsInLastSection-1)%6 != 0 ) {
//            contentSize.height -= smallCellSizeArr[0].CGSizeValue().height + itemSpacing!
//        }
//     return contentSize
//    }
//    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        self.oldRect = rect
//        var attributesArr=[UICollectionViewLayoutAttributes]()
//         var numberOfCellsInSection: Int = self.collectionView!.numberOfItemsInSection(0)
//        for var j = 0; j < numberOfCellsInSection; j++ {
//          var indexPath: NSIndexPath = NSIndexPath(forItem: j, inSection: 0)
//            var attributes: UICollectionViewLayoutAttributes = self.layoutAttributesForItemAtIndexPath(indexPath)!
//            if CGRectIntersectsRect(rect, attributes.frame) {
//                attributesArr.append(attributes)
//            }
//       }
//       arr = attributesArr
//       return attributesArr
//    }
//    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
//   var attribute: UICollectionViewLayoutAttributes =  layoutAttributesForItemAtIndexPath(indexPath)!
//    var largeCellSideLength: CGFloat = (2.0 * (collectionViewSize!.width - insets!.left - insets!.right) - itemSpacing!) / 3.0
//    var smallCellSideLength: CGFloat = (largeCellSideLength - itemSpacing!) / 2.0
//    self.largeCellSize = CGSizeMake(largeCellSideLength, largeCellSideLength)
//    self.smallCellSize = CGSizeMake(smallCellSideLength, smallCellSideLength)
//    if self.delegate!.respondsToSelector("collectionView:sizeForLargeItemsInSection:") {
//    if !CGSizeEqualToSize(self.delegate!.collectionView!(self.collectionView!, sizeForLargeItemsInSection: indexPath.section), CGSizeZero) {
//    
//    self.largeCellSize = self.delegate!.collectionView!(self.collectionView!, sizeForLargeItemsInSection: indexPath.section)
//    
//    self.smallCellSize = CGSizeMake(collectionViewSize!.width - largeCellSize!.width - itemSpacing! - insets!.left - insets!.right, (largeCellSize!.height / 2.0) - (itemSpacing! / 2.0))
//            }
//        }
//        if (largeCellSizeArr == 0) {
//            largeCellSizeArr = arr
//        }
//        if (smallCellSizeArr==0 ){
//            smallCellSizeArr = arr
//        }
//        // The output below is limited by 1 KB.
//        // Please Sign Up (Free!) to remove this limitation.
//        
////        for var i = 0; i <= indexPath.section - 1; i++ {
////            var cellsCount: Int = self.collectionView.numberOfItemsInSection(i)
////            var largeCellHeight: CGFloat = largeCellSizeArray[i].CGSizeValue().height
////            var smallCellHeight: CGFloat = smallCellSizeArray[i].CGSizeValue().height
////            var lines: Int = ceil((cellsCount as! CGFloat) / 3.0)
////            sectionHeight += lines * (lineSpacing + largeCellHeight) + sectionSpacing
////            //        if ((cellsCount - 1) % 3 == 0 && (cellsCount - 1) % 6 != 0) {
////            //            sectionHeight -= smallCellHeight + _itemSpacing;
////            //        }
////        }
////        //    if (sectionHeight > 0) {
////        //        sectionHeight -= _lineSpacing;
////        //    }
////        var line: Int = indexPath.item / 3
////        var lineSpaceForIndexPath: CGFloat = lineSpacing * line
////        var lineOriginY: CGFloat = largeCellSize.height * line + sectionHeight + lineSpaceForIndexPath + insets.top
////        var rightSideLargeCellOriginX: CGFloat = collectionViewSize.width - largeCellSize.width - insets.right
////        if indexPath.item % 6 == 0 {
////            attribute.frame = CGRectMake(insets.left, lineOriginY, largeCellSize.width, largeCellSize.height)
////        }
////        else if (indexPath.item + 1) % 6 == 0 {
////            attribute.frame = CGRectMake(insets.left + (smallCellSize.width + itemSpacing) * 2, lineOriginY, smallCellSize.width, smallCellSize.height)
////        }
////        else if line % 2 == 0 {
////            if indexPath.item % 2 != 0 {
////                attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY, smallCellSize.width, smallCellSize.height)
////            }
////            else {
////                attribute.frame = CGRectMake(rightSideSmallCellOriginX, lineOriginY + smallCellSize.height + itemSpacing, smallCellSize.width, smallCellSize.height)
////            }
////        }
////        else {
////            if indexPath.item % 2 != 0 {
////                attribute.frame = CGRectMake(insets.left, lineOriginY, smallCellSize.width, smallCellSize.height)
////            }
////            else {
////                attribute.frame = CGRectMake(insets.left + smallCellSize.width + itemSpacing, lineOriginY, smallCellSize.width, smallCellSize.height)
////
//////self.smallCellSizeArr[indexPath.row] = CGSizeMake(smallCellSize!.width, smallCellSize!.height)
////    return attribute
////    }
////    
//}
