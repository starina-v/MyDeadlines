import Foundation

protocol TasksPresenter {
    
    var tasks: [TaskModel] { get }
    func addNewTask()
    func getTasks()
}

final class TasksPresenterImp {
    
    var tasks: [TaskModel] = []
    
    private weak var view: TasksView?
    private weak var flow: Flow?
    private var dataManager: DataManager?
    
    init(view: TasksView, flow: Flow, dataManager: DataManager) {
        self.view = view
        self.flow = flow
        self.dataManager = dataManager
    }
}

//MARK: - TasksPresenter
extension TasksPresenterImp: TasksPresenter {
    
    func getTasks() {
        guard let newTask = dataManager?.getTasks() else { return }
        tasks = newTask
        self.view?.update()
    }
    
    func addNewTask() {
        flow?.navigate(to: .createTask)
    }
}
