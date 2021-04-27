import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
        
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
    }
}

// MARK: - Private

private extension PostTableViewCell {

    func setupViewAppearance() {
        selectedBackgroundView = UIView()
    }
}
