# WzSayEz

## Inspiration
Many a time, many Singaporeans, just like us, do feel the urge to recycle and help the environment out. With so much help given to conventional recycling ways, recycling of **electronics** are often left out, or unknown to many.

## What it does
The WzSayEz app aims to provide Singaporeans greater flexibility in recycling their items, with a map of **all** e-recycling bins integrated into it. Users are able to send in their photos/pictures to be stored in our database, and be awarded points when they are approved by the system administrators.

## How we built it
Using Flutter, which is a cross-platform app development tool, we built the app with dart as the main programming language used.

## Challenges we ran into
Incomplete/ missing data from API Requests.
Problems with CSV format.
Reducing the loading time for markers to be drawn on the map.

## Accomplishments that we're proud of
Reducing the loading time for markers to be shown on the map, from over a minute to instantaneously, but precomputing the data once beforehand.
## What we learned

Reducing lag time by precomputing certain values once at the start.


## Getting Started (Setup)

## APK version:

### Prerequisites
1. [Install Android Studio](https://developer.android.com/studio).

2. [Read this guide to set the Android Emulator up](https://developer.android.com/studio/run/managing-avds).

### Installation
1. Download the .apk file which can be found in [Releases](https://github.com/maxangyuejun/LifeHack22/releases/) of this repository.

2. Launch Android Studio and launch your desired emulator

3. Drag and drop the file into the emulator and wait for the app to be installed.

4. Navigate to the app in your emulator and click on it to launch the app.

## Source Code version:

### Prerequisites

To test the app, you will need to have the Flutter SDK, an Android Virtual Device (AVD) and Android Studio installed on your machine.

Follow the instructions at https://docs.flutter.dev/get-started/install, https://developer.android.com/studio and https://developer.android.com/studio/run/managing-avds to get it set up.

### Installation

1. Clone the repo `git clone https://git@github.com:maxangyuejun/LifeHack22.git`

2. In your chosen IDE, get all the dependencies using `flutter pub get` in the terminal in your IDE

3. Start your preferred AVD on your machine through Android Emulator. Set the current location on the AVD to somewhere within Singapore.

4. Run the app using `flutter run` in the terminal in your IDE
