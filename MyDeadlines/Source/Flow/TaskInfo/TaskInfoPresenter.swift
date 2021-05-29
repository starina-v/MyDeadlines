import Foundation

protocol TaskInfoPresenter {
    
    var task: TaskModel { get set }
    var index: Int { get }
    func replace()
}

final class TaskInfoPresenterImp {
    
    var task: TaskModel
    var index: Int
    
    private weak var view: TaskInfoView?
    private weak var flow: Flow?
    private var dataManager: DataManager?
    
    init(view: TaskInfoView, flow: Flow, dataManager: DataManager, task: TaskModel, index: Int) {
        self.view = view
        self.flow = flow
        self.dataManager = dataManager
        self.task = task
        self.index = index
    }
}

extension TaskInfoPresenterImp: TaskInfoPresenter {
    
    func replace() {
        dataManager?.replaceData(newTask: task, index: index)
    }
}
