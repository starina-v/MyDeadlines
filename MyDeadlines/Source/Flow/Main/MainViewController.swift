//
//  ViewController.swift
//  MyDeadlines
//
//  Created by Vlad Starina on 24.04.2021.
//

import UIKit
import SwifterSwift
import SafariServices

protocol MainView: class {

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
        tableView.reloadData()
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
        let post = presenter.posts[indexPath.row]
        if let url = URL(string: post.link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = false
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

// MARK: - private

private extension MainViewController {
    
    func setupViewAppearance() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(nibWithCellClass: PostTableViewCell.self)
    }
}
