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
//        createSampleData()
        taskList = storage.realm.objects(TaskList.self)
    }
    
//    private func createSampleData() {
//        let movieList = TaskList()
//        movieList.name = "Best movies"
//
//        let toDoList = TaskList()
//        toDoList.name = "ToDoList"
//
//        let movieOne = Task()
//        movieOne.name = "Matrix"
//        movieOne.note = "First place"
//
//        let movieTwo = Task(value: ["name": "Titanic","note": "Last place"])
//
//        movieList.tasks.insert(contentsOf: [movieOne,movieTwo], at: 0)
//
//        DispatchQueue.main.async {
//            StorageManager.shared.save(taskLists: [movieList, toDoList])
//        }
//    }

}


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

