import Foundation

protocol CreateTaskPresenter {
    
    var task: TaskModel { get }
    func setTask(with taskModel: TaskModel)
}

final class CreateTaskPresenterImp {
    
    var task = TaskModel(name: "", labs: [], practical: [])
    private weak var view: CreateTaskView?
    private weak var flow: Flow?
    
    init(view: CreateTaskView, flow: Flow) {
        self.view = view
        self.flow = flow
    }
}

//MARK: - TasksPresenter
extension CreateTaskPresenterImp: CreateTaskPresenter {
    
    func setTask(with taskModel: TaskModel) {
        task = taskModel
    }
}
