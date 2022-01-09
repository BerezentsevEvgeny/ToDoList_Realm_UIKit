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
    
    // Safe writing method
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Work with Lists
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
    
    func delete(taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func edit(taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }
    
    func done(taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    
    // MARK: - Work with tasks
    func delete(task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func edit(task: Task, name: String, note: String) {
        write {
            task.name = name
            task.note = note
        }
    }
        
    func save(task: Task, in taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    func done(task: Task) {
        write {
            task.isComplete.toggle()
        }
    }
  
}
