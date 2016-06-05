//
//  MoviePickerCollectionViewLayout.swift
//  CinemaCity
//
//  Created by Naim Ashhab on 17.01.16.
//  Copyright © 2016 Naim Ashhab. All rights reserved.
//

import UIKit

class MoviePickerCollectionViewLayout: UICollectionViewLayout {
  
  // MARK: Consts
  
  let cellHeight      : CGFloat = 200
  let numberOfColumns = 2
  let cellPadding     : CGFloat = 5
  let cellMisaligned  : CGFloat = 60
  
  
  // MARK: Private
  
  private var cache = [UICollectionViewLayoutAttributes]()
  private var contentHeight: CGFloat = 0
  private var width: CGFloat {
    get {
      let insets = collectionView!.contentInset
      return collectionView!.bounds.width - (insets.left + insets.right)
    }
  }
  
  
  // MARK: Layout
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: width, height: contentHeight)
  }
  
  override func prepareLayout() {
    
    if cache.isEmpty {
      
      for item in 0..<collectionView!.numberOfItemsInSection(0) {
        
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        
        let insetFrame = countFrameForItemAtIndexPath(indexPath)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = insetFrame
        
        cache.append(attributes)
        contentHeight = max(contentHeight, insetFrame.maxY)
      }
    }
    
  }
  
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      if CGRectIntersectsRect(attributes.frame, rect) {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    
    let insetFrame = countFrameForItemAtIndexPath(indexPath)
    
    let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
    attributes.frame = insetFrame
    
    contentHeight = max(contentHeight, insetFrame.maxY)
    
    return attributes
  }
  
  
  // MARK: Animations
  
//  override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
//    
//    let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: itemIndexPath)
//    
//    let frame = countFrameForItemAtIndexPath(itemIndexPath)
//    
//    attributes.frame = CGRectOffset(frame, 0, UIScreen.mainScreen().bounds.height)
//    attributes.alpha = 0
//    
//    return attributes
//  }
  
  
  // MARK: Private
  
  private func countFrameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect {
    let columnWidth = width / CGFloat(numberOfColumns)
    let cellSize = CGSize(width: columnWidth, height: cellHeight)
    
    let cellOriginX = indexPath.row % 2 == 0 ? 0 : columnWidth
    let cellOriginY = CGFloat(indexPath.row / 2) * cellHeight + (indexPath.row % 2 == 0 ? 0 : cellMisaligned)
    let cellOrigin = CGPoint(x: cellOriginX, y: cellOriginY)
    
    let frame = CGRect(origin: cellOrigin, size: cellSize)
    return CGRectInset(frame, cellPadding, cellPadding)
  }
}
