//
//  MainPresenter.swift
//  MyDeadlines
//
//  Created by Vlad Starina on 24.04.2021.
//

import Foundation

protocol MainPresenter {
    
}

final class MainPresenterImp {
    
    private weak var view: MainView?
    
    init(view: MainView) {
        self.view = view
    }
}

//MARK: - MainPresenter
extension MainPresenterImp: MainPresenter {
    
}
