//
//  TableViewController.swift
//  TableView1
//
//  Created by R Shantha Kumar on 12/23/19.
//  Copyright © 2019 R Shantha Kumar. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects


class TableViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    var manageContext:NSManagedObjectContext!
    var personEntity:NSEntityDescription!
    var appDelete1:AppDelegate!
    
    var imagePicker = UIImagePickerController()
    var segmentedControl:UISegmentedControl!
       
       
       var name:HoshiTextField!
       var age:HoshiTextField!
       var email:HoshiTextField!
       
       
       var imageButton:UIButton!
       
       var submitButton:UIButton!
       var imageData:NSData?
    
    @IBOutlet weak var contentVIew: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiDiplayPath()
        
        
        name.delegate = self
        age.delegate = self
        email.delegate = self
        
       dusplayText()
        
        // Do any additional setup after loading the view.
    }
   
    func uiDiplayPath(){
        
        segmentedControl = UISegmentedControl()
        let items = ["tollywood","bollywood","hollywood"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 80, y: 650, width: 250, height: 50)
        segmentedControl.selectedSegmentIndex = -1
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(eventForSegmentcontrol(obj:)), for: UIControl.Event.valueChanged)
        contentVIew.addSubview(segmentedControl)
        
          
          imageButton = UIButton()
          imageButton.frame = CGRect(x: 110, y: 100, width: 200, height: 200)
          imageButton.setBackgroundImage(UIImage(named: "defaultImage"), for: UIControl.State.normal)
          imageButton.layer.cornerRadius = imageButton.frame.size.width/2
          imageButton.clipsToBounds = true
          imageButton.addTarget(self, action: #selector(imageButtonActionc(object:)), for: UIControl.Event.touchUpInside)
          contentVIew.addSubview(imageButton)
          
          
          
          
             name = HoshiTextField()
             name.frame = CGRect(x: 100, y: 320, width: 200, height: 50)
             name.placeholder = "Name"
             name.borderInactiveColor = .white
             name.placeholderColor = .white
             name.textColor = .white
             name.borderActiveColor = .white
             contentVIew.addSubview(name)
             
             age = HoshiTextField()
             age.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
             age.borderActiveColor = .white
             age.borderInactiveColor = .white
             age.placeholder = "Age"
             age.textColor = .white
             age.placeholderColor = .white
             contentVIew.addSubview(age)
             
             email = HoshiTextField()
             email.frame = CGRect(x: 100, y: 480, width: 200, height: 50)
             email.borderInactiveColor = .white
             email.borderActiveColor = .white
             email.placeholderColor = .white
             email.textColor = .white
             email.placeholder = "Indutry"
             contentVIew.addSubview(email)
             
             
             submitButton = UIButton()
             submitButton.frame = CGRect(x: 140, y: 570, width: 100, height: 50)
             submitButton.backgroundColor = .systemBlue
             submitButton.setTitle("SUBMIT", for: UIControl.State.normal)
             submitButton.layer.cornerRadius = submitButton.frame.size.width/6
             submitButton.clipsToBounds = true
             submitButton.addTarget(self, action: #selector(saveButton), for: UIControl.Event.touchUpInside)
             contentVIew.addSubview(submitButton)
          
             
             
             }

    //    alerts
        
        
        var msg:String!
        
        func alerts(){
            
            var alert = UIAlertController.init(title: "WARNING", message: "\(msg!)", preferredStyle: UIAlertController.Style.alert)
                var alertACtion = UIAlertAction.init(title: "ok", style: UIAlertAction.Style.default) { (cacel) in
                    
                     
                    
                    
                }
                     alert.addAction(alertACtion)
                
                present(alert, animated: true, completion: nil)
                
            }
        
        
    // validations
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
            
            if(textField == name){
                return true
               
            }
            
            if(textField == age){
                
                if(name.text!.count >= 1){
                    
                    return true
                }else{
                    
                    msg = "fill one by one"
                    alerts()
                    return false
                    
                }
                
            }
                
                
            if(textField == email){
                
                if(name.text!.count >= 1 && Int(age.text!)! < 120 && Int(age.text!)! > 0){
                    
                    return true
                }else{
                    msg = "give age properlty"
                    alerts()
                    return false
                }
       
      
        }
             return true
    }

         func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
            
            if(textField == name){

                let allowCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")

                if(string.rangeOfCharacter(from: allowCharacters) != nil||string == ""){



                    return true
                }else
                {
                    msg = "invalid keyword"
                    
                    alerts()
                    return false
                }
            }
                if(textField == email){

                let allowCharacters = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.@-1234567890 ")

                if(string.rangeOfCharacter(from: allowCharacters) != nil||string == ""){



                    return true
                }else
                {
                    msg = "invalid keyword"
                    
                    alerts()
                    return false
                }


            }
                
                if(textField == age){

                    let allowCharacters = CharacterSet(charactersIn:"1234567890")

                    if(string.rangeOfCharacter(from: allowCharacters) != nil||string == ""){



                        return true
                    }else
                    {
                        msg = "invalid keyword"
                        
                        alerts()
                        return false
                    }


                }
           
            
        
         return true
        }
    
    
    @objc func eventForSegmentcontrol(obj:UISegmentedControl)
    {
        DBManager.shared.index = [Int]()
        
       
        
        print(DBManager.shared.index)
        
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
        
    
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {

            if  let pickedImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage{

                
                
                imageButton.setImage(pickedImage, for: UIControl.State.normal)

               
                
                
           
                imageData = (pickedImage.pngData()! as NSData)
                    
               
                    
                    
                
               

            }

            dismiss(animated: true, completion: nil)

        }

        
   
    @objc func saveButton(){
        
        print("%%%%%%%%%%%%%%%",segmentedControl.selectedSegmentIndex)
        DBManager.shared.index = [Int]()
       
        var defaultImaged = UIImage(named: "defaultImage")
              var nsDataImage = defaultImaged?.pngData()! as! NSData
        
      
            DBManager.shared.insertingData(entityName:"Contacts",key1:"name",key2:"age",key3:"industry",key4:"imageData",key5:"designation", value1:name.text!,value2:age.text!,value3:email.text!,value4:imageData ?? nsDataImage  ,value5:"tollywood")
                   
          
    
           navigationController?.popViewController(animated: true)
           
       }
    
    
    func dusplayText(){
        
//        name!.text  = DBManager.shared.names[DBManager.shared.indexPath]
//        age!.text   = DBManager.shared.mobileNumber[DBManager.shared.indexPath]
//        email!.text = DBManager.shared.email[DBManager.shared.indexPath]
        
        
        
        
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
