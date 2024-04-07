import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:yantrik/components/navbar.dart";
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
    return Scaffold(
      body: _user != null ? const Navbar() : loginPageMethod(context),
    );
  }

  Container loginPageMethod(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Login2.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding:
          EdgeInsetsDirectional.all(MediaQuery.of(context).size.width / 50),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.65,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            padding: const EdgeInsetsDirectional.all(15),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 20, 43, 69),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    googleSignInButton(context),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Mechanic",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    googleSignInButton(context),
                  ],
                )
              ],
            ),
          ),
          //googleSignInButton(context),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Navbar()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // const Text(
          //   "Sign in",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 18,
          //   ),
          // ),
          Image.asset(
            'assets/googlelogo.png',
            height: MediaQuery.of(context).size.height / 18,
          ),
        ],
      ),
    );
  }
}
