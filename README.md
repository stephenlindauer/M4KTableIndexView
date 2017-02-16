# M4KTableIndexView
Customize the index view of a UITableView. This allows users to scroll with more precision than the standard controls Apple offers.


Using Apple's standard control | Using M4KTableIndexView
:-------------------------:|:-------------------------:
![](https://s3.amazonaws.com/stephenlindauer/blogs/table-index-view/index-old.gif) | ![](https://s3.amazonaws.com/stephenlindauer/blogs/table-index-view/new+index.gif)

## Demo
Open and run the included `SampleContactList.xcodeproj`

## Installation

1. Copy the files from M4KTableIndexView/ into Xcode.
2. In your View Controller, add an IBOutlet for the View:

```swift
@IBOutlet weak var indexView: M4KTableIndexView!
```

3. Setup the indexView:

```swift
indexView.tableView = self.tableView
indexView.indexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
indexView.setup()
```

4. Add a UIView element to your Storyboard positioned next to your UITableView. Connect this to the IBOutlet created in #2.
5. (Optional) Make your View Controller be the indexView's delegate and implement the delegate method:

```swift
class ViewController, UIViewController, M4KTableIndexDelegate {

	...
	indexView.delegate = self
	...

	func indexDisplayText(for indexPath: IndexPath) -> String {
		// Return a short string to display on screen
		return ""
	}
```
