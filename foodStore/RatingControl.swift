
//
//  RatingControl.swift
//  foodStore
//
//  Created by jbian on 12/15/18.
//  Copyright © 2018 Avantica. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    var rating = 0
    var ratinButtons = [UIButton]()
    var spacing = 5
    var starts = 5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // get Images
        let filledStartImage = UIImage(named:"filledStar")
        let emptyStartImage = UIImage(named:"emptyStar")
        //let meal = UIImage (named: "meal1")
        
        for _ in 0..<starts {
            let button = UIButton()
            button.setImage(emptyStartImage, for: .normal)
            button.setImage(filledStartImage, for: .selected)
            button.setImage(filledStartImage, for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false
            // add event
            button.addTarget(self, action: #selector(ratingButtonTabEvent), for: .touchUpInside)
            ratinButtons.append(button)
            // add to view
            addSubview(button)
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @objc func ratingButtonTabEvent(button:UIButton){
        print("rating button")
        self.rating = ratinButtons.index(of: button)! + 1
        updateButtonSelectionState()
        
    }
    
    func updateButtonSelectionState(){
        for(index, button) in ratinButtons.enumerated(){
            if index < self.rating{
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            
            
        }
        print("the rating is ", rating)
    }
    override func layoutSubviews() {
        print("layout sub view")
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x:0, y:0, width:buttonSize, height: buttonSize)
        for(index, button) in ratinButtons.enumerated(){
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
            
        }
        updateButtonSelectionState()
    }
    override var intrinsicContentSize: CGSize{
        let buttonSize = Int (self.frame.size.height)
        let width = Int(buttonSize + self.spacing) * starts
        return CGSize(width: width, height: buttonSize)
    }
}




