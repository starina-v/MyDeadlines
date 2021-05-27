import Foundation

protocol DataManager {
    
    func saveTask(task: TaskModel)
    func getTasks() -> [TaskModel]
}

final class DataManagerImp {
    private var tasks: [TaskModel] // private (set)
    
    init(tasks: [TaskModel]) {
        self.tasks = tasks
    }
}

extension DataManagerImp: DataManager {
    
    func getTasks() -> [TaskModel] {
        return tasks
    }
    
    func saveTask(task: TaskModel) {
        tasks.append(task)
    }
}
