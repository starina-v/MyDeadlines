import UIKit

final class TasksCell: UITableViewCell {
    

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tasksCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
}

extension TasksCell {
    
    func update(with task: TaskModel) {
        nameLabel.text = task.name
        tasksCount.text = "total: \(task.labs.count + task.practical.count)"
    }
}

private extension TasksCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
