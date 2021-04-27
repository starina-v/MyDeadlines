
import Foundation
import RxSwift

protocol MainPresenter {
    
    var posts: [Post] { get }
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
                onSuccess: { (response: PostsResponse) in
                    self.posts = response.posts
                    self.view?.update()
                },
                onError: {
                    print($0)
                })
                .disposed(by: disposeBag)
    }
}

//MARK: - MainPresenter
extension MainPresenterImp: MainPresenter {
    
}
