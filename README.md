<img src="https://raw.githubusercontent.com/jarrodparkes/images/master/banjo.png?raw=true" alt="Banjo" align="left" height="64">

# Banjo

![Platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)

Banjo is a searchable [Nintendo 64 (N64)](https://en.wikipedia.org/wiki/Nintendo_64) game index.

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

The app begins here. Tap the middle button to begin searching.

### 2. Game Search View

In this view, you can search the library of N64 games by title. Tapping a row (name of a game) will transition you to its detail view.

### 3. Game Detail View

This view displays details for a N64 game. For any game, the following information is shown if it is present in IGDB's database:

- box cover art
- release title
- genres
- game mode (single, cooperative, multiplayer, split screen, massive multiplayer online)
- developers
- publishers
- rating (ex. [ESRB](http://www.esrb.org))
- summary

## Dependencies

See `Podfile`.

## Credits

- Diep Nguyen Hoang
  - [`UICollectionViewFlowLayout` “tag flow” layout](https://github.com/luceefer/TagFlowExample)
- Arshad Chummun
  - [`UIColor` from hex string example](https://gist.github.com/arshad/de147c42d7b3063ef7bc)
