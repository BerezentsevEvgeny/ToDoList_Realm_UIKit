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
            
            let sampleCar = Car()
            sampleCar.name = "Sample car"
            
            let noteOne = Note(value: ["Sample note one", "Do something", Date(), false])
            let noteTwo = Note(value: ["Sample note two", "Do something", Date(), true])
            sampleCar.notes.insert(contentsOf: [noteOne, noteTwo], at: 0)

            DispatchQueue.main.async {
                StorageManager.shared.save(car: sampleCar)
                completion()
            }
        }
    }
}
