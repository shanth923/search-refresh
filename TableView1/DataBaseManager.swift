//
//  DataBaseManager.swift
//  TableView1
//
//  Created by R Shantha Kumar on 12/23/19.
//  Copyright © 2019 R Shantha Kumar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBManager: NSObject {
    
    
    static var shared = DBManager()
    
    var index = [Int]()
    
    
    var items3 = [String]()
    
    
    
    var names = [String]()
    var mobileNumber = [String]()
    var email = [String]()
    var imagesAll = [UIImage]()
    var tappedButton:Int!
    var indexPath:Int!
    
       var manageContext:NSManagedObjectContext!
       var appDelete1:AppDelegate!
    
    func coreDataCreate(){
           
          appDelete1 = (UIApplication.shared.delegate as! AppDelegate)
           
          
           
        
           
       }
    
    func insertingData(entityName:String,key1:String,key2:String,key3:String,key4:String,key5:String,value1:String,value2:String,value3:String,value4:NSData,value5:String){
        
        guard let   personEntity = NSEntityDescription.entity(forEntityName: entityName, in: manageContext)
            else
        {
            
            print("error in etnity description")
         return
        }
        manageContext = appDelete1.persistentContainer.viewContext
                 
        let managedObject = NSManagedObject(entity: personEntity, insertInto: manageContext)
        
     
         managedObject.setValue(value1, forKey: key1)
         managedObject.setValue(value2, forKey: key2)
         managedObject.setValue(value3, forKey: key3)
         managedObject.setValue(value4, forKey: key4)
         managedObject.setValue(value5, forKey: key5)
        
        
        do{
            
           try manageContext.save()
            
        }catch{
            
            
            print("not saved")
            
        }
    }
    
    
    
    
    
    func fetchDAta(entityName:String) -> [NSManagedObject]{
        
        appDelete1 = (UIApplication.shared.delegate as! AppDelegate)
        
        let fettchRequet = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        
        manageContext = appDelete1.persistentContainer.viewContext
        
        var data:[NSManagedObject]!
        
        do{
            
            data = try manageContext.fetch(fettchRequet) as! [NSManagedObject]
            
            
        }catch{
            
            print("catch error")
            
            
        }
        return data
    }
    
     func deleteData(entityName:String,deleteBasedOnColumn columnName: String,value:String?)
    {
        let data = DBManager.shared.fetchDAta(entityName: entityName)
        
        
        for x in data as! [NSManagedObject]
        {
            if(x.value(forKey: columnName) as? String == value)
            {
                manageContext.delete(x)
            }
        }
        
        
        do
        {
            try manageContext.save()
        }
        catch
        {
            print("Failed To Delete")
        }
    }
    
    
//  updating the result
    
    func updaet(entityName:String,key1:String,key2:String,key3:String,key4:String,key5:String,value1:String,value2:String,value3:String,value4:NSData,value5:String){
        
        
        appDelete1 = (UIApplication.shared.delegate as! AppDelegate)
             
        
        guard let   personEntity = NSEntityDescription.entity(forEntityName: entityName, in: manageContext)
                   else
               {
                   
                   print("error in etnity description")
                return
               }
               let fettchRequet = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
               
               manageContext = appDelete1.persistentContainer.viewContext
               

        var en = NSEntityDescription.entity(forEntityName: entityName, in: manageContext)

        let batchUpdateRequest = NSBatchUpdateRequest(entity:personEntity )
        batchUpdateRequest.resultType = NSBatchUpdateRequestResultType.updatedObjectIDsResultType
        batchUpdateRequest.propertiesToUpdate = [key1:String.self,key2:String.self,key3:String.self,key4:String.self,key5:String.self,value1:String.self,value2:String.self,value3:String.self,value4:NSData.self,value5:String.self]
                   var batchUpdateRequestError: NSError?
//                   manageContext.executeRequest(batchUpdateRequest, error:batchUpdateRequestError)
                   if let error = batchUpdateRequestError {print("error")}
        
        
        
    }
    
    
    
    
    
    private override init() {
        super.init()
    }
  
}
