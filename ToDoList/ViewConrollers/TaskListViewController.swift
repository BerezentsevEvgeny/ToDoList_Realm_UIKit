//
//  ViewController.swift
//  ToDoList
//
//  Created by Евгений Березенцев on 05.01.2022.
//

import RealmSwift

class TaskListViewController: UITableViewController {
    
    private let storage = StorageManager.shared
    private var taskList: Results<TaskList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        taskList = storage.realm.objects(TaskList.self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let taskList = taskList[indexPath.row]
        guard let taskVC = segue.destination as? TaskViewController else { return }
        taskVC.taskList = taskList
    }
    
    // MARK: - Swipes configuration
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "DELETE") { action, view, escape in
            let alert = UIAlertController(title: "This Task list will be deleted", message: nil, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "Delete task list", style: .destructive, handler: {_ in
                escape(true)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                escape(true)
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }

}


// MARK: - Table view data source
extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath)
        let list = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = list.name
        content.secondaryText = "\(list.tasks.count) tasks"
        cell.contentConfiguration = content
        return cell
    }
    
    
}

