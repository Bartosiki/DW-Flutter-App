# DW Flutter App

### Setup guide:
After cloning project on your machine, you will be missing **Firebase related files** that are required to run the application.
It is not clear whether these files are totally safe to commit publicly, that's why I've decided to add them to `.gitignore` and require everyone to generate them by themself.

Prerequisites:
1. If you don't have Firebase CLI installed on your machine, please follow [this](https://firebase.google.com/docs/cli?hl=pl#setup_update_cli) tutorial.
2. In terminal, execute `firebase login` command. Please sign up with Google account that has joined *dw-flutter-app* Firebase project.
3. Install CLI FlutterFire by executing this command in terminal: `dart pub global activate flutterfire_cli`.

After making sure you fulfill prerequisites, follow these steps:
1. In terminal, go to project's root folder.
2. Execute `flutterfire configure` command.
3. From list of available projects, choose *dw-flutter-app*.
4. Make sure, that your configuration supports only *android* and *ios* platforms.

After these steps, 4 firebase-related files should be added to the project. Now you can run the app and start working :)