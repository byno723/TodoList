//
//  Task.swift
//  todoListCoreData
//
//  Created by Gorbyno S on 16/06/22.
//

import Foundation

import CoreData

@objc(Task)
class Task: NSManagedObject
{
    @NSManaged var title: String!
    @NSManaged var subtitle: String!
    @NSManaged var desc: String!
}
