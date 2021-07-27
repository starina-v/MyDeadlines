import UIKit

final class TaskInfoCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var checkBox: UIButton!
    @IBOutlet private weak var shadowView: UIView!
    
    private var flag = false
    
    var callback : ((Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
    
    @IBAction func checkBoxButton(_ sender: UIButton) {
        setCheckBox()
    }
}

extension TaskInfoCell {
    
    func update(with task: LessonModel) {
        nameLabel.text = task.name
        dateLabel.text = formatDate(date: task.deadline)
        flag = task.isFinished
        setCheckBox()
    }
    
    func setCheckBox() {
        if flag {
            checkBox.setImage(UIImage(named: "check"), for: .normal)
            callback?(flag)
            flag = false
        } else {
            checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
            callback?(flag)
            flag = true
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = ("d MMMM")
        let date = formatter.string(from: date)
        return date
    }
}

private extension TaskInfoCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 1, height: 1)
        shadowView.layer.shadowRadius = 4
    }
}
