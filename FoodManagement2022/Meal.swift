//
//  Meal.swift
//  FoodManagement2022
//
//  Created by CNTT on 4/28/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//
import UIKit
import Foundation
class Meal {
    //MARK : Properties
    var mealName : String
    var mealImage : UIImage?
    var ratingValue : Int
    
    //MARK : Constrcutors
    init?(mealName: String,mealImage: UIImage?,ratingValue: Int) {
        //Test conditions of creating real object
        if mealName.isEmpty{
            return nil
        }
        if ratingValue < 0 || ratingValue > 5 {
            return nil
        }
        
        //Crete the meal object
        self.mealName = mealName
        self.mealImage = mealImage
        self.ratingValue = ratingValue
    }
    
}
