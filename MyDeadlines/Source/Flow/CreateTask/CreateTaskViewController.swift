import Foundation
import UIKit

protocol CreateTaskView: AnyObject {
}

final class CreateTaskViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var labStepper: UIStepper!
    @IBOutlet private weak var pracStepper: UIStepper!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var labLabel: UILabel!
    @IBOutlet private weak var pracLabel: UILabel!
    
    private var labsCount = 0
    private var pracCount = 0
    
    private var presenter: CreateTaskPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
    }
    
    func inject(presenter: CreateTaskPresenter!) {
        self.presenter = presenter
    }
}

extension CreateTaskViewController: CreateTaskView {
}

private extension CreateTaskViewController {
    
    @IBAction func labStepperTapped(_ sender: UIStepper) {
        self.labsCount = Int(sender.value)
        labLabel.text = "Labs quantity: \(labsCount)"
        updateTask()
        tableView.reloadData()
    }
    
    @IBAction func pracStepperTapped(_ sender: UIStepper) {
        self.pracCount = Int(sender.value)
        pracLabel.text = "Practical quantity: \(pracCount)"
        updateTask()
        tableView.reloadData()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        updateTask()
        presenter.saveTask()
    }
    
    func generateItem(count: Int, name: String) -> [LessonModel] {
        var labs: [LessonModel] = []
        for item in 0..<count {
            labs.append(LessonModel(name: "\(name) \(item+1)", deadline: Date()))
        }
        return labs
    }
    
    func updateTask() {
        guard let name = nameField.text else { return }
        let labs = generateItem(count: labsCount, name: "Lab")
        let practical = generateItem(count: pracCount, name: "Pract")
        let taskDetails = TaskModel(name: name, labs: labs, practical: practical)
        presenter.setTaskDetails(with: taskDetails)
    }
}

extension CreateTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lessons = (presenter.task.labs.count + presenter.task.practical.count)
        return lessons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CreateTaskCell.self)
        let lessons = (presenter.task.labs + presenter.task.practical)
        cell.update(with: lessons[indexPath.row])
        return cell
    }
}

private extension CreateTaskViewController {
    
    func setupViewAppearance() {
        navigationItem.title = "Create new task"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(nibWithCellClass: CreateTaskCell.self)
        
        labStepper.value = 0
        labStepper.minimumValue = 0
        
        pracStepper.value = 0
        pracStepper.minimumValue = 0
        
        labLabel.text = "Labs quantity: \(labsCount)"
        pracLabel.text = "Practical quantity: \(pracCount)"
    }
}
