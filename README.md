# M4KTableIndexView
Customize the index view of a UITableView. This allows users to scroll with more precision than the standard controls Apple offers.


Using Apple's standard control | Using M4KTableIndexView
:-------------------------:|:-------------------------:
![](https://s3.amazonaws.com/stephenlindauer/blogs/table-index-view/index-old.gif) | ![](https://s3.amazonaws.com/stephenlindauer/blogs/table-index-view/new+index.gif)

## Demo

## Installation

1. Copy the files from M4KTableIndexView/ into Xcode.
2. In your View Controller, add a property for the View:

    @IBOutlet weak var indexView: M4KTableIndexView!

3. Setup the indexView:

    indexView.tableView = self.tableView
    indexView.indexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    indexView.setup()
    
4. Profit

