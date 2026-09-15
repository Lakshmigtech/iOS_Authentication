import Foundation

final class MockAuthenticationService:
    AuthenticationServiceProtocol {

    var shouldFail = false

    func login(
        username: String,
        password: String
    ) async throws -> LoginResponse {

        if shouldFail {
            throw NetworkError.unauthorized
        }

        return LoginResponse(
            token: "demo-access-token",
            refreshToken: "demo-refresh-token"
        )
    }

    func logout() {
        // Mock logout
    }
}
