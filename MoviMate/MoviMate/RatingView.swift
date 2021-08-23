//
//  RatingView.swift
//  MoviMate
//
//  Created by Roman Alikevich on 16.08.2021.
//

import UIKit

class RatingView: UIStackView {
    
    var starsRating = 0
    var starsEmptyPicName = "empty-star"
    var starsFilledPicName = "stars"
    
    override func draw(_ rect: CGRect) {
        
        let starButtons = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        
        for button in starButtons {
            
            if let button = button as? UIButton {
                
                button.setImage(UIImage(named: starsEmptyPicName), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                
                button.tag = starTag
                starTag = starTag + 1
            }
        }
        
       setStarsRating(rating:starsRating)
    }
    
    func setStarsRating(rating:Int){
        
        self.starsRating = rating
        
        let stackSubViews = self.subviews.filter{$0 is UIButton}
        
        for subView in stackSubViews {
            
            if let button = subView as? UIButton{
                
                if button.tag > starsRating {
                    
                    button.setImage(UIImage(named: starsEmptyPicName), for: .normal)
                }else{
                    
                    button.setImage(UIImage(named: starsFilledPicName), for: .normal)
                }
            }
        }
    }
    @objc func pressed(sender: UIButton) {
        
        setStarsRating(rating: sender.tag)
    }
}

