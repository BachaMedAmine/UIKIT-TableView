//
//  DetailsViewController.swift
//  UIKitLast
//
//  Created by Becha Med Amine on 24/9/2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    var clothesName :String?

    @IBOutlet weak var clothesImageView: UIImageView!
    
    @IBOutlet weak var clothesNameLabel: UILabel!
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //OnStart
        clothesImageView.image = UIImage(named: clothesName!)
        clothesNameLabel.text = clothesName!

}
    

    @IBAction func saveFavoritesAction(_ sender: Any) {
        

        
        if getByCreateria(clothesName: clothesName!) {
            
            let alert = UIAlertController(title: "BoxOffice", message: "Movie already exists.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it!", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
            
        }else {
            
            save()
            let alert = UIAlertController(title: "BoxOffice", message: "Clothes saved successfully. ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
                
    }
    
    
    func save() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(clothesName!, forKey: "clothesName")
        
        do {
            
            try managedContext.save()
            print("Movie saved successfully !")
            
        } catch {
            
            print("Movie insert error !")
        }
    }
    
    func getByCreateria(clothesName: String) -> Bool{
        
        var clothesExist = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Clothes")
        let predicate = NSPredicate(format: "clothesName = %@", clothesName)
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                clothesExist = true
                print("Clothes exists !")
                
            }
            
        } catch {
            
            print("Fetching by criteria error !")
        }
        
        
        return clothesExist
    }

}
