//
//  CarTableViewCell.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 18.01.2022.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    func configure(with car: Car) {
//        let currentTasks = car.notes.filter("isComplete = false")
//        let completedTasks = car.notes.filter("isComplete = true")
//
//        var content = defaultContentConfiguration()
//
//        content.text = car.name
//
//        if !currentTasks.isEmpty {
//            content.secondaryText = "Notes \(currentTasks.count)"
//            accessoryType = .none
//        } else if !completedTasks.isEmpty {
//            content.secondaryText = nil
//            accessoryType = .checkmark
//        } else {
//            accessoryType = .none
//            content.secondaryText = "0"
//        }
//
//        contentConfiguration = content
        nameLabel.text = car.name
        yearLabel.text = car.year
    }

}
