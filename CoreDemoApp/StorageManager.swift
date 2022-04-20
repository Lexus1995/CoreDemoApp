//
//  StorageManager.swift
//  CoreDemoApp
//
//  Created by  Aliaksei on 19.04.2022.
//

import Foundation
import CoreData
import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    var taskList: [Task] = []

    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchData() {
        let fetchRequest = Task.fetchRequest()
        do {
            taskList = try viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
     func save(_ taskName: String) {
        let task = Task(context: viewContext)
        task.title = taskName
        taskList.append(task)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(_ taskNumber: Int) {
        let commit = NetworkManager.shared.taskList[taskNumber]
        viewContext.delete(commit)
        
        if taskList.isEmpty { return }
        taskList.remove(at: taskNumber)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
