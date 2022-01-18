//
//  DataManager.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 08.01.2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func createSampleData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            
            UserDefaults.standard.set(true, forKey: "done")
            
            let sampleTaskList = TaskList()
            sampleTaskList.name = "Sample task list"
            
            let taskOne = Task(value: ["Sample task one", "Do something", Date(), false])
            let taskTwo = Task(value: ["Sample task two", "Do something", Date(), true])
            sampleTaskList.tasks.insert(contentsOf: [taskOne, taskTwo], at: 0)

            DispatchQueue.main.async {
                StorageManager.shared.save(taskList: sampleTaskList)
                completion()
            }
        }
    }
}
