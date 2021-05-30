import UIKit

final class TasksCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tasksCount: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
}

extension TasksCell {
    
    func update(with task: TaskModel) {
        nameLabel.text = task.name
        tasksCount.text = "total:  \(task.lessons.count)"
        getProgres(task: task)
    }
    
    func getProgres(task: TaskModel) {
        var finished: Int = 0
        let total = task.lessons.count
        for item in 0..<total {
            if task.lessons[item].isFinished == true {
                finished += 1
            }
        }
        var formula: Float = 0.0
        
        if finished == total {
            formula = 1.0
        } else {
            formula = (Float((100/total) * finished) / 100)
        }
        progressView.progress = formula
        setColor(progress: formula)
    }
    
    func setColor(progress: Float) {
        if progress <= 0.3 {
            progressView.progressTintColor = .red
        } else if progress <= 0.5 {
            progressView.progressTintColor = .orange
        } else if progress <= 0.8 {
            progressView.progressTintColor = .yellow
        } else if progress <= 1.0 {
            progressView.progressTintColor = .green
        }
    }
}

private extension TasksCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
