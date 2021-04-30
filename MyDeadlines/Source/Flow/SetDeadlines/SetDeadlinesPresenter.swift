//
//  SetDeadlinesPresenter.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 30.04.2021.
//

import Foundation

protocol SetDeadlinesPresenter {
}

final class SetDeadlinesPresenterImp {
    
    private weak var view: SetDeadlinesView?
    
    init(view: SetDeadlinesView) {
        self.view = view
    }
}

//MARK: - SetDeadlinesPresenter
extension SetDeadlinesPresenterImp: SetDeadlinesPresenter {
}
