import Foundation

protocol TaskInfoPresenter {
    
    var task: TaskModel { get set }
    var index: Int { get }
    func replace()
    func removeItem(lessonIndex: Int)
    func getOneTask()
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
    
    func getOneTask() {
        guard let newTask = dataManager?.getOneTask(index: index) else { return }
        task = newTask
        self.view?.update()
    }
    
    func replace() {
        dataManager?.replaceTask(newTask: task, index: index)
    }
    
    func removeItem(lessonIndex: Int) {
        dataManager?.removeLesson(taskIndex: index, lessonIndex: lessonIndex)
        getOneTask()
    }
}
