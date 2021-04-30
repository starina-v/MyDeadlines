//
//  SetDeadlinesViewController.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 30.04.2021.
//

import Foundation
import UIKit


protocol SetDeadlinesView: class {
}

class SetDeadlinesViewController: UIViewController, SetDeadlinesView {
    
    private var presenter: SetDeadlinesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: SetDeadlinesPresenter!) {
        self.presenter = presenter
    }
    
}

