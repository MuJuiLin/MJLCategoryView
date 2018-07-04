//
//  TNCategoryView.swift
//  isuntvmall
//
//  Created by Mujui Lin on 2018/3/13.
//  Copyright © 2018年 Tidenet. All rights reserved.
//

import UIKit

protocol MJLCategoryViewDelegate {
    func showCurrentCategoryWith(_ index: Int)
}

class MJLCategoryView: UIView {

    private var categoryScrollView = UIScrollView()
    private var categoryHintBar = UIView()
    private var currentSelectedButton: UIButton?
    private var categoryButtons = [UIButton]()
    
    // Parameters
    var delegate: MJLCategoryViewDelegate?
    var categoryTitles = [String]()
    var categoryStyle = MJLCategoryStyle()
    var defaultSelectedButtonIndex = 0
    var currentSelectedButtonIndex = 0
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.setTNCategoryViewWith(categoryTitles, widthType: categoryStyle.widthType)
    }
    
    func setTNCategoryViewWith(_ titles: [String], widthType: MJLCategoryViewWidthType) {
        
        categoryScrollView.frame = self.frame
        categoryScrollView.backgroundColor = UIColor.white
        categoryScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(categoryScrollView)
        
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        let titleMargin: CGFloat = 16
        var currentPositionX: CGFloat = 0
        
        for (i, title) in titles.enumerated() {
            
            let button = UIButton(type: .custom)
            
            let newString = title as NSString
            let stringBoundingBox = newString.size(withAttributes: [NSAttributedStringKey.font: categoryStyle.titleFont])
            
            switch widthType {
            case .contentWidth:
                let newButtonWidth = stringBoundingBox.width > categoryStyle.categoryMinimumWidth ? stringBoundingBox.width : categoryStyle.categoryMinimumWidth
                button.frame = CGRect(origin: CGPoint(x: currentPositionX, y: 0), size: CGSize(width: newButtonWidth + titleMargin, height: self.frame.size.height))
                button.setTitle(title, for: .normal)
            case .deviceWidth:
                button.frame = CGRect(origin: CGPoint(x: currentPositionX, y: 0), size: CGSize(width: self.frame.size.width / CGFloat(titles.count), height: self.frame.size.height))
                button.titleLabel?.numberOfLines = 0
                button.setTitle(title, for: .normal)
            }
            
            button.setTitleColor(categoryStyle.titleColor, for: .normal)
            button.setTitleColor(categoryStyle.selectedTitleColor, for: .selected)
            button.titleLabel?.font = categoryStyle.titleFont
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            button.titleLabel?.numberOfLines = categoryStyle.titleNumberOfLine
            button.backgroundColor = categoryStyle.backgroundColor
            button.tag = i
            
            button.addTarget(self, action: #selector(switchCategory(_:)), for: .touchUpInside)
            
            currentPositionX += button.frame.width
            
            categoryButtons.append(button)
            categoryScrollView.addSubview(button)
            
            if i == defaultSelectedButtonIndex {
                categoryHintBar.frame = CGRect(x: button.frame.minX, y: button.frame.height - 2, width: button.frame.width, height: 2)
                categoryHintBar.backgroundColor = categoryStyle.HintBarColor
                
                currentSelectedButton =  button
                currentSelectedButton?.isSelected = true
                currentSelectedButton?.titleLabel?.font = categoryStyle.selectedTitleFont
            }
        }
        
        categoryScrollView.addSubview(categoryHintBar)
        categoryScrollView.contentSize = CGSize(width: currentPositionX, height: self.frame.size.height)
        
        if currentSelectedButton != nil {
            switchCategory(currentSelectedButton!)
        }
    }
    
    private func moveCategoryHintBarWith(_ button: UIButton) {
        currentSelectedButtonIndex = button.tag
        currentSelectedButton?.isSelected = false
        currentSelectedButton?.titleLabel?.font = categoryStyle.titleFont
        currentSelectedButton = button
        currentSelectedButton?.isSelected = true
        currentSelectedButton?.titleLabel?.font = categoryStyle.selectedTitleFont
        
        UIView.animate(withDuration: categoryStyle.moveDuration) {
            self.categoryHintBar.frame = CGRect(x: button.frame.origin.x, y: self.categoryHintBar.frame.origin.y, width: button.frame.width, height: self.categoryHintBar.frame.height)
        }
        
        let bottomOffset = CGPoint(x: categoryScrollView.contentSize.width - categoryScrollView.bounds.width, y: 0)
        let towardOffset = CGPoint(x: button.frame.width * CGFloat(button.tag), y: 0)
        
        if towardOffset.x > bottomOffset.x {
            categoryScrollView.setContentOffset(bottomOffset, animated: true)
        }
        else {
            categoryScrollView.setContentOffset(towardOffset, animated: true)
        }
    }
    
    @objc func switchCategory(_ sender: UIButton) {
        moveCategoryHintBarWith(sender)
        delegate?.showCurrentCategoryWith(sender.tag)
    }
    
    func scrollToIndex(_ index: Int) {
        moveCategoryHintBarWith(categoryButtons[index])
    }
    
}
