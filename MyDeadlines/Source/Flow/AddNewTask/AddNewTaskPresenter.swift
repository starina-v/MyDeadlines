import Foundation



protocol AddNewTaskPresenter {
    
    func setTask(with task: TaskModel)
}

final class AddNewTaskPresenterImp {
    
    private weak var view: AddNewTaskView?
    private weak var flow: Flow?
    
    init(view: AddNewTaskView, flow: Flow) {
        self.view = view
        self.flow = flow
    }
}

//MARK: - TasksPresenter
extension AddNewTaskPresenterImp: AddNewTaskPresenter {
    func setTask(with task: TaskModel) {
        flow?.navigate(to: .setDeadlines(task))
    }
}
