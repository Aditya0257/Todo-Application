import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/loginstructure.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return log_in_structure(
      page_label: 'Log In',
      page_description: 'Please Log in to continue.',
      label_email: 'Enter your email',
      label_password: 'Enter your Password',
      account: "Don't have an account? ",
      sign_log_navigation: 'Sign Up',
      routeName_button: '/signup',
      backgrnd_image: 'assets/images/login_page_cartoonistic_img.png',
      button_widget: TextButton(
        onPressed: () async {
          try {
            //spinner = true;
            //(context as Element).markNeedsBuild();
            final newuser = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: log_in_structure.username,
                password: log_in_structure.password);

            if (newuser != null) {
              Navigator.of(context).pushNamed('/');
            }
          } catch (e) {
            print(e);
          }
          //spinner = false;
          //(context as Element).markNeedsBuild();
        },
        child: Text(
          'Log In',
          style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
