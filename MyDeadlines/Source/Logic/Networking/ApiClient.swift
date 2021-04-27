import Foundation
import Alamofire
import Moya
import RxSwift

protocol ApiProvider {

    func request(_ token: TargetType) -> Single<Moya.Response>
}

extension MoyaProvider: ApiProvider where Target == MultiTarget {

    func request(_ token: TargetType) -> Single<Response> {
        rx.request(MultiTarget(token))
    }
}

protocol ApiClient {

    func request<Response: Codable>(_ token: TargetType) -> Single<Response>
}

final class ApiClientImp {

    private let provider: ApiProvider

    init(provider: ApiProvider) {
        self.provider = provider
    }
}

// MARK: ApiClient
extension ApiClientImp: ApiClient {

    func request<Response: Codable>(_ token: TargetType) -> Single<Response> {
        provider.request(token)
            .map(Response.self, using: defaultJsonDecoder)
            .catchError { error in
                throw ApiClientError(error: error)
            }
    }
}
