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
    
    private var tasks: [TaskModel]
    
    private let userDataService: UserDataService
    
    init(userDataService: UserDataService) {
        self.userDataService = userDataService
        
        tasks = userDataService.tasks
    }
}

extension DataManagerImp: DataManager {
    
    func getTasks() -> [TaskModel] {
        tasks
    }
    
    func getOneTask(index: Int) -> TaskModel {
        tasks[index]
    }
    
    func onTask(index: Int) -> TaskModel {
        tasks[index]
    }
    
    func saveTask(task: TaskModel) {
        tasks.append(task)
        save()
    }
    
    func removeTask(index: Int) {
        tasks.remove(at: index)
        save()
    }
    
    func removeLesson(taskIndex: Int, lessonIndex: Int) {
        tasks[taskIndex].lessons.remove(at: lessonIndex)
        save()
    }

    func replaceTask(newTask: TaskModel, index: Int) {
        tasks[index] = newTask
        save()
    }
}

private extension DataManagerImp {
    
    func save() {
        userDataService.tasks = tasks
    }
}
