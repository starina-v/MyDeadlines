import Foundation
import UIKit

protocol TaskInfoView: AnyObject {
    
    func update()
}

final class TaskInfoViewController: UIViewController {
    
    private var presenter: TaskInfoPresenter!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
        nameLabel.text = presenter.task.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getOneTask()
    }
    
    func inject(presenter: TaskInfoPresenter!) {
        self.presenter = presenter
    }
}

extension TaskInfoViewController: TaskInfoView {
    
    func update() {
        tableView?.reloadData()
    }
}

extension TaskInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.task.lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskInfoCell.self)
        cell.callback = { value in
            self.presenter.task.lessons[indexPath.row].isFinished = value
            self.presenter.replace()
        }
        cell.update(with: presenter.task.lessons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeItem(lessonIndex: indexPath.row)
        }
    }
}

private extension TaskInfoViewController {
    
    private func setupViewAppearance() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(nibWithCellClass: TaskInfoCell.self)
    }
}
