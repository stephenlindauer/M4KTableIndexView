//
//  M4KTableIndexPreviewView.swift
//  M4K
//
//  Created by Stephen Lindauer on 7/19/16.
//  Simple UI element that displays a black box with a large label
//  Used to display where the user is at while scrolling via the index
//

import UIKit

class M4KTableIndexPreviewView: UIView {

    var letterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        layer.cornerRadius = 25.0
        clipsToBounds = true
        
        letterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        letterLabel.textColor = UIColor.white
        letterLabel.font = UIFont.systemFont(ofSize: 80)
        letterLabel.textAlignment = .center
        
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        addSubview(blurEffectView)
        
        addSubview(letterLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}

