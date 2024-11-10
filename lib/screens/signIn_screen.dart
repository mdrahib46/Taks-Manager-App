import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/controller/signIn_controller.dart';
import 'package:task_manager/screens/forgot_pass_email_verify_screen.dart';
import 'package:task_manager/screens/main_bottom_navbar_screen.dart';
import 'package:task_manager/screens/signup_screen.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTeController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final SignInController signInController =  Get.find<SignInController>();


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Get Started With',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                _buildSignInForm(),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPasswordButton,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      _buildSignUpSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter email address";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passTeController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Password";
              }
              if (value!.length <= 6) {
                return "Password should be more then 8 character";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GetBuilder<SignInController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapNextButton,
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    final bool result = await signInController.signIn(
      _emailTEController.text.trim(),
      _passTeController.text,
    );

    if (result) {
      showSnackBar(context, "Login Successfully....");
      Get.offAllNamed( MainBottomNavbarScreen.name);
    } else {
      showSnackBar(context, signInController.errorMessage!, false,);
    }
  }

  void _onTapNextButton() {
    if (!_fromKey.currentState!.validate()) {
      return;
    }
    _signIn();
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswdEmailScreen(),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Don't have an account? ",
        children: [
          TextSpan(
              text: 'Sign Up',
              style: const TextStyle(color: Colors.green),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp),
        ],
      ),
    );
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }
}
