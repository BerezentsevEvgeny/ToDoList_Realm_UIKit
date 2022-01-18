//
//  TaskList.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 05.01.2022.
//

import RealmSwift

class Note: Object {
    @objc dynamic var name = ""
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    @objc dynamic var isComplete = false
}

class Car: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    let notes = List<Note>()
}
