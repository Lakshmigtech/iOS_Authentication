import Foundation

enum NetworkError: LocalizedError {

    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(Int)
    case decodingError
    case noInternet
    case requestFailed
    case unknown

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "The URL is invalid."

        case .invalidResponse:
            return "The server returned an invalid response."

        case .unauthorized:
            return "Authentication failed. Please check your credentials."

        case .serverError(let statusCode):
            return "Server error. Status code: \(statusCode)"

        case .decodingError:
            return "Unable to process the server response."

        case .noInternet:
            return "Please check your internet connection."

        case .requestFailed:
            return "The request could not be completed."

        case .unknown:
            return "Something went wrong."
        }
    }
}
