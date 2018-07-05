//
//  MJLCategoryView.swift
//  MJLCategoryView
//
//  Created by Mujui Lin on 04/07/2018.
//

import UIKit

public protocol MJLCategoryViewDelegate: NSObjectProtocol {
    func showCurrentCategoryWith(_ index: Int)
}

public class MJLCategoryView: UIView {
    
    private var categoryScrollView = UIScrollView()
    private var categoryHintBar = UIView()
    private var currentSelectedButton: UIButton?
    private var categoryButtons = [UIButton]()
    
    // Parameters
    public weak var delegate: MJLCategoryViewDelegate?
    public var categoryTitles = [String]()
    public var categoryStyle = MJLCategoryStyle()
    public var defaultSelectedButtonIndex = 0
    public var currentSelectedButtonIndex = 0
    
    override public func draw(_ rect: CGRect) {
        setMJLCategoryView()
    }
    
    public func redraw() {
        for view in categoryScrollView.subviews {
            view.removeFromSuperview()
        }
        categoryButtons.removeAll()
        setMJLCategoryView()
    }
    
    public func selectCategoryAt(index: Int) {
        guard index < categoryTitles.count, index >= 0 else {return}
        moveCategoryHintBarWith(categoryButtons[index])
    }
    
    // MARK: - IBAction
    @objc private func switchCategory(_ sender: UIButton) {
        moveCategoryHintBarWith(sender)
        delegate?.showCurrentCategoryWith(sender.tag)
    }
}

// MARK: - Animation
extension MJLCategoryView {
    private func moveCategoryHintBarWith(_ button: UIButton) {
        
        changeCurrentSelectedButtonWith(button: button)
        
        UIView.animate(withDuration: categoryStyle.hintBarMoveDuration) {
            self.categoryHintBar.frame = CGRect(x: button.frame.origin.x, y: self.categoryHintBar.frame.origin.y, width: button.frame.width, height: self.categoryHintBar.frame.height)
        }
        
        if categoryStyle.widthType == .contentWidth {
            
            var targetOffset: CGPoint = CGPoint.zero
            
            if button.frame.maxX > categoryScrollView.contentSize.width * 0.75 {
                targetOffset = CGPoint(x: categoryScrollView.contentSize.width - categoryScrollView.frame.width, y: 0)
            }
            else if button.frame.minX < categoryScrollView.contentSize.width * 0.25 {
                targetOffset = CGPoint.zero
            }
            else {
                targetOffset = CGPoint(x: categoryScrollView.contentSize.width * 0.5 - categoryScrollView.frame.width * 0.5, y: 0)
            }
            categoryScrollView.setContentOffset(targetOffset, animated: categoryStyle.scrollViewAnimationEnable)
        }
    }
    
    private func changeCurrentSelectedButtonWith(button: UIButton) {
        currentSelectedButtonIndex = button.tag
        currentSelectedButton?.isSelected = false
        currentSelectedButton?.titleLabel?.font = categoryStyle.titleFont
        currentSelectedButton = button
        currentSelectedButton?.isSelected = true
        currentSelectedButton?.titleLabel?.font = categoryStyle.selectedTitleFont
    }
}

// MARK: - Private Setting
extension MJLCategoryView {
    
    private func setMJLCategoryView() {
        
        guard categoryTitles.count > 0 else {return}
        
        setCategoryScrollView()
        
        var currentPositionX: CGFloat = 0
        for (i, title) in categoryTitles.enumerated() {
            
            let button = setCategoryButtonWith(title: title, index: i, currentPositionX: &currentPositionX)
            currentPositionX += button.frame.width
            categoryButtons.append(button)
            categoryScrollView.addSubview(button)
        }
        categoryScrollView.contentSize = CGSize(width: currentPositionX, height: self.frame.size.height)
        setCategoryHintBar()
    }
    
    private func setCategoryHintBar() {
        defaultSelectedButtonIndex = defaultSelectedButtonIndex < categoryTitles.count ? defaultSelectedButtonIndex : 0
        
        let button = categoryButtons[defaultSelectedButtonIndex]
        
        categoryHintBar.frame = CGRect(x: button.frame.minX, y: button.frame.height - 2, width: button.frame.width, height: 2)
        categoryHintBar.backgroundColor = categoryStyle.HintBarColor
        
        moveCategoryHintBarWith(button)
        categoryScrollView.addSubview(categoryHintBar)
    }
    
    private func setCategoryScrollView() {
        categoryScrollView.frame = self.frame
        categoryScrollView.backgroundColor = categoryStyle.backgroundColor
        categoryScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(categoryScrollView)
        
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: categoryScrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    private func setCategoryButtonWith(title: String, index: Int, currentPositionX: inout CGFloat) -> UIButton {
        let titleMargin: CGFloat = 24
        let button = UIButton(type: .custom)
        let titleString = title as NSString
        let stringBoundingBox = titleString.size(withAttributes: [NSAttributedStringKey.font: categoryStyle.titleFont])
        
        switch categoryStyle.widthType {
        case .contentWidth:
            let newButtonWidth = stringBoundingBox.width > categoryStyle.categoryMinimumWidth ? stringBoundingBox.width : categoryStyle.categoryMinimumWidth
            button.frame = CGRect(origin: CGPoint(x: currentPositionX, y: 0), size: CGSize(width: newButtonWidth + titleMargin, height: self.frame.size.height))
            button.titleLabel?.numberOfLines = categoryStyle.titleNumberOfLine
        case .deviceWidth:
            button.frame = CGRect(origin: CGPoint(x: currentPositionX, y: 0), size: CGSize(width: self.frame.size.width / CGFloat(categoryTitles.count), height: self.frame.size.height))
            button.titleLabel?.numberOfLines = 0
        }
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(categoryStyle.titleColor, for: .normal)
        button.setTitleColor(categoryStyle.selectedTitleColor, for: .selected)
        button.titleLabel?.font = categoryStyle.titleFont
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        button.backgroundColor = categoryStyle.backgroundColor
        button.tag = index
        
        button.addTarget(self, action: #selector(switchCategory(_:)), for: .touchUpInside)
        
        return button
    }
}
