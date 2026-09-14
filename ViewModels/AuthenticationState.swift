import Foundation

enum AuthenticationState {

    case idle
    case loading
    case authenticated
    case unauthenticated
    case error(String)
}
