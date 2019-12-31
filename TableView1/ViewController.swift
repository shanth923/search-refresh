//
//  ViewController.swift
//  TableView1
//
//  Created by R Shantha Kumar on 12/23/19.
//  Copyright © 2019 R Shantha Kumar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    
    
    
       var name1 = [String]()
       var age = [String]()
       var email = [String]()
       var images = [UIImage]()

    var tableView:UITableView!
    
    var tollywood:[String] = []
    var bollywood:[String] = []
    var hollywood:[String] = []
    var desinfgation2 = [String]()
    var searchVC:UISearchController!
    
    var filredData = [String]()
    
    var allItems:[String] = []
    var imageVie:UIImageView!
    
    var text4:String?
    
 
override func viewDidLoad() {
    
                 super.viewDidLoad()
       
                 tableViewMerhod()
    
        searchVC  = UISearchController(searchResultsController: nil)
          searchVC.searchResultsUpdater = self
    
           tableView.tableHeaderView = searchVC.searchBar
        
        // Do any additional setup after loading the view.
    }

func tableViewMerhod(){
   
        
    tableView = UITableView(frame: view.frame, style: UITableView.Style.plain)
        
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
    
          view.addSubview(tableView)
    
           tableView.delegate = self
           tableView.dataSource = self
    
    
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        
        print("user i s searching  for \(searchController.searchBar.text!)")
        
        let predicate = NSPredicate(format: "self contains[c]%@", searchController.searchBar.text!)
        
        filredData = (allItems as NSArray).filtered(using: predicate) as! [String]
        
        
        tableView.reloadData()
        
        print("@@@@@@@@@@@@@@@@@",filredData)
    }
    
    
 
    
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,       forRowAt indexPath: IndexPath) {
            if editingStyle ==
                
                .delete {
           print("Deleted")

           self.allItems.remove(at: indexPath.row)

           self.tableView.deleteRows(at: [indexPath], with: .automatic)


           
         DBManager.shared.deleteData(entityName: "Contacts", deleteBasedOnColumn:"name" , value:name1[indexPath.row])
    }
        tableView.reloadData()
        }
    
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if(searchVC.isActive == true){
       
        
    return filredData.count
        
       
    }else{
        
        
        return allItems.count
    }
    
    
         }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    
    let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "abc")
    
    
    
    if(searchVC.isActive == true)
    {
        
        cell.textLabel?.text = filredData[indexPath.row]
        
        
        
    }else{
        
        cell.textLabel?.text = allItems[indexPath.row]
        
    }
    
    
       
    
    

      cell.imageView!.heightAnchor.constraint(equalToConstant: 100).isActive = true
     cell.imageView!.widthAnchor.constraint(equalToConstant: 100).isActive = true
//


    
     
    cell.imageView?.image = images[indexPath.row]
    
   

    cell.imageView?.layer.cornerRadius = cell.imageView!.frame.size.width/2
    cell.imageView?.clipsToBounds = true

        cell.textLabel!.numberOfLines = 0
    cell.textLabel?.textAlignment = .center

        DBManager.shared.indexPath = indexPath.row

        return cell

        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
 
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
         
          let target = storyboard?.instantiateViewController(identifier: "abcde") as! UpdateViewController
          
    
    
    DBManager.shared.names.append(name1[0])
    DBManager.shared.mobileNumber.append(age[0])
    DBManager.shared.email.append(email[0])
    
    
    
    
    
    
    
    
    navigationController?.pushViewController(target, animated: true)
    
//    DBManager.shared.items3.append(items[indexPath.row])
   
        
        
        
    }
    
    
@IBAction func addContact(_ sender: Any) {
        
        
   
        
        let target = storyboard?.instantiateViewController(identifier: "abcd") as! TableViewController
        
        navigationController?.pushViewController(target, animated: true)
        
        
        
    }
    
    
    

    override func viewWillAppear(_ animated: Bool) {
       
 
        
        
        
        let data = DBManager.shared.fetchDAta(entityName: "Contacts")
     
//  fetching
                desinfgation2 = [String]()
                name1 = [String]()
                allItems = [String]()
                images = [UIImage]()
      
                var text:String!
       
                       
                
                for (i,x) in data.enumerated()
                {
                    
                  let path =   x.value(forKey: "designation") as? String ?? "empty"
                    
                    
                    desinfgation2.append(path)
                    
                    let defaultImage = UIImage(named: "defaultImage")
                    
                    
                   
                    let imageData = (defaultImage!.pngData()! as NSData)
                    

                    let imaged = x.value(forKey: "imageData") as? NSData ??  imageData
                    
                    let uiimage = UIImage(data:(imaged as? Data)!)


                    if let c = uiimage
                    {
                    
                         images.append(c)
                       
                    }
              
                    
                    let name = x.value(forKey: "name") as? String ?? "empty"
                    print(name)
                    name1.append(name)
                    
                   
                    text = "Actor Name:\(name)"
                    
                    let aged = x.value(forKey: "age") as? String ?? "empty"
                    //print(aged)
                    age.append(aged)
                    
                    
                    
                    text += "\n" + "Age:\(aged)"
                    text4 = aged
                    
                    let industry = x.value(forKey: "industry") as? String ?? "empty"
                    //print(emails)
                     text += "\n" + "Film Industry:\(industry)"
                    email.append(industry)
                   
                    
                    allItems.append(text)
            
        }
                   tableView.reloadData()
        }
    
    
     
    
    
    

    
    
    
    
    
    
    
    
    

}

