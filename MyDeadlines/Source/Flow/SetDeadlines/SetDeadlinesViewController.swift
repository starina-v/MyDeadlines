import Foundation
import UIKit

protocol SetDeadlinesView: AnyObject {
}

class SetDeadlinesViewController: UIViewController, SetDeadlinesView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var presenter: SetDeadlinesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAppearance()
        nameLabel.text = presenter.name
    }
    
    func inject(presenter: SetDeadlinesPresenter!) {
        self.presenter = presenter
    }
}

extension SetDeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.task.total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SetDeadlinesCell.self)
        cell.lessonNumber.text = "\(presenter.task.total[indexPath.row].name)"
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
