import UIKit

final class TasksCell: UITableViewCell {
    

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tasksCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
}

extension TasksCell {
    
    func update(with task: TaskModel) {
        nameLabel.text = task.name
        tasksCount.text = "Total: \(task.labs.count + task.practical.count)"
    }
}

private extension TasksCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
