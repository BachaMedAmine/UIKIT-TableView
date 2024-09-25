//
//  ViewController.swift
//  UIKitLast
//
//  Created by Becha Med Amine on 24/9/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = ["Pullover","Street clothes","Shirt","Street clothes","Longsleeve Violeta"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        guard let contentView = cell?.contentView else {
            return UITableViewCell() // or handle error appropriately
        }
        
        if let label = contentView.viewWithTag(1) as? UILabel,
           let imageView = contentView.viewWithTag(2) as? UIImageView {
            label.text = data[indexPath.row]
            imageView.image = UIImage(named: data[indexPath.row]) ?? UIImage(named: "defaultImage")        }

        return cell ?? UITableViewCell()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "mSegue" {
            let param = sender as! String
            let destination = segue.destination as! DetailsViewController
            destination.clothesName = param
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let clothes = data[indexPath.row]
        performSegue(withIdentifier: "mSegue", sender: clothes)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }


}


