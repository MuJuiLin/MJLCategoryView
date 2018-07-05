//
//  MJLCatregoryStyle.swift
//  MJLCategoryView
//
//  Created by Mujui Lin on 04/07/2018.
//

import Foundation
import UIKit

public enum MJLCategoryViewWidthType {
    case deviceWidth
    case contentWidth
}

public struct MJLCategoryStyle {
    
    public var backgroundColor: UIColor = UIColor.black
    
    public var titleColor: UIColor = UIColor.white
    
    public var selectedTitleColor: UIColor = UIColor.orange
    
    public var HintBarColor: UIColor = UIColor.orange
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    
    public var selectedTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
    
    public var titleNumberOfLine: Int = 0
    
    public var categoryMinimumWidth: CGFloat = 0 /* Only works when the type is contentWidth */
    
    public var hintBarMoveDuration: TimeInterval = 0.2
    
    public var scrollViewAnimationEnable: Bool = true
    
    public var widthType: MJLCategoryViewWidthType = MJLCategoryViewWidthType.deviceWidth
    
    public init() {
        
    }
}
