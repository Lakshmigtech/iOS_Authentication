import Foundation

protocol AuthenticationServiceProtocol {

    func login(
        username: String,
        password: String
    ) async throws -> LoginResponse

    func logout()
}
