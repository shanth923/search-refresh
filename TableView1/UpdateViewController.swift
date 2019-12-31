//
//  UpdateViewController.swift
//  TableView1
//
//  Created by R Shantha Kumar on 12/27/19.
//  Copyright © 2019 R Shantha Kumar. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects


class UpdateViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

          var name:HoshiTextField!
          var age:HoshiTextField!
          var email:HoshiTextField!
           var imageButton:UIButton!
            var submitButton:UIButton!
    
    var xx = ""
    @IBOutlet weak var contentView: UIView!
    
    var imagePicker:UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
      dusplayText()
        uiDiplayPath()
        
        // Do any additional setup after loading the view.
    }
    
    func uiDiplayPath(){
    
   
    
      
      imageButton = UIButton()
      imageButton.frame = CGRect(x: 110, y: 100, width: 200, height: 200)
      imageButton.setBackgroundImage(UIImage(named: "defaultImage"), for: UIControl.State.normal)
      imageButton.layer.cornerRadius = imageButton.frame.size.width/2
      imageButton.clipsToBounds = true
      imageButton.addTarget(self, action: #selector(imageButtonActionc(object:)), for: UIControl.Event.touchUpInside)
      contentView.addSubview(imageButton)
      
      
      
      
         name = HoshiTextField()
         name.frame = CGRect(x: 100, y: 320, width: 200, height: 50)
         name.placeholder = "Name"
         name.borderInactiveColor = .white
         name.placeholderColor = .white
         name.textColor = .white
         name.borderActiveColor = .white
         contentView.addSubview(name)
         
         age = HoshiTextField()
         age.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
         age.borderActiveColor = .white
         age.borderInactiveColor = .white
         age.placeholder = "Age"
         age.textColor = .white
         age.placeholderColor = .white
         contentView.addSubview(age)
         
         email = HoshiTextField()
         email.frame = CGRect(x: 100, y: 480, width: 200, height: 50)
         email.borderInactiveColor = .white
         email.borderActiveColor = .white
         email.placeholderColor = .white
         email.textColor = .white
         email.placeholder = "Indutry"
         contentView.addSubview(email)
         
         
         submitButton = UIButton()
         submitButton.frame = CGRect(x: 140, y: 570, width: 100, height: 50)
         submitButton.backgroundColor = .systemBlue
         submitButton.setTitle("SUBMIT", for: UIControl.State.normal)
         submitButton.layer.cornerRadius = submitButton.frame.size.width/6
         submitButton.clipsToBounds = true
         submitButton.addTarget(self, action: #selector(saveButton), for: UIControl.Event.touchUpInside)
         contentView.addSubview(submitButton)
      
         
         
         }
    //    imageButton action
                @objc func imageButtonActionc(object:Any){
             
             
             if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum)){
             
                imagePicker.delegate = self
                  imagePicker.sourceType = .savedPhotosAlbum
                  imagePicker.allowsEditing = true
             
             
                 self.present(imagePicker, animated: true, completion: nil)
                
               
               }
                
            }
         
     //    picker view method
         
    var imageData:NSData!
     
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {

             if  let pickedImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage{

                 
                 
                 imageButton.setImage(pickedImage, for: UIControl.State.normal)

                
                 
                 
            
                 imageData = (pickedImage.pngData()! as NSData)
                     
                
                     
                     
                 
                

             }

             dismiss(animated: true, completion: nil)

         }

         
    
     @objc func saveButton(){
    
         DBManager.shared.index = [Int]()
        
         var defaultImaged = UIImage(named: "defaultImage")
               var nsDataImage = defaultImaged?.pngData()! as! NSData
         
       
             DBManager.shared.insertingData(entityName:"Contacts",key1:"name",key2:"age",key3:"industry",key4:"imageData",key5:"designation", value1:name.text!,value2:age.text!,value3:email.text!,value4:imageData ?? nsDataImage  ,value5:"tollywood")
                    
           
     
            navigationController?.popViewController(animated: true)
            
        }
     
     
     func dusplayText(){
         
//         name!.text  = DBManager.shared.names[DBManager.shared.indexPath]
//         age!.text   = DBManager.shared.mobileNumber[DBManager.shared.indexPath]
//         email!.text = DBManager.shared.email[DBManager.shared.indexPath]
         
         
         
         
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
