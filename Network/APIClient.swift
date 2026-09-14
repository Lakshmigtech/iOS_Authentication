import Foundation

protocol APIClientProtocol {

    func request<T: Decodable>(
        _ endpoint: APIEndpoint,
        body: Encodable?
    ) async throws -> T
}

final class APIClient: APIClientProtocol {

    private let session: URLSession

    init(
        session: URLSession = .shared
    ) {
        self.session = session
    }

    func request<T: Decodable>(
        _ endpoint: APIEndpoint,
        body: Encodable? = nil
    ) async throws -> T {

        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        if let body {

            request.httpBody = try JSONEncoder().encode(
                AnyEncodable(body)
            )
        }

        do {

            let (data, response) = try await session.data(
                for: request
            )

            guard let httpResponse =
                    response as? HTTPURLResponse else {

                throw NetworkError.invalidResponse
            }

            switch httpResponse.statusCode {

            case 200...299:
                break

            case 401:
                throw NetworkError.unauthorized

            case 500...599:
                throw NetworkError.serverError(
                    httpResponse.statusCode
                )

            default:
                throw NetworkError.serverError(
                    httpResponse.statusCode
                )
            }

            do {

                return try JSONDecoder().decode(
                    T.self,
                    from: data
                )

            } catch {

                throw NetworkError.decodingError
            }

        } catch let error as NetworkError {

            throw error

        } catch let error as URLError {

            switch error.code {

            case .notConnectedToInternet,
                 .networkConnectionLost:

                throw NetworkError.noInternet

            default:

                throw NetworkError.requestFailed
            }

        } catch {

            throw NetworkError.unknown
        }
    }
}
