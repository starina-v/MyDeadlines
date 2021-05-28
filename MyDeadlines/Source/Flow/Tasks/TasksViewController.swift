import Foundation
import UIKit

protocol TasksView: AnyObject {
    
    func update()
}

class TasksViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var presenter: TasksPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViewAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getTasks()
    }
    
    func inject(presenter: TasksPresenter!) {
        self.presenter = presenter
    }
}
extension TasksViewController: TasksView {
    
    func update() {
        tableView?.reloadData()
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TasksCell.self)
        cell.update(with: presenter.tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTaksInfo()
    }
}

private extension TasksViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Tasks"
        let rightButton = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(createNewTask(_:)))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    private func setupViewAppearance() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(nibWithCellClass: TasksCell.self)
    }
    
    @objc func createNewTask(_ sender: UIBarButtonItem) {
        presenter.addNewTask()
    }
}
