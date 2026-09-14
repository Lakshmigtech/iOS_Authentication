import Foundation

final class AuthenticationService:
    AuthenticationServiceProtocol {

    private let apiClient: APIClientProtocol
    private let keychain: KeychainManaging

    private let accessTokenKey =
        "access_token"

    private let refreshTokenKey =
        "refresh_token"

    init(
        apiClient: APIClientProtocol,
        keychain: KeychainManaging
    ) {

        self.apiClient = apiClient
        self.keychain = keychain
    }

    func login(
        username: String,
        password: String
    ) async throws -> LoginResponse {

        let request = LoginRequest(
            username: username,
            password: password
        )

        let response: LoginResponse =
            try await apiClient.request(
                .login,
                body: request
            )

        _ = keychain.save(
            value: response.token,
            forKey: accessTokenKey
        )

        if let refreshToken = response.refreshToken {

            _ = keychain.save(
                value: refreshToken,
                forKey: refreshTokenKey
            )
        }

        return response
    }

    func logout() {

        _ = keychain.deleteValue(
            forKey: accessTokenKey
        )

        _ = keychain.deleteValue(
            forKey: refreshTokenKey
        )
    }
}
