import Foundation

protocol TaskInfoPresenter {
    
    var task: TaskModel { get }
}

final class TaskInfoPresenterImp {
    
    var task: TaskModel
    
    private weak var view: TaskInfoView?
    private weak var flow: Flow?
    private var dataManager: DataManager?
    
    init(view: TaskInfoView, flow: Flow, dataManager: DataManager, task: TaskModel) {
        self.view = view
        self.flow = flow
        self.dataManager = dataManager
        self.task = task
    }
}

extension TaskInfoPresenterImp: TaskInfoPresenter {
}
