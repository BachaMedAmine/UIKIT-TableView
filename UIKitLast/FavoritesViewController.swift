//
//  FavoritesViewController.swift
//  UIKitLast
//
//  Created by Becha Med Amine on 24/9/2024.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var
    var favorites = [String]()
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favCell = tableView.dequeueReusableCell(withIdentifier: "favCell")
        let contentView = favCell?.contentView
        
        let label = contentView?.viewWithTag(1) as! UILabel
        let imageView = contentView?.viewWithTag(2) as! UIImageView
        
        label.text = favorites[indexPath.row]
        imageView.image = UIImage(named: favorites[indexPath.row])
        

        return favCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = favorites[indexPath.row]
        performSegue(withIdentifier: "mSegue2", sender: movie)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            deleteElement(tableView: tableView, index: indexPath.row)
            print("CELL DELETING ...")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let param = sender as! String
        if segue.identifier == "mSegue2" {
            
            let destination = segue.destination as! DetailsViewController
            destination.clothesName = param
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    func fetchData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Clothes")
        
        do {
            
            let data = try managedContext.fetch(request)
            for item in data {
                
                favorites.append(item.value(forKey: "clothesName") as! String)
                
            }
            
        } catch  {
            
            print("Fetching error !")
        }
        
    }
    

    func getByCreateria(clothesName: String) -> NSManagedObject{
        
        var ClothesExist:NSManagedObject?
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let predicate = NSPredicate(format: "clothesName = %@", clothesName)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                ClothesExist = (result[0] as! NSManagedObject)
                print("Clothes exists !")
                
            }
            
        } catch {
            
            print("Fetching by criteria error !")
        }
        
        
        return ClothesExist!
    }
    
    
    func deleteElement(tableView: UITableView, index: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let object = getByCreateria(clothesName: favorites[index])
        managedContext.delete(object)
        favorites.remove(at: index)
        
        tableView.reloadData()
                
    }

}

