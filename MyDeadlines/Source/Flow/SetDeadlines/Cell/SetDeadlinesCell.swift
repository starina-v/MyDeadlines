import UIKit

class SetDeadlinesCell: UITableViewCell {
    
    @IBOutlet weak var lessonNumber: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
}

// MARK: - Update
extension SetDeadlinesCell {
}

// MARK: - Private
private extension SetDeadlinesCell {
    
    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
