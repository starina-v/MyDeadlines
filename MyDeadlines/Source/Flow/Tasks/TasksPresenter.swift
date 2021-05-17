//
//  TasksPresenter.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 11.05.2021.
//

import Foundation

protocol TasksPresenter {
    
    func addNewTask()
}

final class TasksPresenterImp {
    
    private weak var view: TasksView?
    private weak var flow: Flow?
    
    init(view: TasksView) {
        self.view = view
    }
    
    func inject(flow: Flow) {
        self.flow = flow
    }
}

//MARK: - TasksPresenter
extension TasksPresenterImp: TasksPresenter {
    
    func addNewTask() {
        flow?.navigate(to: .addNewTask)
    }
}
