//
//  RatingControl.swift
//  FoodManagement2022
//
//  Created by CNTT on 4/14/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    @IBInspectable private var ratingValue:Int = 0 {
        didSet {
            updateRatingButtonState()
        }
    }
    private var ratingButtons = [UIButton]()
    @IBInspectable private var starCount:Int = 5 {
        didSet {
            initialization()
        }
    }
    @IBInspectable private var starSize:CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            initialization()
        }
    }
    
    private var activeRatingButtonContraints = true
    
    
    //MARK: Contructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    //MARK: Initialization od Rating Control
    private func initialization(){
        //Crear the old buttions
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        // Create rating buttons
        
        // Load the star images from assets
        let bundle = Bundle(for: type(of: self))
        let normalStar = UIImage(named: "normalStar",in: bundle,compatibleWith: self.traitCollection)
        let selectedStar = UIImage(named: "selectedStar",in: bundle,compatibleWith: self.traitCollection)
        let pressedStar = UIImage(named: "pressedStar",in: bundle,compatibleWith: self.traitCollection)

        for _ in 0..<starCount {
        let btnRating = UIButton()
        //Set up the properties  of the rating buttons
        //btnRating.backgroundColor  = UIColor.red
            
        //Set the star imge
        btnRating.setImage(normalStar, for: .normal)
        btnRating.setImage(pressedStar, for: .highlighted)
        btnRating.setImage(selectedStar, for: .selected)
        
        btnRating.widthAnchor.constraint(equalToConstant: starSize.width).isActive = activeRatingButtonContraints
        btnRating.heightAnchor.constraint(equalToConstant: starSize.height).isActive = activeRatingButtonContraints
        //event processing for the Rating buttons
        btnRating.addTarget(self, action: #selector(ratingButtonPressed(button:)), for: .touchUpInside)
        //Add created button to Stackview
        addArrangedSubview(btnRating)
        //Add the rating buttons to ratingButtons array
            ratingButtons.append(btnRating)
        }
        
        //Update buttons state
        updateRatingButtonState()
        
    }
    
    //Rating button touch in side
    @objc private func ratingButtonPressed(button: UIButton){
        if let index = ratingButtons.firstIndex(of: button){
            if index + 1 == ratingValue{
                ratingValue -= 1
            }
            else {
                ratingValue = index + 1
            }
        }
        // update state of rating buttons
        updateRatingButtonState()
        //print("Vi tri cua button trong mang la: \(index!)")
    }
    private func updateRatingButtonState(){
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < ratingValue
        }
    }
    
    //Getter and setter for rating value
    func getRatingValue() -> Int {
        return ratingValue
    }
    func setRatingValue(ratingValue:Int) {
        self.ratingValue = ratingValue
    }
}
