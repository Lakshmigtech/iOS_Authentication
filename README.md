# iOS_Authentication

Native iOS authentication showcase using Swift, MVVM, URLSession, Keychain, and token-based authentication.

## Technologies

- Swift
- UIKit
- MVVM
- URLSession
- Codable
- Async/Await
- Keychain
- Protocol-Oriented Programming
- Dependency Injection
- REST API
- XCTest

## Architecture

The project follows a simple layered architecture:

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

Security-sensitive data is handled separately using Keychain.

## Key Implementations

- Login API integration
- Token-based authentication
- Bearer token handling
- Secure token storage using Keychain
- Logout functionality
- Authentication state management
- Codable request and response models
- Async/Await networking
- Protocol-based service abstraction
- Dependency injection
- Centralized network error handling
- MVVM architecture
- Unit testing with mock services

## Authentication Flow

1. User enters username and password.
2. Login request is sent to the authentication API.
3. Server validates the credentials.
4. Authentication token is returned.
5. Token is securely stored in Keychain.
6. Token can be used for authenticated API requests.
7. Logout removes the stored authentication token.

## Project Structure

```text
ios-authentication-showcase
│
├── README.md
├── .gitignore
│
├── Models/
│   ├── LoginRequest.swift
│   ├── LoginResponse.swift
│   └── User.swift
│
├── Network/
│   ├── APIClient.swift
│   ├── APIEndpoint.swift
│   └── NetworkError.swift
│
├── Services/
│   ├── AuthenticationService.swift
│   └── AuthenticationServiceProtocol.swift
│
├── Security/
│   └── KeychainManager.swift
│
├── ViewModels/
│   ├── LoginViewModel.swift
│   └── AuthenticationState.swift
│
├── Views/
│   └── LoginViewController.swift
│
└── Tests/
    └── LoginViewModelTests.swift
