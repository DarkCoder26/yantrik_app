import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yantrik/pages/home_page.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen(
      (event) {
        setState(
          () {
            _user = event;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _user != null ? const HomePage() : loginPageMethod(context);
  }

  Container loginPageMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login page.png"),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 400),
          Container(
            height: 350,
            width: 350,
            color: Color.fromRGBO(0, 20, 43, 0.69),
          ),
        ],
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }

  ElevatedButton googleSignInButton(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Colors.white,
        ),
      ),
      onPressed: _handleGoogleSignIn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Sign in",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Image.asset(
            'assets/googlelogo.png',
            height: MediaQuery.of(context).size.height / 18,
          ),
        ],
      ),
    );
  }
}
