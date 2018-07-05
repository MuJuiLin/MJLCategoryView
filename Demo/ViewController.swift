//
//  ViewController.swift
//  MJLCategoryView
//
//  Created by Mujui Lin on 04/07/2018.
//  Copyright © 2018 Mujui Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentIndex = 0
    var titles = ["First", "Second", "Third", "First", "Second", "Third", "First", "Second", "Third"]
    
    @IBAction func goLeft(_ sender: Any) {
        currentIndex-=1
        if currentIndex < 0 {
            currentIndex+=1
        }
        categoryView.selectCategoryAt(index: currentIndex)
    }
    
    @IBAction func goRight(_ sender: Any) {
        currentIndex+=1
        if currentIndex > titles.count {
            currentIndex-=1
        }
        categoryView.selectCategoryAt(index: currentIndex)
    }
    
    @IBOutlet weak var categoryView: MJLCategoryView! {
        didSet {
            var style = MJLCategoryStyle()
            style.titleNumberOfLine = 2
            style.widthType = .contentWidth
            
            categoryView.categoryStyle = style
            categoryView.categoryTitles = titles
            categoryView.defaultSelectedButtonIndex = currentIndex
            categoryView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: MJLCategoryViewDelegate {
    func showCurrentCategoryWith(_ index: Int) {
        currentIndex = index
    }
}

