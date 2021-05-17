//
//  AddNewTaskViewController.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 11.05.2021.
//

import Foundation
import UIKit


protocol AddNewTaskView: class {
}

class AddNewTaskViewController: UIViewController, AddNewTaskView {
    
    @IBOutlet weak var nameField: UITextField!
    
    private var presenter: AddNewTaskPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: AddNewTaskPresenter!) {
        self.presenter = presenter
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        getName()
    }
    
    func getName() {
        guard let name = nameField.text else { return }
        presenter.save(name: name)
    }
}

