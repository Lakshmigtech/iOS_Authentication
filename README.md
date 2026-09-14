# iOS Authentication Showcase

A native iOS technical showcase demonstrating clean and secure authentication implementation using Swift.

## Technologies

* Swift
* UIKit
* MVVM
* URLSession
* Codable
* Async/Await
* Keychain
* Protocol-Oriented Programming
* Dependency Injection
* REST API
* XCTest

## Architecture

The project follows a simple layered architecture:

```text
ViewController
      ↓
ViewModel
      ↓
Authentication Service
      ↓
API Client
      ↓
URLSession
      ↓
REST API
```

Security-sensitive authentication data is handled separately using Keychain.

## Key Implementations

* Login API integration
* Token-based authentication
* Bearer token handling
* Secure token storage using Keychain
* Logout functionality
* Authentication state management
* Codable-based request and response models
* Async/Await networking
* Protocol-based service abstraction
* Dependency injection
* Centralized network error handling
* MVVM architecture
* Unit testing with mock services

## Authentication Flow

```text
User Login
    ↓
LoginViewController
    ↓
LoginViewModel
    ↓
AuthenticationService
    ↓
APIClient
    ↓
REST API
    ↓
Authentication Response
    ↓
Store Token in Keychain
```

## Security

The project demonstrates secure handling of authentication credentials and tokens.

* Authentication tokens are stored securely using Keychain.
* Sensitive information is not stored in UserDefaults.
* No production credentials or API keys are included.
* No client-specific or confidential information is included.
* Demo authentication data is used for showcase purposes.

## Error Handling

The authentication layer provides centralized handling for common API and networking errors, including:

* Invalid URL
* Invalid server response
* Unauthorized requests
* Server errors
* Decoding errors
* Network connectivity issues

## Testing

The authentication components are designed for testability using:

* Protocol-based dependencies
* Dependency injection
* Mock services
* XCTest

## Purpose

This project demonstrates practical iOS development practices for implementing a structured, maintainable, testable, and secure authentication flow.

The repository is created for technical showcase purposes and does not contain production or client-specific code.

## API

The sample implementation uses a demo REST API for authentication and does not contain any confidential credentials or client information.
