![Cover](Images/GitHub%20Cover.jpg)

<br>

# 📰 Star News
`Xcode: 26.0+`

A clean archeticure modular iOS space news app built with SwiftUI and powered by Swift Concurrency. I developed it as a hands-on learning experience to solidify and apply the technical concepts I’ve been studying.

By combining a real-world use case with modern development practices, this app serves as both a portfolio project to showcase my technical skills and a personal milestone in my iOS development learning journey.

<br>

## 📱 Demo
Watch the demo video on [YouTube](https://youtu.be/2Aajrs0-h4U).

<br>

## 🖼️ Screenshots
| **Articles List** | **Article Details** | **Search Suggestions** | **Search Results** |
| ----------------- | ------------------- | ---------------------- | ------------------ |
| ![Articles List](Images/Articles%20List.png) | ![Article Details](Images/Article%20Details.png) | ![Search Suggestions](Images/Search%20Suggestions.png) | ![Search Results](Images/Search%20Results.png) |

<br>

## 🌟 Features
* Fetching and parsing data from a remote API
* Articles listing with pagination support
* Article details view with the ability to share the article link or open the article in Safari
* Displaying search suggestions
* Showing search results based on user input
* Caching network responses to reduce redundant API calls
* Handling various view states: loading, empty, error, and loaded
* Displaying a shimmering loading effect while data is being fetched

<br>

## 🧩 Diagrams
These diagrams where generated using 🤖 [Phind AI](https://www.phind.com).

#### 🔺 High-Level Diagram
![Modularization Diagram](https://github.com/user-attachments/assets/31b6513e-92d6-41e4-85a3-4eb1b7ebf009)

#### 🔻 Low-Level Diagram
![MVVM-C Clean Architecture Diagram](https://github.com/user-attachments/assets/9192f199-e1aa-4092-ac88-3d1b1267724d)

<br>

## 🗂️ Modules
* **`SNCache:`** Responsible for handling local data caching for minimizing repeated network requests.
* **`SNCore:`** Responsible for containing shared abstractions, protocols, and utilities used across multiple modules.
* **`SNDesignSystem:`** Responsible for providing shared assets, styles, and design constants.
* **`SNNetwork:`** Responsible for handling all networking operations, such as sending API requests, managing endpoints, and parsing responses.
* **`Shared:`** Responsible for hosting utilities, generic views, helpers, and common code that is used in multiple feature modules.
* **`Feature Modules:`** Each module represents a distinct feature in the app and follows a consistent structure based on Clean Architecture principles:
  * Divided into Data, Domain, and Presentation layers.
  * Implements the MVVM-C (Model-View-ViewModel-Coordinator) design pattern.
  * Built to be self-contained and modular for scalability and testability.
  * Includes unit testing across ViewModels, UseCases, Repositories, and Mappers.

<br>

## 📦 Dependencies
This project uses SPM (Swift Package Manager) as dependency manager.
* **[Kingfisher](https://github.com/onevcat/Kingfisher):** Responsible for downloading and caching images from the web

<br>

## ☁️ API
This project uses [Spaceflight News](https://api.spaceflightnewsapi.net/v4/docs/) REST API v4.

<br>

## 🛠️ Tech Stack
* Swift 6
* SwiftUI
* SPM (Swift Package Manager)
* Swift Concurrency
* Swift Testing
* Modularization
* Clean Architecture
* MVVM-C (Model-View-ViewModel-Coordinator) Design Pattern
* Factory Design Pattern
* UIKit-Based Coordinator Pattern
* Pagination
* NSCache
* OSLog
