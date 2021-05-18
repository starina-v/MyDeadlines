import Foundation
import UIKit

protocol AddNewTaskView: AnyObject {
}

class AddNewTaskViewController: UIViewController, AddNewTaskView {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var labsField: UITextField!
    @IBOutlet weak var practicalField: UITextField!
    
    private var presenter: AddNewTaskPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: AddNewTaskPresenter!) {
        self.presenter = presenter
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        getTaskInfo()
    }
}

private extension AddNewTaskViewController {
    
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
        presenter.setTask(name: name, labs: labs, practical: practical)
    }
}
