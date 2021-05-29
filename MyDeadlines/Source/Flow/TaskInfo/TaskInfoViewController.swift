import Foundation
import UIKit

protocol TaskInfoView: AnyObject {
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
    
    func inject(presenter: TaskInfoPresenter!) {
        self.presenter = presenter
    }
}

extension TaskInfoViewController: TaskInfoView {
}

extension TaskInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.task.lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskInfoCell.self)
        cell.update(with: presenter.task.lessons[indexPath.row])
        return cell
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
