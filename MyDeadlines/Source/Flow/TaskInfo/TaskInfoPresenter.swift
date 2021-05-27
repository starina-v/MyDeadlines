import Foundation

protocol TaskInfoPresenter {
}

final class TaskInfoPresenterImp {
    
    private weak var view: TaskInfoView?
    private weak var flow: Flow?
    
    init(view: TaskInfoView, flow: Flow) {
        self.view = view
        self.flow = flow
    }
}

extension TaskInfoPresenterImp: TaskInfoPresenter {
}
