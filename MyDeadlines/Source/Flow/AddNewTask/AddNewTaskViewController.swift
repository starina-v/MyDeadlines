import Foundation
import UIKit

protocol AddNewTaskView: AnyObject {
}

final class AddNewTaskViewController: UIViewController, AddNewTaskView {
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var labsField: UITextField!
    @IBOutlet private weak var practicalField: UITextField!
    
    private var presenter: AddNewTaskPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: AddNewTaskPresenter!) {
        self.presenter = presenter
    }
}

private extension AddNewTaskViewController {
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        getTaskInfo()
    }
    
    func generateItem(count: Int, name: String) -> [LessonModel] {
        var labs: [LessonModel] = []
        for item in 0..<count {
            labs.append(LessonModel(name: "\(name) \(item+1)", deadline: Date()))
        }
        return labs
    }
    
    func getTaskInfo() {
        guard let name = nameField.text, let labsString = labsField.text, let practicalString = practicalField.text else { return }
        let labsToInt = Int(labsString) ?? 0
        let practToInt = Int(practicalString) ?? 0
        let labs = generateItem(count: labsToInt, name: "Lab")
        let practical = generateItem(count: practToInt, name: "Pract")
        let task = TaskModel(name: name, labs: labs, practical: practical)
        presenter.setTask(with: task)
    }
}
