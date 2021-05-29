import Foundation

protocol DataManager {
    
    func getTasks() -> [TaskModel]
    func getOneTask(index: Int) -> TaskModel
    func onTask(index: Int) -> TaskModel
    func saveTask(task: TaskModel)
    func removeTask(index: Int)
    func removeLesson(taskIndex: Int, lessonIndex: Int)
    func replaceTask(newTask: TaskModel, index: Int)
}

final class DataManagerImp {
    private var tasks: [TaskModel] = []
}

extension DataManagerImp: DataManager {
    
    func getTasks() -> [TaskModel] {
        return tasks
    }
    
    func getOneTask(index: Int) -> TaskModel {
        return tasks[index]
    }
    
    func onTask(index: Int) -> TaskModel {
        return tasks[index]
    }
    
    func saveTask(task: TaskModel) {
        tasks.append(task)
    }
    
    func removeTask(index: Int) {
        tasks.remove(at: index)
    }
    
    func removeLesson(taskIndex: Int, lessonIndex: Int) {
        tasks[taskIndex].lessons.remove(at: lessonIndex)
        print(tasks[taskIndex].lessons.count)
    }

    func replaceTask(newTask: TaskModel, index: Int) {
        tasks[index] = newTask
    }
}
