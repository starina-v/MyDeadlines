import Foundation

protocol CreateTaskPresenter {
    
    var task: TaskModel { get }
    var name: String { get set }
    var labsCount: Int { get set }
    var pracCount: Int { get set }
    var headerTitles: [String] { get }
    func setTaskDetails(with taskModel: TaskModel)
    func saveTask()
    func updateTask()
    func validate()
}

final class CreateTaskPresenterImp {
    
    var task = TaskModel(name: "", labs: [], practical: [])
    
    var name = ""
    var labsCount = 0
    var pracCount = 0
    let headerTitles = ["Labs", "Practical"]
    
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
    
    func validate() {
        if task.name == "" {
            view?.showAlert(title: "Please, enter task name", message: "")
        } else if labsCount == 0, pracCount == 0 {
            view?.showAlert(title: "Please, enter labs or practical quantity", message: "")
        } else {
            saveTask()
        }
    }
    
    func generateItem(count: Int, name: String) -> [LessonModel] {
        var labs: [LessonModel] = []
        for item in 0..<count {
            labs.append(LessonModel(name: "\(name) \(item+1)", deadline: Date()))
        }
        return labs
    }
    
    func updateTask() {
        view?.setName()
        let labs = generateItem(count: labsCount, name: "Lab")
        let practical = generateItem(count: pracCount, name: "Pract")
        let taskDetails = TaskModel(name: name, labs: labs, practical: practical)
        setTaskDetails(with: taskDetails)
    }
}
