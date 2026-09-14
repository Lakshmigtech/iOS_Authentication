import Foundation

@MainActor
final class LoginViewModel {

    private let authenticationService:
        AuthenticationServiceProtocol

    private(set) var state:
        AuthenticationState = .idle

    var onStateChange:
        (() -> Void)?

    init(
        authenticationService:
        AuthenticationServiceProtocol
    ) {

        self.authenticationService =
            authenticationService
    }

    func login(
        username: String,
        password: String
    ) async {

        guard !username.isEmpty,
              !password.isEmpty else {

            state = .error(
                "Username and password are required."
            )

            onStateChange?()

            return
        }

        state = .loading
        onStateChange?()

        do {

            _ = try await authenticationService.login(
                username: username,
                password: password
            )

            state = .authenticated
            onStateChange?()

        } catch {

            state = .error(
                error.localizedDescription
            )

            onStateChange?()
        }
    }

    func logout() {

        authenticationService.logout()

        state = .unauthenticated
        onStateChange?()
    }
}
