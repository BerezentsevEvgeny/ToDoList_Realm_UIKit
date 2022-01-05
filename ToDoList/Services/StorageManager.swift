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
        try! realm.write {
            realm.add(taskLists)
        }
    }
}
