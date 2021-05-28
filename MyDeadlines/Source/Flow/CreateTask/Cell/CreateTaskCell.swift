import UIKit

final class CreateTaskCell: UITableViewCell {
    
    @IBOutlet private weak var taskName: UILabel!
    @IBOutlet private weak var taskDeadline: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
}

extension CreateTaskCell {
    
    func update(with task: LessonModel) {
        taskName.text = task.name
    }
}

private extension CreateTaskCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
