//
//  AddNewTaskPresenter.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 11.05.2021.
//

import Foundation

protocol AddNewTaskPresenter {
    var tasks: [TaskModel] { get }
    func save(name: String)
}

final class AddNewTaskPresenterImp {
    
    var tasks: [TaskModel] = []
    
    private weak var view: AddNewTaskView?
    
    init(view: AddNewTaskView) {
        self.view = view
    }
    
    func save(name: String) {
        print(name)
    }
}

//MARK: - TasksPresenter
extension AddNewTaskPresenterImp: AddNewTaskPresenter {
}
