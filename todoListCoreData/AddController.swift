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

    var selectedTask: Task? = nil
    
   
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtSubtitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(selectedTask != nil)
                {
                    txtTitle.text = selectedTask?.title
                    txtSubtitle.text = selectedTask?.subtitle
                    txtDescription.text = selectedTask?.desc
                }
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                if(selectedTask == nil)
                {
                    let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context)
                    let newNote = Task(entity: entity!, insertInto: context)
//                    newNote.id = noteList.count as NSNumber
                    newNote.title = txtTitle.text
                    newNote.subtitle = txtSubtitle.text
                    newNote.desc = txtDescription.text
                    do
                    {
                        try context.save()
//                        noteList.append(newNote)
                        navigationController?.popViewController(animated: true)
                    }
                    catch
                    {
                        print("context save error")
                    }
                }
                else //edit
                {
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                    do {
                        let results:NSArray = try context.fetch(request) as NSArray
                        for result in results
                        {
                            let note = result as! Task
                            if(note == selectedTask)
                            {
                                note.title = txtTitle.text
                                note.subtitle = txtSubtitle.text
                                note.desc = txtDescription.text
                                try context.save()
                                navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                    catch
                    {
                        print("Fetch Failed")
                    }
                }
        
    }
    
   
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
}


