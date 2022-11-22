import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/Completed_task.dart';
import 'package:todo/alertdialog.dart';
import 'package:todo/alltasks.dart';
import 'package:todo/homepage.dart';
import 'package:todo/incomplete_task.dart';
import 'package:todo/log_sign_structure.dart';
import 'package:todo/task.dart';

final _auth = FirebaseAuth.instance;
String loggedUser = 'Welcome@'; //for logged user email and will replace it.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'Signup': (context) => const signup(),
        'homepage': (context) => const homepage(),
        'newtask': (context) => const Newtask(),
        'all_tasks': (context) => const all_tasks(),
        'completed_task': (context) => const completed_tasks(),
        'incomplete_task': (context) => const incomplete_tasks()
      },
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}



//Log In page.
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return log_sign_structure(
      label_email: 'Email',
      label_password: 'Password',
      assetimage: 'images/face-recognation-thumb-2.png',
      page_label: 'Login',
      page_description: 'Please log in to continue',
      log_sign_page_button: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('Signup');
        },
        child: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.blueAccent, fontSize: 15, fontFamily: 'Mukta'),
        ),
      ),
      account: "Don't have an account? ",
      button_widget: TextButton(
        onPressed: () async {
          try {
            spinner = true;
            (context as Element).markNeedsBuild();
            final newuser = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: username, password: password);

            if (newuser != null) {
              Navigator.of(context).pushNamed('homepage');
            }
          } catch (e) {
            alert_title = "Incorrect!";
            alert_content = 'Kindly make sure Email and Password are correct.';
            showAlertDialog(context);
          }
          spinner = false;
          (context as Element).markNeedsBuild();
        },
        child: const Text(
          'LogIn',
          style:
              TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Mukta'),
        ),
      ),
    );
  }
}

//Sign up page
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return log_sign_structure(
      label_email: 'Create new Email',
      log_sign_page_button: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          'Log In',
          style:
              TextStyle(color: Colors.blue, fontSize: 15, fontFamily: 'Mukta'),
        ),
      ),
      label_password: 'Create new password',
      assetimage: 'images/login.png',
      page_label: 'SignUp',
      page_description: 'Please sign up to continue',
      account: 'Already have an account?  ',
      button_widget: TextButton(
        onPressed: () async {
          try {
            spinner = true;
            (context as Element).markNeedsBuild();
            final newuser = await _auth.createUserWithEmailAndPassword(
                email: username, password: password);
            if (newuser != null) {
              Navigator.of(context).pushNamed('homepage');
            }
          } catch (e) {
            alert_title = "Invalid!";
            alert_content =
                'Kindly make sure password is more than 6 digit longer and Email is in correct format.';
            showAlertDialog(context);
          }
          spinner = false;
          (context as Element).markNeedsBuild();
        },
        child: const Text(
          'Sign Up',
          style:
              TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Mukta'),
        ),
      ),
    );
  }
}
