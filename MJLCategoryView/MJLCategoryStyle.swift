//
//  LACatregoryStyle.swift
//  LACategoryView
//
//  Created by Mujui Lin on 04/07/2018.
//

import Foundation
import UIKit

enum MJLCategoryViewWidthType {
    case deviceWidth
    case contentWidth
}

struct MJLCategoryStyle {
    
    var backgroundColor: UIColor = UIColor.black
    
    var titleColor: UIColor = UIColor.white
    
    var selectedTitleColor: UIColor = UIColor.orange
    
    var HintBarColor: UIColor = UIColor.orange
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    
    var selectedTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 16.0)
    
    var titleNumberOfLine: Int = 0
    
    var categoryMinimumWidth: CGFloat = 0 /* Only works when the type is contentWidth */
    
    var hintBarMoveDuration: TimeInterval = 0.2
    
    var scrollViewAnimationEnable: Bool = true
    
    var widthType: MJLCategoryViewWidthType = MJLCategoryViewWidthType.deviceWidth
}
