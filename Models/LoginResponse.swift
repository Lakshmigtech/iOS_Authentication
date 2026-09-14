import Foundation

struct LoginResponse: Decodable {

    let token: String
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case token
        case refreshToken
    }
}
