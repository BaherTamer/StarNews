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
| <img height="400" alt="Articles List" src="https://github.com/user-attachments/assets/72eff1f2-715d-4624-91c7-111a0a71f25b" /> | <img height="400" alt="Article Details" src="https://github.com/user-attachments/assets/510fc0a4-c1f7-47b5-88b3-f11d69da48a3" /> | <img height="400" alt="Search Suggestions" src="https://github.com/user-attachments/assets/12a0997c-349e-4dad-97b6-91bdacdee84a" /> | <img height="400" alt="Search Results" src="https://github.com/user-attachments/assets/a8f10169-16ba-49ee-b7c2-7fa844092c12" />

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
* Modularization
* Clean Architecture
* MVVM-C (Model-View-ViewModel-Coordinator) Design Pattern
* Factory Design Pattern
* UIKit-Based Coordinator Pattern
* Pagination
* NSCache
* OSLog
