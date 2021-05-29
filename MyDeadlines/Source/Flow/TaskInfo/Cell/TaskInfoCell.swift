import UIKit

final class TaskInfoCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
    
    @IBAction func checkBox(_ sender: Any) {
    }
}

extension TaskInfoCell {
    
    func update(with task: LessonModel) {
        nameLabel.text = task.name
        dateLabel.text = "\(task.deadline)"
    }
}

private extension TaskInfoCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
