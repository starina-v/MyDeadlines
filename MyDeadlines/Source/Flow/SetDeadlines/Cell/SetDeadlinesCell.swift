import UIKit

final class SetDeadlinesCell: UITableViewCell {
    
    @IBOutlet private weak var lessonNumber: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
}

// MARK: - Update
extension SetDeadlinesCell {
    func update(with task: LessonModel) {
        lessonNumber.text = task.name
    }
}

// MARK: - Private
private extension SetDeadlinesCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
