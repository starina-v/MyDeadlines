import Foundation
import Moya

struct Post: Codable {
    let id: Int
    let date: String
    let link: String
    let title: Title
}

struct Title: Codable {
    let rendered: String
}
// MARK: - Responses

struct PostsResponse: Codable {
    let posts: [Post]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        posts = try container.decode([Post].self)
    }
    
    init(posts: [Post]) {
        self.posts = posts
    }
}

enum PostsApi {
    case get
}

// MARK: - TargetType
extension PostsApi: TargetType {

    var baseURL: URL {
        guard let baseURL = URL(string: "http://\(ApiDomain.api.rawValue)/") else {
            fatalError("Failed to build base url")
        }

        return baseURL
    }

    var path: String {
        switch self {
        case .get:
            return "posts"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .get:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        .successCodes
    }

    var headers: [String: String]? {
        [:]
    }
}

// MARK: - TargetTypeExtension
extension PostsApi: TargetTypeExtension {

    var sampleApiResult: Encodable {
        switch self {
        case .get:
            return PostsResponse(posts: [])
        }
    }
}

// MARK: - AccessTokenAuthorizable
extension PostsApi: AccessTokenAuthorizable {

    var authorizationType: AuthorizationType? {
        .none
    }
}
