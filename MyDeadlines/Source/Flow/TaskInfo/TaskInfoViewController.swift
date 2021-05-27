import Foundation
import UIKit

protocol TaskInfoView: AnyObject {
}

final class TaskInfoViewController: UIViewController {
    
    private var presenter: TaskInfoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: TaskInfoPresenter!) {
        self.presenter = presenter
    }
}

extension TaskInfoViewController: TaskInfoView {
}

private extension CreateTaskViewController {
}
