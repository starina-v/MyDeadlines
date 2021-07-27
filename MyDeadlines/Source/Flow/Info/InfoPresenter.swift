import Foundation

protocol InfoPresenter {

    func apotLink()
    
    func facebookLink()
    
    func telegramLink()
}

final class InfoPresenterImp {
    
    private weak var flow: Flow?
    private weak var view: InfoView?

    init(view: InfoView, flow: Flow) {
        self.view = view
        self.flow = flow
    }
}

//MARK: - InfoPresenter
extension InfoPresenterImp: InfoPresenter {
    
    func apotLink() {
        flow?.navigate(to: .safari("http://ad.nure.ua/ru/"))
    }
    
    func facebookLink() {
        flow?.navigate(to: .safari("https://www.facebook.com/nure.apvt/"))
    }
    
    func telegramLink() {
        flow?.navigate(to: .safari("https://t.me/apvt_nure"))
    }
}
