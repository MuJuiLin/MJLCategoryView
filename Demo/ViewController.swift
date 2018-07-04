//
//  ViewController.swift
//  MJLCategoryView
//
//  Created by Mujui Lin on 04/07/2018.
//  Copyright © 2018 Mujui Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var categoryView: MJLCategoryView! {
        didSet {
            var style = MJLCategoryStyle()
            style.titleNumberOfLine = 2
            style.widthType = .deviceWidth
            
            categoryView.categoryStyle = style
            categoryView.categoryTitles = ["First", "Second", "Third"]
            categoryView.defaultSelectedButtonIndex = 0
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
        print(index)
    }
}

