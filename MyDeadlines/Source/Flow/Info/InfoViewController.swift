import UIKit

protocol InfoView: AnyObject {

    func update()
}

final class InfoViewController: UIViewController {

    private var presenter: InfoPresenter!

    @IBOutlet private weak var shadowView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
    }
    
    func inject(presenter: InfoPresenter) {
        self.presenter = presenter
    }
}

// MARK: - InfoView

extension InfoViewController: InfoView {
    
    func update() {
    }
}

// MARK: - private

private extension InfoViewController {
    
    func setupViewAppearance() {
        title = "Info"
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 1, height: 1)
        shadowView.layer.shadowRadius = 4
    }
}

// MARK: - Actions

extension InfoViewController {

    @IBAction func apotTapped(_ sender: Any) {
        presenter.apotLink()
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        presenter.facebookLink()
    }
    
    @IBAction func telegramTapped(_ sender: Any) {
        presenter.telegramLink()
    }
}
