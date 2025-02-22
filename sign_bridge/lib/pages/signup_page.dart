import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sign_bridge/pages/login_page.dart';
import 'package:sign_bridge/screens/home_screen.dart';
import 'package:sign_bridge/screens/mainscreen.dart';
import 'package:sign_bridge/widgets/custome_button.dart';
import 'package:sign_bridge/widgets/cutome_textfeild.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final namecontroller = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();

  Future<void> createUserAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      await FirebaseFirestore.instance.collection('userInfo').add({
        'name': namecontroller.text.trim(),
        'email': email.text.trim(),
        'pass': password.text.trim(),
        'userid': FirebaseAuth.instance.currentUser!.uid,
      });

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            icon: const Icon(Icons.warning),
            title: Text(e.message.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset("assets/images/logo2.png"),
              ),
            ),
            Text(
                  "Join us and start bridging worlds today!",
                  style: Theme.of(context).textTheme.titleLarge,
                )
                .animate()
                .slideX(
                  delay: Duration(milliseconds: 300),
                  duration: Duration(seconds: 1),
                )
                .fade(delay: Duration(milliseconds: 400)),
            const SizedBox(height: 20),
            CustomeTextfeild(
              hintText: "Enter your name",
              isPass: false,
              controller: namecontroller,
            ),
            const SizedBox(height: 15),
            CustomeTextfeild(
              hintText: "Enter your email",
              isPass: false,
              controller: email,
            ),
            const SizedBox(height: 15),
            CustomeTextfeild(
              hintText: "Enter your password",
              isPass: true,
              controller: password,
            ),
            const SizedBox(height: 15),
            CustomeTextfeild(
              hintText: "Confirm your password",
              isPass: true,
              controller: confirmpassword,
            ),
            const SizedBox(height: 40),
            Center(
              child: CustomeButton(
                bgColor: Colors.black,
                text: "Create account",
                onPressed: () {
                  createUserAndPassword();
                },
                fgColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: "Log in",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
