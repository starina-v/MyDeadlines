import Foundation
import Alamofire
import Moya
import Rswift

enum ApiDomain: String {

    case api = "ad.nure.ua/wp-json/wp/v2"
}

struct ApiResponse<Data: Codable>: Codable {
    let data: [Data]
}

struct ApiErrorResponse: Decodable {
    let errors: [ApiCustomError]
}

struct ApiCustomError: Decodable {
    let message: String

    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct ApiValidationErrorResponse: Decodable {
    let errors: [String: [String]]
}

struct EmptyApiResult: Codable {}

enum ApiClientError: LocalizedError {

    case cancelled
    case timedOut
    case unauthorized
    case offline
    case serverDoesntRespond
    case custom(statusCode: Int, error: ApiCustomError?)
    case validation(message: String)
    case underlying(error: Error)

    init(error: Error) {
        self = ApiClientError(errorToHandle: error) ?? .underlying(error: error)
    }

    private init?(errorToHandle: Error) {
        guard
            let moyaError = errorToHandle as? MoyaError,
            case let .underlying(error as AFError, response) = moyaError else {
                return nil
        }

        switch error {
        case let .responseValidationFailed(reason):
            guard
                case let .unacceptableStatusCode(statusCode) = reason,
                let statusError = ApiClientError(statusCode: statusCode, response: response) else {
                    return nil
            }
            self = statusError
        case let .sessionTaskFailed(nsError as NSError):
            switch nsError.code {
            case -999:
                self = .cancelled
            case -1_001:
                self = .timedOut
            case -1_009:
                self = .offline
            default:
                return nil
            }
        default:
            return nil
        }
    }

    private init?(statusCode: Int, response: Response?) {
        guard let response = response else {
            return nil
        }

        switch statusCode {
        case 401:
            self = .unauthorized
        case 500:
            self = .serverDoesntRespond
        default:
            let apiCustomErrors = try? ApiErrorResponse.decode(from: response.data)
            self = .custom(statusCode: statusCode, error: apiCustomErrors?.errors.first)
        }
    }

    var errorDescription: String? {
        switch self {
        case .custom(let statusCode, let error):
            guard let error = error else {
                return "\(statusCode) error"
            }
            return error.message

        case .validation(let message):
            return message
        case .underlying(let error):
            return error.localizedDescription
        default:
            return self.localizedDescription
        }
    }
}
