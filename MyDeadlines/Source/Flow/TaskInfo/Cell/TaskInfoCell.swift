import UIKit

final class TaskInfoCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
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
    }
}
