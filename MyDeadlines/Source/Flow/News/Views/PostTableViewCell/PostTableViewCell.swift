import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewAppearance()
    }
}

// MARK: - Update

extension PostTableViewCell {
    
    func update(with post: Post) {
        titleLabel.text = post.title.rendered
        dateLabel.text = post.date
        
        setupViewAppearance()
    }
}

// MARK: - Private

private extension PostTableViewCell {

    func setupViewAppearance() {
        selectedBackgroundView = UIView()
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 1, height: 1)
        shadowView.layer.shadowRadius = 4
    }
}
