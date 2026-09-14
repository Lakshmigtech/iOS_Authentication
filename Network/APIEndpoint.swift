import Foundation

enum APIEndpoint {

    case login

    private var baseURL: String {
        "https://example.com/api"
    }

    var url: URL? {

        switch self {

        case .login:
            return URL(
                string: "\(baseURL)/login"
            )
        }
    }

    var method: HTTPMethod {

        switch self {

        case .login:
            return .post
        }
    }
}

enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
