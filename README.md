# Todo
# Todo App with Firebase Firestore

A simple todo application built with Flutter that integrates with Firebase Firestore for storing and managing tasks. The app supports email authentication for user sign up and login, and provides features like urgent tasks, complete and incomplete tabs for tasks, as well as an upcoming task indicator on the homepage.

## Features

- User authentication with Firebase email authentication for sign up and login.
- Ability to add, edit, and delete tasks.
- Categorization of tasks as urgent, complete, and incomplete.
- Filtering of tasks based on their status.
- Display of upcoming tasks with an indicator on the homepage.
- Real-time synchronization of tasks across multiple devices using Firebase Firestore.
- Clean and intuitive user interface with smooth animations.

## Screenshots

![Todo App Screenshot 1](screenshots/screenshot1.png)
![Todo App Screenshot 2](screenshots/screenshot2.png)
![Todo App Screenshot 3](screenshots/screenshot3.png)

## Installation

1. Clone the repository to your local machine using the following command:

2. Navigate to the project directory:

3. Install the dependencies by running the following command:

4. Set up your Firebase project by following the instructions in the [Firebase documentation](https://firebase.google.com/docs/flutter/setup). Make sure to enable email authentication and Firestore database for your project.

5. Replace the `google-services.json` file in the `android/app` directory with your own Firebase configuration file.

6. Run the application on an emulator or a physical device using the following command:

## Usage

- Sign up or login with your email and password to access the todo application.
- Add tasks by tapping on the '+' button and providing the task details.
- Edit or delete tasks by swiping left or right on the task item.
- Mark tasks as urgent, complete, or incomplete using the provided tabs.
- Filter tasks based on their status using the tabs at the bottom of the screen.
- View upcoming tasks with the indicator on the homepage.
- Log out from the application using the logout button in the app bar.

## Dependencies

- [flutter](https://pub.dev/packages/flutter) - The core Flutter framework.
- [firebase_core](https://pub.dev/packages/firebase_core) - The Firebase Core plugin for Flutter.
- [firebase_auth](https://pub.dev/packages/firebase_auth) - The Firebase Authentication plugin for Flutter.
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) - The Cloud Firestore plugin for Flutter.
- [intl](https://pub.dev/packages/intl) - The Internationalization plugin for Flutter.

## Contributing

If you would like to contribute to this project, feel free to submit a pull request. Please make sure to follow the [contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- This project was built using the Flutter framework and integrates with Firebase Firestore for data management.
- Special thanks to the authors and contributors of the used Flutter plugins for their hard work and dedication in creating the dependencies used in this project.
- Inspiration for the design and features of this app was drawn from various todo applications available in the market.

