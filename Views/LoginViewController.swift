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
