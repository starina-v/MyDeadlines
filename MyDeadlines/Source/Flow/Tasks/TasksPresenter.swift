import Foundation

protocol TasksPresenter {
    
    var tasks: [TaskModel] { get }
    func addNewTask()
}

final class TasksPresenterImp {
    
    var tasks: [TaskModel] = []
    
    private weak var view: TasksView?
    private weak var flow: Flow?
    
    init(view: TasksView, flow: Flow) {
        self.view = view
        self.flow = flow
    }
}

//MARK: - TasksPresenter
extension TasksPresenterImp: TasksPresenter {
    
    func addNewTask() {
        flow?.navigate(to: .createTask)
    }
}
