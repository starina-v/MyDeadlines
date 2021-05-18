import Foundation
import UIKit

protocol TasksView: AnyObject {
}

class TasksViewController: UIViewController, TasksView {
    
    private var presenter: TasksPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func inject(presenter: TasksPresenter!) {
        self.presenter = presenter
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
    
    @objc func createNewTask(_ sender: UIBarButtonItem) {
        presenter.addNewTask()
    }
}
