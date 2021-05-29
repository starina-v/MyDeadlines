import UIKit

final class CreateTaskCell: UITableViewCell {
    
    var callback : ((UIDatePicker) -> ())?
    
    @IBOutlet private weak var taskName: UILabel!
    @IBOutlet private weak var taskDeadline: UIDatePicker!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
}

extension CreateTaskCell {
    
    func update(with task: LessonModel) {
        taskName.text = task.name
        taskDeadline.date = task.deadline
    }
    
    @objc func datePickerChanged(sender: UIDatePicker) {
       callback?(sender)
    }
}

private extension CreateTaskCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
