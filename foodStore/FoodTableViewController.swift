//
//  FoodTableViewController.swift
//  foodStore
//
//  Created by jbian on 12/15/18.
//  Copyright © 2018 Avantica. All rights reserved.
//

import UIKit
import RealmSwift

class FoodTableViewController: UITableViewController {
    var meals = [Meal]()
    var realm:Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //try to connect db
        self.realm = try! Realm()
        
        let silpancho = Meal(id: "0", name: "silpanch0", photo: UIImage(named:"silpancho")!, rating: 0)
        let planchita = Meal(id: "1", name: "silpancho", photo: UIImage(named:"silpancho")!, rating: 0)
        
        meals.append(silpancho!)
        meals.append(planchita!)
        //retrieve data from..
        
        let mealsFromDB = realm?.objects(MealDBD.self)
        
        for mealDB in mealsFromDB!{
            let imageFromBinary = UIImage(data: (mealDB.photo as!NSData) as Data )
            
            let newMeal = Meal(id: mealDB.id!,
                               name: mealDB.name!,
                               photo: imageFromBinary!,
                               rating: mealDB.raiting)
                                meals.append(newMeal!)
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! FoodTableViewCell
        let cellSelected = meals[indexPath.row]
        cell.foodImage.image = cellSelected.photo
        cell.foodLabel.text = cellSelected.name
        cell.rating.rating = cellSelected.rating

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwidToMealList(send: UIStoryboardSegue){
        print("Return to Table View !!!!")
        // secure cast
        if let sourceViewController = send.source as?
            FoodDetailViewController, let meal = sourceViewController.meal{
            
            let indexPath = IndexPath(row:meals.count, section:0)
            meals.append(meal)
            saveMeal(mealToSave: meal)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func saveMeal(mealToSave: Meal){
        let newMealDB = MealDBD()
        newMealDB.id = mealToSave.id
        newMealDB.name = mealToSave.name
        //newMealDB.city = mealToSave.city
        newMealDB.raiting = mealToSave.rating
        // convert UI image to NSDATA (BINARY)
        //let data = UIImagePNGRepresentation() as NSData?
        newMealDB.photo =  UIImagePNGRepresentation(mealToSave.photo!)! as NSData
        
        print ("the uuid --> \(UIDevice.current.identifierForVendor)")
        try! self.realm?.write {
            
            print("Save !!! --Paht --> \( Realm.Configuration.defaultConfiguration.fileURL)")
            self.realm?.add(newMealDB)
        }
    }
}
