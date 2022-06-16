//
//  ViewController.swift
//  todoListCoreData
//
//  Created by Gorbyno S on 16/06/22.
//

import UIKit


class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
      var userDefaults = UserDefaults.standard
      var taskList:[task] = []
      
    
    @IBOutlet weak var tableList: UITableView!
   
    @IBAction func buttonAdd(_ sender: Any) {
        let a = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddController")
        self.navigationController?.pushViewController(a, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableList.dataSource = self
        tableList.delegate = self
                if let savedData = userDefaults.value(forKey: "data") as? Data {
                    let loadedData = try? PropertyListDecoder().decode(Array<task>.self, from: savedData)
                    taskList = loadedData!
                    
                }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell",for: indexPath) as! ListTableViewCell
        
        cell.lblTitle?.text = taskList[indexPath.row].title
        cell.lblSubtitle?.text = taskList[indexPath.row].subtitle
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    var indeks = 0;
      func tableView(_ tableView: UITableView,
                     trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let action = UIContextualAction(style: .normal,
                                          title: "Delete") { [weak self] (action, view, completionHandler) in
                                              self?.handleMarkAsFavourite()
                                              completionHandler(true)
          }
          indeks = indexPath.row
          action.backgroundColor = .systemRed
          
          return UISwipeActionsConfiguration(actions: [action])
      }
      
      private func handleMarkAsFavourite() {
          self.taskList.remove(at: indeks)
          let encoder = PropertyListEncoder()
          
          if let encoded = try? encoder.encode(taskList) {
              userDefaults.set(encoded, forKey: "data")
             
          }
          tableList.reloadData()
          
      }
      
  
    
}

