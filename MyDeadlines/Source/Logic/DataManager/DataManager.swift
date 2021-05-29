import Foundation

protocol DataManager {
    
    func saveTask(task: TaskModel)
    func getTasks() -> [TaskModel]
    func onTask(index: Int) -> TaskModel
    func replaceData(newTask: TaskModel, index: Int)
}

final class DataManagerImp {
    private var tasks: [TaskModel] = []
}

extension DataManagerImp: DataManager {
    
    func getTasks() -> [TaskModel] {
        return tasks
    }
    
    func saveTask(task: TaskModel) {
        tasks.append(task)
    }
    
    func onTask(index: Int) -> TaskModel {
        return tasks[index]
    }
    
    func replaceData(newTask: TaskModel, index: Int) {
        tasks[index] = newTask
    }
}
