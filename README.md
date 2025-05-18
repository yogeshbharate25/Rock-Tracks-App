# 🎸 Rock Track App

Rock Track is a SwiftUI-based iOS application that fetches and displays a list of rock music tracks. Users can browse through the tracks, view detailed information, and open the iTunes link for more details.

---

## 📱 Features

* List of rock tracks fetched from iTunes API
* Detailed view for individual tracks
* Opens track in Safari for more details
* Modern SwiftUI interface
* Clean architecture with testable layers
* UI and unit test friendly

---

## 🫟 App Flow Overview

![App Flow Diagram](./RockTrack-FlowDiagram.png)

---

## 🧱 Architecture

The Rock Track app follows MVVM + Clean Service Layer with dependency injection protocols to ensure loose coupling and easy testing.

### 1. **Entry Point**

* `Rock_TrackApp`: The `@main` struct launching the initial view.

### 2. **RockTrackListView**

* Displays a list of fetched rock tracks.
* On tapping a track, navigates to `RockTrackDetailView`.

### 3. **RockTrackListViewModel**

* Responsible for fetching and managing rock track data.
* Depends on `APIServiceProviding` (i.e., `RockTracksService`).

### 4. **RockTracksService**

* A service class conforming to `APIServiceProviding`.
* Handles interaction with `NetworkManager` and parsing with `ResponseParser`.

### 5. **NetworkManager**

* Generic network layer conforming to `NetworkProviding`.
* Handles actual URLSession data tasks.

### 6. **ResponseParser**

* Responsible for parsing and decoding response data.

### 7. **RockTrackDetailView**

* Displays track image, name, artist, price, duration, and release date.
* Includes a "More details" button to open iTunes in Safari.

### 8. **RockTrackDetailViewModel**

* Handles logic specific to the detailed track view.

---

## 🧚‍♂️ Testing

### Unit Tests

* Mock `NetworkProviding`, `APIServiceProviding`, and `ResponseParserProviding` protocols.
* Test ViewModels in isolation with dependency injection.

### UI Tests

* `AppHelper.isUITestCases` flag helps toggle mock images and test-friendly states.
* UI tests can assert view content and button actions.

---

## 🚀 Getting Started

### Requirements

* iOS 15.0+
* Xcode 14+

### Installation

1. Clone the repo:

   ```bash
   git clone https://github.com/yourusername/RockTrackApp.git
   cd RockTrackApp
   ```

2. Open in Xcode:

   ```bash
   open RockTrackApp.xcodeproj
   ```

3. Run the app on a simulator or device.

---

## 📂 Project Structure

```
Rock Tracks
├── Rock_TracksApp.swift
├── Helpers
│   ├── AppHelper.swift
│   └── ResponseParser.swift
├── Models
│   └── RockTrackResponse.swift
├── Network
│   └── NetworkManager.swift
├── Services
│   └── RockTracksService.swift
├── ViewModels
│   ├── RockTrackListViewModel.swift
│   └── RockTrackDetailViewModel.swift
├── Views
│   ├── RockTrackListView.swift
│   └── RockTrackDetailView.swift
├── Resources
├── Others
├── Rock TracksTests
│   ├── Arrange
│   │   ├── RockTrackResponse.swift
│   │   └── RockTrackResponse+Arrange.swift
│   ├── Mocks
│   │   ├── MockNetworkManager.swift
│   │   ├── MockRockTracksService.swift
│   ├── RockTrackDetailViewModelTests.swift
│   ├── RockTrackListViewModelTests.swift
│   └── RockTracksServiceTests.swift
├── Rock TracksUITests
│   ├── BaseUITests.swift
│   ├── RockTrackDetailViewUITests.swift
│   └── RockTrackListViewUITests.swift
```

---

## 🧑‍💻 Author

**Yogesh Bharate**

---


