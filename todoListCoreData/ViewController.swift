//
//  ViewController.swift
//  todoListCoreData
//
//  Created by Gorbyno S on 16/06/22.
//

import UIKit
import CoreData

var taskList = [Task]()

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableList: UITableView!
   
    
    let appDelegateObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate
      var dataArray = [NSManagedObject]()
    
    @IBAction func buttonAdd(_ sender: Any) {
        let a = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddController")
        self.navigationController?.pushViewController(a, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        
        
        tableList.delegate = self
        tableList.dataSource = self
    }
    
    
       func fetchData() {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
                       let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                       let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
                       do {
                           let results:NSArray = try context.fetch(request) as NSArray
                           for result in results
                           {
                               let note = result as ! Task
                               taskList.append(note)
                           }
                       }
                       catch
                       {
                           print("Fetch Failed")
                       }
       }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell",for: indexPath) as! ListTableViewCell
           
//               // set the text from the data model
        cell.lblTitle?.text = self.title
        
        return cell
    }
    
  
    
}

