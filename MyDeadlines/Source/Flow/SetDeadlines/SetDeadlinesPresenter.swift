import Foundation

protocol SetDeadlinesPresenter {
    
    var task: TaskModel { get }
}

final class SetDeadlinesPresenterImp {
    
    var task: TaskModel
    
    private weak var view: SetDeadlinesView?
    
    init(view: SetDeadlinesView, task: TaskModel ) {
        self.view = view
        self.task = task
    }
}

//MARK: - SetDeadlinesPresenter
extension SetDeadlinesPresenterImp: SetDeadlinesPresenter {
}
