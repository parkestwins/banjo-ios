//
//  GenreCellLayout.swift
//
//  Created by Diep Nguyen Hoang on 7/30/15.
//  Copyright © 2015 CodenTrick. All rights reserved.
//  github.com/luceefer/TagFlowExample
//
//  Modified by Jarrod Parkes on 12/23/16.
//

import UIKit

// MARK: - GenreCellLayout: UICollectionViewFlowLayout

public class GenreCellLayout: UICollectionViewFlowLayout {
    
    // MARK: UICollectionViewLayout
    
    // FIXME: Long genre tags (ex. Al Shogi 3) are not always left-aligned.
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        
        // use a value to keep track of left margin
        var leftMargin: CGFloat = 0.0
        
        for attributes in attributesForElementsInRect! {
            let refAttributes = attributes
            // assign value if next row
            if (refAttributes.frame.origin.x == sectionInset.left) {
                leftMargin = sectionInset.left
            } else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            leftMargin += refAttributes.frame.size.width + 8
            newAttributesForElementsInRect.append(refAttributes)
        }
        
        return newAttributesForElementsInRect
    }
}
