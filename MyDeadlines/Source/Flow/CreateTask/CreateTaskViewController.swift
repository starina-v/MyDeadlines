import Foundation
import UIKit

protocol CreateTaskView: AnyObject {
    
    func showAlert(title: String, message: String)
    func setName()
}

final class CreateTaskViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var labStepper: UIStepper!
    @IBOutlet private weak var pracStepper: UIStepper!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var labLabel: UILabel!
    @IBOutlet private weak var pracLabel: UILabel!
    
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setName() {
        guard let name = nameField.text else { return }
        presenter.name = name
    }
}

private extension CreateTaskViewController {
    
    @IBAction func labStepperTapped(_ sender: UIStepper) {
        presenter.labsCount = Int(sender.value)
        labLabel.text = "Labs quantity: \(presenter.labsCount)"
        presenter.updateTask()
        tableView.reloadData()
    }
    
    @IBAction func pracStepperTapped(_ sender: UIStepper) {
        presenter.pracCount = Int(sender.value)
        pracLabel.text = "Practical quantity: \(presenter.pracCount)"
        presenter.updateTask()
        tableView.reloadData()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        presenter.updateTask()
        presenter.validate()
    }
}

extension CreateTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.task.lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CreateTaskCell.self)
        cell.callback = { datePicker in
            self.presenter.dates[indexPath.row] = (datePicker.date)
        }
        cell.update(with: presenter.task.lessons[indexPath.row])
        return cell
    }
}

private extension CreateTaskViewController {
    
    func setupViewAppearance() {
        navigationItem.title = "Create new task"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(nibWithCellClass: CreateTaskCell.self)
        
        labStepper.value = 0
        labStepper.minimumValue = 0
        
        pracStepper.value = 0
        pracStepper.minimumValue = 0
        
        labLabel.text = "Labs quantity: \(presenter.labsCount)"
        pracLabel.text = "Practical quantity: \(presenter.pracCount)"
    }
}
