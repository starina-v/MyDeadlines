//
//  TasksPresenter.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 11.05.2021.
//

import Foundation

protocol TasksPresenter {
}

final class TasksPresenterImp {
    
    private weak var view: TasksView?
    
    init(view: TasksView) {
        self.view = view
    }
}

//MARK: - TasksPresenter
extension TasksPresenterImp: TasksPresenter {
}
