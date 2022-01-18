//
//  Extension + UIAlertController.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 09.01.2022.
//

import UIKit

extension UIAlertController {
    
    static func createAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
        
    // Action for Car list
    func action(with car: Car?, completion: @escaping (String) -> Void) {
        
        let doneButton = car == nil ? "Save" : "Update"
                
        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Car name"
            textField.text = car?.name
        }
    }
    
    // Action for note
    func action(with note: Note?, completion: @escaping (String, String) -> Void) {
        
        let title = note == nil ? "Save" : "Update"
                        
        let saveAction = UIAlertAction(title: title, style: .default) { _ in
            guard let newNote = self.textFields?.first?.text, !newNote.isEmpty else { return }
            
            if let note = self.textFields?.last?.text, !note.isEmpty {
                completion(newNote, note)
            } else {
                completion(newNote, "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
    
        addTextField { textField in
            textField.placeholder = "Name"
            textField.text = note?.name
        }
        
        addTextField { textField in
            textField.placeholder = "Note text"
            textField.text = note?.text
        }
    }
}
