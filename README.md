
# EZ_Notes
## _a flutter multiplatform app to write notes using Markdown_

---

EZ_Notes is an application which use Flutter and Firebase to make your note-taking
more enjoyable, thanks to the real-time Markdown formatting and real-time synchronization of data.

## Features

- Runs under Android 11/Windows 10 (it should runs on higher version too, possibly on older version but it has not been tested).
- Create an account with an email and a password so you can retrieve your notes
on every device you use.
- Your notes are stored online and synced in real-time thanks to Firebase.
- The editor has shorcuts for formatting your notes (like Bold, Italic, Titles ...) and you can preview the formatting in real-time.
---

## Installation

First of all, you need to download the latest version of [flutter].
You should also have Visual Studio and all basics flutter's extensions installed.

After adding flutter to your path, if you run :
```sh
flutter pub get
```
You'll get every packages needed for the application to work properly.

Within "/lib/services/" folder, you must create a file nammed "database_options.dart" and put inside your database informations like this :
```dart
class DbOptions {
  static String apiKey = '';
  static String appId = '';
  static String messagingSenderId = '';
  static String projectId = '';
  static String authDomain = '';
  static String databaseURL = '';
  static String storageBucket = '';
  static String measurementId = '';
}
```
You can retrieve those informations on your Firebase [console].

Then you can choose the device you want to build the application for with VSCode,
and you're ready to use EZ_Notes !

## Development

You can get the lastest version of the application on the following [repository].


[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [flutter]: <https://docs.flutter.dev/get-started/install>
   [console]: <https://console.firebase.google.com/>
   [repository]: <https://github.com/MathieuBrillard/ez_notes>
