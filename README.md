<img src="https://raw.githubusercontent.com/jarrodparkes/images/master/banjo.png?raw=true" alt="Banjo" align="left" height="64">

# Banjo

![Platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)

Banjo is a searchable [Nintendo 64 (N64)](https://en.wikipedia.org/wiki/Nintendo_64) game index. Find every title for the N64 console and view its releases across different regions like Japan, Europe, and Australia.

## Setup

To build and run Banjo, you need to install its dependencies using Cocoapods. Run the following command in the project’s root directory:

```
pod install
```

This command will create a `Banjo.xcworkspace` file (similar to a regular Xcode project) containing the Banjo-specific source files and its additional dependencies. Open `Banjo.xcworkspace` in Xcode and run the project!

## User Experience

![Banjo Storyboard](https://raw.githubusercontent.com/jarrodparkes/images/master/banjo-screens-numbered.png)

Banjo is split into 4 major views:

### 1. Start View

The app begins here. On load, Banjo will sync and initialize the N64 game database so that you can use the application. If the sync is successful, then you can continue forward to the next view by tapping the “Search N64 Database…” button.

### 2. Game Search View

In this view, you can search the library of N64 games by title. Tapping one of the rows (a game) will transition you to its detail view.

### 3. Game Detail View

This view displays details for a N64 game. By default, the information shown will be for the game’s US release or first release by date, but by tapping on the region code in the upper right-hand corner, you can select other releases of the same game — assuming it had multiple releases.

For any release, the following information is shown if it is present in the database:

- box cover art
- release title
- genres
- number of players supported
- developer
- publisher
- rating (ex. [ESRB](http://www.esrb.org))
- summary

### 4. Release Selection View

Certain N64 games were released multiple times in different regions or with special designations like “Player’s Choice” or “Collector’s Edition”. On this view, you can select between a game’s releases and be automatically re-directed to the **Game Detail View** to see its corresponding information.

## Dependencies

- [Realm](https://realm.io)
- [Firebase](https://firebase.google.com)

## Credits

- Diep Nguyen Hoang 
  - [`UICollectionViewFlowLayout` “tag flow” layout](https://github.com/luceefer/TagFlowExample)
- Geppy Parziale
  - [Swift 3 reachability example](http://www.invasivecode.com/weblog/network-reachability-in-swift)
- Adam Fish
  - [Swift 2 Realm search controller](https://github.com/bigfish24/ABFRealmSearchViewController)
- Arshad Chummun
  - [`UIColor` from hex string example](https://gist.github.com/arshad/de147c42d7b3063ef7bc)
