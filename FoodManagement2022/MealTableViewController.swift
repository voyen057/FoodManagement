//
//  MealTableViewController.swift
//  FoodManagement2022
//
//  Created by CNTT on 4/21/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    //MARK: Properties
    var meals = [Meal]()
    
    enum NavigationType {
        case newMeal
        case editMeal
    }
    
    var navigationType:NavigationType = .newMeal

    override func viewDidLoad() {
        super.viewDidLoad()
       //Create meals for testing table view
        let mealImage = UIImage(named: "default")
        if let meal = Meal(mealName: "Mon Hue", mealImage: mealImage, ratingValue: 3) {
            meals += [meal]
        }
        
        //Add the Edit bar button to the navigation bar
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "MealTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? MealTableViewCell {
            //Get meal from data source at position of indexPath
            let meal = meals[indexPath.row]
            cell.lblMealName.text = meal.mealName
            cell.imgMeal.image = meal.mealImage
            cell.ratingcontrol.setRatingValue(ratingValue: meal.ratingValue)
            return cell

        }
        else {
            fatalError("Can not create the cell!")
        }

    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the meal from data source
            meals.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueName = segue.identifier{
            switch segueName {
            case"addMeal":
                //print("Add new meal")
                navigationType = .newMeal
                
                //Mark the new meal or edit meal
                if let destinationController = segue.destination as?
                    MealDetailController {
                    //Mark the new meal or the edit meal
                    destinationController.navigationType = .newMeal
    
                }
            case"editMeal":
                //print("Edit meal")
                navigationType = .editMeal
                //Pass the selected neal to meal detail controller
            //B1: Get the deatination controller
                if let destinationController = segue.destination as?
                    MealDetailController {
                    if let selectedIndexPath = tableView.indexPathForSelectedRow {
                        //B2: Save object to meal object of destination controller
                        destinationController.meal = meals[selectedIndexPath.row]
                        //Mark the new meal or the edit meal
                        destinationController.navigationType = .editMeal
                    }
                }
            default:break
            }
        }
    }
    


    //MARK: Unwind From MealDetailController
    @IBAction func unWindFromMealDetailController(segue:UIStoryboardSegue) {
        //print("Back from meal detail!")
        // Get source controller
        if let sourceController = segue.source as? MealDetailController{
           if let meal = sourceController.meal {
            //print(meal.mealName)
            
            
            //Processing the new meal or update meal
            switch navigationType{
            case .newMeal:
                //Put the meal into datasuorce of table view
                meals += [meal]
                //Insert the new meal into tableView
                let newIndexPath = IndexPath(row: meals.count-1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .editMeal:
                //Update the selected row
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    //Update the meal to datasoure
                    meals[selectedIndexPath.row] = meal
                    //Reload the update value of meal
                    tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                }
                }
            }
        }
    }
}

