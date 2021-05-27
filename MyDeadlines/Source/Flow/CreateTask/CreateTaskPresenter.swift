import Foundation

protocol CreateTaskPresenter {
    
    var task: TaskModel { get }
    func setTaskDetails(with taskModel: TaskModel)
    func saveTask()
}

final class CreateTaskPresenterImp {
    
    var task = TaskModel(name: "", labs: [], practical: [])
    
    private weak var view: CreateTaskView?
    private weak var flow: Flow?
    private var dataManager: DataManager?
    
    init(view: CreateTaskView, flow: Flow, dataManager: DataManager) {
        self.view = view
        self.flow = flow
        self.dataManager = dataManager
    }
}

//MARK: - TasksPresenter
extension CreateTaskPresenterImp: CreateTaskPresenter {
    
    func saveTask() {
        dataManager?.saveTask(task: task)
        flow?.navigate(to: .tasks)
    }
    
    func setTaskDetails(with taskModel: TaskModel) {
        task = taskModel
    }
}
