//
//  AddController.swift
//  todoListCoreData
//
//  Created by Gorbyno S on 16/06/22.
//

import Foundation
import UIKit

import CoreData

class AddController :UIViewController{

    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtSubtitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    var dataList:[task] = []
    
    var userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }
    
    @IBAction func btnAdd(_ sender: Any) {
       
        let titleTxt = txtTitle.text ?? ""
              let subtitleTxt = txtSubtitle.text ?? ""
              let taskTxt = txtDescription.text ?? ""
              
              
              if titleTxt == ""{
                  let dialogMessage = UIAlertController(title: "Attention", message: "Title is required", preferredStyle: .alert)

                  let ok = UIAlertAction(title:"OK",style: .default, handler: {(action)-> Void in
                      print("OK")
                  })
                  
                  let cancel = UIAlertAction(title:"Cancel", style: .cancel){
                      (action) -> Void in
                      print("Canceled")
                  }
                  
                  dialogMessage.addAction(ok)
                  dialogMessage.addAction(cancel)
                  
                  self.present(dialogMessage,animated: true, completion: nil)
              }
              else if subtitleTxt == ""{
                  let dialogMessage = UIAlertController(title: "Attention", message: "Subtitle must be filled", preferredStyle: .alert)

                  let ok = UIAlertAction(title:"OK",style: .default, handler: {(action)-> Void in
                      print("OK")
                  })
                  
                  let cancel = UIAlertAction(title:"Cancel", style: .cancel){
                      (action) -> Void in
                      print("Canceled")
                  }
                  
                  dialogMessage.addAction(ok)
                  dialogMessage.addAction(cancel)
                  
                  self.present(dialogMessage,animated: true, completion: nil)
              }else{
                  if let savedData = userDefaults.value(forKey: "data") as? Data {
                      let loadedData = try? PropertyListDecoder().decode(Array<task>.self, from: savedData)
                      dataList = loadedData!
                      
                  }

                  dataList.append(task(title: titleTxt, subtitle: subtitleTxt, task: taskTxt))
                  print(dataList)
                  let encoder = PropertyListEncoder()
                  
                  if let encoded = try? encoder.encode(dataList) {
                      userDefaults.set(encoded, forKey: "data")
                     
                  }
                  
                  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                 self.navigationController?.pushViewController(vc, animated: true)
                  
              }
          }
    
    
}


