import 'package:flutter/material.dart';
import 'package:prochef/userscreens/SignupScreen.dart';
import 'package:prochef/userscreens/loginscreen.dart';

class SignInSignUpWidget extends StatelessWidget {
  const SignInSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 390,
                  child: Image.asset(
                    'assets/logo/prochef.png',
                    height: 150,
                    width: 300,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    'Hi\nGuest..',
                    style: TextStyle(color: Colors.black, fontSize: 33),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 55,
                    ),
                    const Text(
                      'You can ',
                      style: TextStyle(fontSize: 25),
                    ),
                    InkWell(
                      hoverColor: Colors.amber,
                      child: const Text(
                        'Login ',
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                    ),
                    const Text(
                      'Or ',
                      style: TextStyle(fontSize: 25),
                    ),
                    InkWell(
                      hoverColor: Colors.amber,
                      child: const Text(
                        'Signup ',
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}
