//
//  M4KTableIndexView.swift
//  M4K
//
//  Created by Stephen Lindauer on 7/5/16.
//  Customize the index view of a UITableView
//

import UIKit

@objc protocol M4KTableIndexDelegate {
    @objc optional func indexDisplayText(for indexPath: IndexPath) -> String
}

class M4KTableIndexView: UIView {
    
    var indexes : [String]!
    var indicatorView : M4KTableIndexPreviewView?
    var delegate : M4KTableIndexDelegate?
    var tableView : UITableView!
    
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        var views = [String:UILabel]()
        var verticalLayoutString = "V:|"
        
        // This builds n labels, equally sized and spaced from top to bottom of the UITableView; n = indexes.count
        for i in 0..<indexes.count {
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            label.text = indexes[i]
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false // We manage this below with our own constraints
            
            addSubview(label)
            views["label\(i)"] = label
            
            // Build the constraint visual format so each label is touching the adjecent label
            //   and all heights will be equal
            // End result will look something like:
            //   "V:|[label0][label1(==label0)][label2(==label0)]|"
            if i == 0 {
                verticalLayoutString += "[label\(i)]"
            }
            else {
                verticalLayoutString += "[label\(i)(==label0)]"
            }
            
            // Add constraint so label takes up full width of the index view
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label\(i)]|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: [:], views: views))
        }
        // Add last constraint to bottom margin
        verticalLayoutString += "|"
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalLayoutString, options: NSLayoutFormatOptions.alignAllCenterX, metrics: [:], views: views))
        
        // Capture the touches when sliding up/down on the index view
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(indexViewWasDragged))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    func indexViewWasDragged(_ gesture: UIPanGestureRecognizer) {
        
        // Determine which index is currently selected, based off the location of the touch
        let point = gesture.location(in: self)
        // min/max are used in case the user drags past the top or bottom of the UITableView so we don't get an out of bounds exception
        let index = max(min(Int(point.y / frame.height * CGFloat(indexes.count)), indexes.count-1), 0)
        // How far between index[n] and index[n+1]
        let percentInSection = max(point.y / frame.height * CGFloat(indexes.count) - CGFloat(index), 0)
        
        scrollToIndex(index, percentInSection: percentInSection)
        
        
        if gesture.state == .ended {
            // Touch ended, remove indicator
            indicatorView?.removeFromSuperview()
            indicatorView = nil;
        }
    }
    
    func scrollToIndex(_ index: Int, percentInSection: CGFloat) {
        var section = index
        var rows = self.tableView.dataSource!.tableView(tableView, numberOfRowsInSection: section)
        var row = Int(CGFloat(rows) * percentInSection)
        let numberOfSectionsInTable = tableView.dataSource!.numberOfSections!(in: tableView)
        
        // If the section we picked has no rows, continue to the next non-empty section
        while (rows == 0 && section < numberOfSectionsInTable-1) {
            section += 1
            rows = self.tableView.dataSource!.tableView(tableView, numberOfRowsInSection: section)
            
            // We always want the first row so we scroll closest to the originally selected section
            row = 0
        }
        
        let indexPath = IndexPath(row: row, section: section)
        if (rows == 0) {
            // We've reached the last possible row, so just scroll to the bottom
            tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height - tableView.frame.height), animated: false)
        }
        else {
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
        
        if delegate != nil {
            
            if indicatorView == nil {
                indicatorView = M4KTableIndexPreviewView(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
                indicatorView!.center = CGPoint(x: superview!.frame.width/2, y: superview!.frame.height/2)
                superview?.addSubview(indicatorView!)
            }
            
            indicatorView!.letterLabel.text = delegate?.indexDisplayText?(for: indexPath)
        }
        
        
        
        
    }
    
}

