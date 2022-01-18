//
//  ViewController.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 05.01.2022.
//

import RealmSwift

class CarListViewController: UITableViewController {
    
    private let storage = StorageManager.shared
    private var carList: Results<Car>!

    override func viewDidLoad() {
        super.viewDidLoad()
        createSampleData()
        carList = storage.realm.objects(Car.self)
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view Data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarListCell", for: indexPath)
        let car = carList[indexPath.row]
        cell.configure(with: car)
        return cell
    }
    
    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentList = carList[indexPath.row]
    
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, isDone in
            self.showAlert(with: currentList) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        let doneAction = UIContextualAction(style: .normal, title: "Done") { _, _, isDone in
            StorageManager.shared.done(car: currentList)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(car: currentList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let taskList = carList[indexPath.row]
        guard let taskVC = segue.destination as? CarNotesViewController else { return }
        taskVC.car = taskList
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        showAlert()
    }
    
    // Sorting
    
    private func createSampleData() {
        DataManager.shared.createSampleData {
            self.tableView.reloadData()
        }
    }
    
}


extension CarListViewController {
    
    private func showAlert(with car: Car? = nil, completion: (() -> Void)? = nil) {
     
        let title = car != nil ? "Edit car name" : "Add new car"
        let alert = UIAlertController.createAlert(withTitle: title, andMessage: "Please enter car name")
        
        alert.action(with: car) { newValue in
            if let car = car, let completion = completion {
                StorageManager.shared.edit(car: car, newValue: newValue)
                completion()
            } else {
                self.save(car: newValue)
            }
        }
        present(alert, animated: true)
    }
    
    private func save(car: String) {
        let car = Car(value: [car])
        StorageManager.shared.save(car: car)
        let rowIndex = IndexPath(row: carList.count - 1, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
    }
}

