# MJLCategoryView
The implementation of android tab bar unit in Swift. 

## Installation
```sh
pod 'MJLCategoryView'
```
## Usage

### Example
You can use storyboad to create this view easily.
```swift
@IBOutlet weak var categoryView: MJLCategoryView! {
    didSet {
        var style = MJLCategoryStyle()
        style.titleNumberOfLine = 2
        style.widthType = .contentWidth
        
        // If you don't want to change any settings, you can ignore MJLCategoryStyle.
        categoryView.categoryStyle = style 
        
        categoryView.categoryTitles = titles
        categoryView.defaultSelectedButtonIndex = 0
        categoryView.delegate = self
    }
}
```

## Screencasts

![loading](https://github.com/MuJuiLin/MJLCategoryView/blob/master/Screencasts/MJLCategoryView.gif)
