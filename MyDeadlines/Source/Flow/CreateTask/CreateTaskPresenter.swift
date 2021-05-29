import Foundation

protocol CreateTaskPresenter {
    
    var task: TaskModel { get }
    var name: String { get set }
    var dates: [Date] { get set }
    var labsCount: Int { get set }
    var pracCount: Int { get set }
    func setTaskDetails(with taskModel: TaskModel)
    func saveTask()
    func updateTask()
    func validate()
}

final class CreateTaskPresenterImp {
    
    var task = TaskModel(name: "", lessons: [], progress: 0)
    
    var name = ""
    var dates: [Date] = []
    var labsCount = 0
    var pracCount = 0
    
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
    
    func generateItems(labsCount: Int, pracCount: Int) -> [LessonModel] {
        var labs: [LessonModel] = []
        for item in 0..<labsCount {
            dates.append(Date())
            labs.append(LessonModel(name: "Lab №\(item+1)", deadline: dates[item], isFinished: false))
        }
        
        for item in 0..<pracCount {
            dates.append(Date())
            labs.append(LessonModel(name: "Prac №\(item+1)", deadline: dates[labsCount+item], isFinished: false))
        }
        return labs
    }
    
    func updateTask() {
        view?.setName()
        let les = generateItems(labsCount: labsCount, pracCount: pracCount)
        let taskDetails = TaskModel(name: name, lessons: les, progress: 0)
        setTaskDetails(with: taskDetails)
    }
}
