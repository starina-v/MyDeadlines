import UIKit
import SwifterSwift

protocol NewsView: AnyObject {

    func update()
}

final class NewsViewController: UIViewController {

    private var presenter: NewsPresenter!

    @IBOutlet private weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
    }
    
    func inject(presenter: NewsPresenter) {
        self.presenter = presenter
    }
}

// MARK: - NewsView

extension NewsViewController: NewsView {
    
    func update() {
        tableView?.reloadData()
    }
}

// MARK: - MainView

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {

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

private extension NewsViewController {
    
    func setupViewAppearance() {
        title = "News"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(nibWithCellClass: PostTableViewCell.self)
        tableView.separatorStyle = .none
        
        let switchButton = UIBarButtonItem(
            image: UIImage(systemName: "info.circle.fill"),
            style: .done,
            target: self,
            action: #selector(infoTapped))
        navigationItem.rightBarButtonItem = switchButton

    }
}

// MARK: - Actions

extension NewsViewController {

    @objc func infoTapped(sender: UIBarButtonItem) {
        presenter.infoTapped()
    }
}
