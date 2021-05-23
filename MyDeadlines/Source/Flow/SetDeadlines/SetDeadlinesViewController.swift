import Foundation
import UIKit

protocol SetDeadlinesView: AnyObject {
}

class SetDeadlinesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var presenter: SetDeadlinesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAppearance()
    }
    
    func inject(presenter: SetDeadlinesPresenter!) {
        self.presenter = presenter
    }
}

extension SetDeadlinesViewController: SetDeadlinesView {
}

extension SetDeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lessons = presenter.task.labs.count + presenter.task.practical.count
        return lessons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SetDeadlinesCell.self)
        let lessons = presenter.task.labs + presenter.task.practical
        cell.update(with: lessons[indexPath.row])
        return cell
    }
}

private extension SetDeadlinesViewController {
    
    func setupViewAppearance() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(nibWithCellClass: SetDeadlinesCell.self)
    }
}
