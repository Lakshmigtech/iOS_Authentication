import Foundation
import Security

protocol KeychainManaging {

    func save(
        value: String,
        forKey key: String
    ) -> Bool

    func getValue(
        forKey key: String
    ) -> String?

    func deleteValue(
        forKey key: String
    ) -> Bool
}

final class KeychainManager: KeychainManaging {

    func save(
        value: String,
        forKey key: String
    ) -> Bool {

        guard let data = value.data(
            using: .utf8
        ) else {
            return false
        }

        let query: [String: Any] = [

            kSecClass as String:
                kSecClassGenericPassword,

            kSecAttrAccount as String:
                key,

            kSecValueData as String:
                data
        ]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )

        return status == errSecSuccess
    }

    func getValue(
        forKey key: String
    ) -> String? {

        let query: [String: Any] = [

            kSecClass as String:
                kSecClassGenericPassword,

            kSecAttrAccount as String:
                key,

            kSecReturnData as String:
                true,

            kSecMatchLimit as String:
                kSecMatchLimitOne
        ]

        var result: AnyObject?

        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )

        guard status == errSecSuccess,
              let data = result as? Data else {

            return nil
        }

        return String(
            data: data,
            encoding: .utf8
        )
    }

    func deleteValue(
        forKey key: String
    ) -> Bool {

        let query: [String: Any] = [

            kSecClass as String:
                kSecClassGenericPassword,

            kSecAttrAccount as String:
                key
        ]

        let status = SecItemDelete(
            query as CFDictionary
        )

        return status == errSecSuccess ||
               status == errSecItemNotFound
    }
}
