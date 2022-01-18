//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 05.01.2022.
//

import RealmSwift

class CarNotesViewController: UITableViewController {
    
    var car: Car!
    
    private var currentNotes: Results<Note>!
    private var completedNotes: Results<Note>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentNotes = car.notes.filter("isComplete = false")
        completedNotes = car.notes.filter("isComplete = true")
        setupNavigationBar()
        tableView.rowHeight = 60
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentNotes.count : completedNotes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "CURRENT" : "COMPLETED"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = indexPath.section == 0 ? currentNotes[indexPath.row] : completedNotes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = note.name
        content.secondaryText = note.text
        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = indexPath.section == 0
            ? currentNotes[indexPath.row]
            : completedNotes[indexPath.row]
                
        let doneTitle = indexPath.section == 0 ? "Done" : "Undone"
        let doneAction = UIContextualAction(style: .normal, title: doneTitle) { _, _, isDone in
            StorageManager.shared.done(note: task)
            
            let indexPathForCurrentTask = IndexPath(row: self.currentNotes.count - 1, section: 0)
            let indexPathForCompletedTask = IndexPath(row: self.completedNotes.count - 1, section: 1)
            let destinationIndexRow = indexPath.section == 0 ? indexPathForCompletedTask : indexPathForCurrentTask
            
            tableView.moveRow(at: indexPath, to: destinationIndexRow)
            isDone(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(note: task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        doneAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        return UISwipeActionsConfiguration(actions: [doneAction, deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = indexPath.section == 0 ? currentNotes[indexPath.row] : completedNotes[indexPath.row]
        showAlert(with: task) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func setupNavigationBar() {
        title = car.name
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
    }
    
    @objc private func addButtonPressed() {
        showAlert()
    }
}


extension CarNotesViewController {
    
    private func showAlert(with task: Note? = nil, completion: (() -> Void)? = nil) {
        
        let title = task != nil ? "Edit note" : "Add new note"
        let alert = UIAlertController.createAlert(withTitle: title, andMessage: "For \(car.name)")
        
        alert.action(with: task) { newValue, note in
            
            if let task = task, let completion = completion {
                StorageManager.shared.edit(note: task, name: newValue, text: note)
                completion()
            } else {
                self.saveTask(withName: newValue, andNote: note)
            }
        }
        
        present(alert, animated: true)
    }
    
    private func saveTask(withName name: String, andNote note: String) {
        let task = Note(value: [name, note])        
        StorageManager.shared.save(note: task, in: car)
        let rowIndex = IndexPath(row: currentNotes.count - 1, section: 0)
        tableView.insertRows(at: [rowIndex], with: .automatic)
    }
}

