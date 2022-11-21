import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/loginstructure.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => SignupScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return log_in_structure(
      page_label: 'Sign Up',
      page_description: 'Please sign up to continue.',
      label_email: 'Create new email',
      label_password: 'Create new Password',
      account: "Already have an account? ",
      sign_log_navigation: 'Log In',
      routeName_button: '/login',
      backgrnd_image: 'assets/images/signup_page_image.webp',
      button_widget: TextButton(
        onPressed: () async{
          try {
            //spinner = true;
            (context as Element).markNeedsBuild();
            final newuser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: log_in_structure.username, password: log_in_structure.password);
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
          'Sign Up',
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
