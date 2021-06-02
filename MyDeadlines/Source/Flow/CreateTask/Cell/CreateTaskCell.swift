import UIKit

final class CreateTaskCell: UITableViewCell {
    
    var callback : ((UIDatePicker) -> ())?
    
    @IBOutlet private weak var taskName: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
}

extension CreateTaskCell {
    
    func update(with task: LessonModel) {
        taskName.text = task.name
        datePicker.date = task.deadline
    }
    
    @objc func datePickerChanged(sender: UIDatePicker) {
        callback?(sender)
    }
}

private extension CreateTaskCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
        
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 1, height: 1)
        shadowView.layer.shadowRadius = 4
    }
}
