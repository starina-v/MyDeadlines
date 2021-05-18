import Foundation

protocol SetDeadlinesPresenter {
    var name: String { get }
    var labs: [LessonModel] { get }
    var practical: [LessonModel] { get }
    var task: TaskModel { get }
}

final class SetDeadlinesPresenterImp {
    
    var name: String
    var labs: [LessonModel]
    var practical: [LessonModel]
    lazy var task: TaskModel = TaskModel(name: name,
                                         labs: labs.count,
                                         practical: practical.count,
                                         total: labs + practical)
    
    private weak var view: SetDeadlinesView?
    
    init(view: SetDeadlinesView, name: String, labs: [LessonModel], practical: [LessonModel]) {
        self.view = view
        self.name = name
        self.labs = labs
        self.practical = practical
    }
}

//MARK: - SetDeadlinesPresenter
extension SetDeadlinesPresenterImp: SetDeadlinesPresenter {
}
