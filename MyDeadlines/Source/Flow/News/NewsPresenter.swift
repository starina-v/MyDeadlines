
import Foundation
import RxSwift

protocol NewsPresenter {

    var posts: [Post] { get }
    
    var isLoading: Bool { get }

    func didSelectRowAt(indexPath: IndexPath)
    
    func infoTapped()
}

final class NewsPresenterImp {
    
    struct State {
        var posts: [Post]
        var isLoading: Bool
    }
        
    var state: State
    
    private let apiClient: ApiClient
    private let disposeBag = DisposeBag()

    private weak var flow: Flow?
    private weak var view: NewsView?

    init(view: NewsView, flow: Flow, apiClient: ApiClient) {
        self.view = view
        self.flow = flow
        self.apiClient = apiClient
        
        state = .init(posts: [], isLoading: true)

        getPosts()
    }
    
    func getPosts() {
        apiClient
            .request(PostsApi.get)
            .subscribe(
                onSuccess: { [weak self] (response: PostsResponse) in
                    self?.state.posts = response.posts
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
                    self?.state.isLoading = false
                    self?.view?.update()
                },
                onError: { [weak self] in
                    self?.state.isLoading = false
                    self?.view?.update()
                    print($0)
                })
                .disposed(by: disposeBag)
    }
}

//MARK: - NewsPresenter
extension NewsPresenterImp: NewsPresenter {
    
    var posts: [Post] {
        state.posts
    }
    
    var isLoading: Bool {
        state.isLoading
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        flow?.navigate(to: .safari(state.posts[indexPath.row].link))
    }
    
    func infoTapped() {
        flow?.navigate(to: .info)
    }
}
