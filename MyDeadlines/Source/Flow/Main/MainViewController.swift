import UIKit
import SwifterSwift

protocol MainView: AnyObject {

    func update()
}

class MainViewController: UIViewController {

    private var presenter: MainPresenter!

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
    }
    
    func inject(presenter: MainPresenter) {
        self.presenter = presenter
    }
}

// MARK: - MainView

extension MainViewController: MainView {
    
    func update() {
        tableView?.tableFooterView?.isHidden = true
        tableView?.reloadData()
    }
}

// MARK: - MainView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: PostTableViewCell.self)
        cell.update(with: presenter.posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}

// MARK: - private

private extension MainViewController {
    
    func setupViewAppearance() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(nibWithCellClass: PostTableViewCell.self)
        tableView.separatorStyle = .none
        
        setupTableViewActivityIndicator()
        
        title = "News"
    }
    
    func setupTableViewActivityIndicator() {
        guard let width = tableView?.bounds.width else { return }

        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(0),
            width: width,
            height: CGFloat(44))

        self.tableView?.tableFooterView = spinner
    }
}
