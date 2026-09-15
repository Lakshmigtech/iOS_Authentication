import XCTest

@testable import AuthenticationShowcase

final class LoginViewModelTests:
    XCTestCase {

    func testLoginSuccess() async {

        let service =
            MockAuthenticationService()

        let viewModel =
            await MainActor.run {

                LoginViewModel(
                    authenticationService:
                        service
                )
            }

        await viewModel.login(
            username: "demo",
            password: "password"
        )

        let state = await MainActor.run {
            viewModel.state
        }

        switch state {

        case .authenticated:
            XCTAssertTrue(true)

        default:
            XCTFail(
                "Expected authenticated state"
            )
        }
    }

    func testEmptyCredentials() async {

        let service =
            MockAuthenticationService()

        let viewModel =
            await MainActor.run {

                LoginViewModel(
                    authenticationService:
                        service
                )
            }

        await viewModel.login(
            username: "",
            password: ""
        )

        let state = await MainActor.run {
            viewModel.state
        }

        switch state {

        case .error(let message):

            XCTAssertEqual(
                message,
                "Username and password are required."
            )

        default:

            XCTFail(
                "Expected validation error"
            )
        }
    }
}
