import Foundation

protocol AddNewTaskPresenter {
    
    func setTask(name: String, labs: [LessonModel], practical: [LessonModel])
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
    
    func setTask(name: String, labs: [LessonModel], practical: [LessonModel]) {
        flow?.navigate(to: .setDeadlines(name, labs, practical))
    }
}
