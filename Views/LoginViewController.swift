import UIKit

final class LoginViewController:
    UIViewController {

    private let viewModel: LoginViewModel

    private let usernameTextField =
        UITextField()

    private let passwordTextField =
        UITextField()

    private let loginButton =
        UIButton(type: .system)

    private let activityIndicator =
        UIActivityIndicatorView(
            style: .medium
        )

    init(
        viewModel: LoginViewModel
    ) {

        self.viewModel = viewModel

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(
        coder: NSCoder
    ) {

        fatalError(
            "init(coder:) has not been implemented"
        )
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Login"

        setupUI()
        bindViewModel()
    }
}

extension LoginViewController {

    private func setupUI() {

        view.backgroundColor =
            .systemBackground

        usernameTextField.placeholder =
            "Username"

        usernameTextField.borderStyle =
            .roundedRect

        passwordTextField.placeholder =
            "Password"

        passwordTextField.borderStyle =
            .roundedRect

        passwordTextField.isSecureTextEntry =
            true

        loginButton.setTitle(
            "Login",
            for: .normal
        )

        loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )

        let stackView = UIStackView(
            arrangedSubviews: [
                usernameTextField,
                passwordTextField,
                loginButton,
                activityIndicator
            ]
        )

        stackView.axis = .vertical
        stackView.spacing = 16

        stackView.translatesAutoresizingMaskIntoConstraints =
            false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),

            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
    }
}

extension LoginViewController {

    @objc
    private func loginTapped() {

        Task {

            await viewModel.login(
                username:
                    usernameTextField.text ?? "",

                password:
                    passwordTextField.text ?? ""
            )
        }
    }

    private func bindViewModel() {

        viewModel.onStateChange = {
            [weak self] in

            guard let self else {
                return
            }

            switch self.viewModel.state {

            case .idle:
                break

            case .loading:
                self.activityIndicator
                    .startAnimating()

                self.loginButton
                    .isEnabled = false

            case .authenticated:
                self.activityIndicator
                    .stopAnimating()

                self.loginButton
                    .isEnabled = true

                self.showMessage(
                    "Login successful."
                )

            case .unauthenticated:
                self.activityIndicator
                    .stopAnimating()

                self.loginButton
                    .isEnabled = true

            case .error(let message):
                self.activityIndicator
                    .stopAnimating()

                self.loginButton
                    .isEnabled = true

                self.showMessage(message)
            }
        }
    }

    private func showMessage(
        _ message: String
    ) {

        let alert = UIAlertController(
            title: "Authentication",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(
            alert,
            animated: true
        )
    }
}
