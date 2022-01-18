//
//  Extension + UITableViewCell.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 09.01.2022.
//

import UIKit

extension UITableViewCell {
    
    func configure(with car: Car) {
        let currentTasks = car.notes.filter("isComplete = false")
        let completedTasks = car.notes.filter("isComplete = true")
        
        var content = defaultContentConfiguration()
        
        content.text = car.name
        
        if !currentTasks.isEmpty {
            content.secondaryText = "Notes \(currentTasks.count)"
            accessoryType = .none
        } else if !completedTasks.isEmpty {
            content.secondaryText = nil
            accessoryType = .checkmark
        } else {
            accessoryType = .none
            content.secondaryText = "0"
        }
        
        contentConfiguration = content
    }
}
