
import Foundation
import RxSwift

protocol MainPresenter {
    
    var posts: [Post] { get }
    
    func didSelectRowAt(indexPath: IndexPath)
}

final class MainPresenterImp {
    
    var posts: [Post] = []
    
    private let apiClient: ApiClient
    private let disposeBag = DisposeBag()

    private weak var view: MainView?

    init(view: MainView, apiClient: ApiClient) {
        self.view = view
        self.apiClient = apiClient
        
        getPosts()
    }
    
    func getPosts() {
        apiClient
            .request(PostsApi.get)
            .subscribe(
                onSuccess: { [weak self] (response: PostsResponse) in
                    self?.posts = response.posts
                        .filter({ !$0.link.contains("/ru/")})
                        .filter({ !$0.link.contains("/en/")})
                        .map({
                            let date = $0.date.replacingOccurrences(of: "T", with: " ")

                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "MM.dd.yyyy"

                            let finalDate: String

                            if let formattedDate = dateFormatterGet.date(from: date) {
                                finalDate = dateFormatterPrint.string(from: formattedDate)
                            } else {
                                finalDate = ""
                            }

                            return .init(
                                id: $0.id,
                                date: finalDate,
                                link: $0.link,
                                title: $0.title)
                        })
                    self?.view?.update()
                },
                onError: {
                    print($0)
                })
                .disposed(by: disposeBag)
    }
}

//MARK: - MainPresenter
extension MainPresenterImp: MainPresenter {
    
    func didSelectRowAt(indexPath: IndexPath) {
        posts[indexPath.row].link
    }
}
