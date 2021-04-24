//
//  ViewController.swift
//  MyDeadlines
//
//  Created by Vlad Starina on 24.04.2021.
//

import UIKit

protocol MainView: class {

}

class MainViewController: UIViewController {

    private var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: MainPresenter!) {
        self.presenter = presenter
    }
}

//MARK: - MainView
extension MainViewController: MainView {
    
}
