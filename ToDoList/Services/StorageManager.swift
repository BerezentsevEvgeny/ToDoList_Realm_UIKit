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
    
    // MARK: - Work with Cars
    func save(cars: [Car]) {
        write {
            realm.add(cars)
        }
    }
    
    func save(car: Car) {
        write {
            realm.add(car)
        }
    }
    
    func delete(car: Car) {
        write {
            realm.delete(car.notes)
            realm.delete(car)
        }
    }
    
    func edit(car: Car, newValue: String) {
        write {
            car.name = newValue
        }
    }
    
    func done(car: Car) {
        write {
            car.notes.setValue(true, forKey: "isComplete")
        }
    }
    
    // MARK: - Work with notes
    func delete(note: Note) {
        write {
            realm.delete(note)
        }
    }
    
    func edit(note: Note, name: String, text: String) {
        write {
            note.name = name
            note.text = text
        }
    }
        
    func save(note: Note, in car: Car) {
        write {
            car.notes.append(note)
        }
    }
    
    func done(note: Note) {
        write {
            note.isComplete.toggle()
        }
    }
  
}
