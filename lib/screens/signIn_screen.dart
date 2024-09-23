import 'package:flutter/material.dart';
import 'package:task_manager/widgets/screen_background.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({super.key});

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text('Get Started With',
                  style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600, letterSpacing: 1.5)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailTEController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.green,
                    ),
                    hintText: 'exmple@mail.com',
                    labelText: "Enter your mail"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.green,
                    ),
                    hintText: 'Password',
                    labelText: "Enter your password"),
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width: screenSize.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
