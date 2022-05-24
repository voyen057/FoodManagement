//
//  database.swift
//  FoodManagement2022
//
//  Created by VoYen on 2022-05-17.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import Foundation
import UIKit
import os.log
class DatabaseLayer{
    //MARK: database;s properties
    let db_name = "meals.sqlite"
    let db_path:String
    let database:FMDatabase?
    //MARK: table's properties
    let meal_name_table = "meals"
    let meal_id = "_id"
    let meal_name = "name"
    let meal_image = "image"
    let Rating_Value = "rating"
    //Mark constructor
    init() {
        //Get the directors which can be saved  oor database
        let  dirrectory:[String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        //set database path
        //Get database path
       
        }
    
}
