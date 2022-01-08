//
//  StorageManager.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 05.01.2022.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func save(taskLists: [TaskList]) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    // Safe writing method
    func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
