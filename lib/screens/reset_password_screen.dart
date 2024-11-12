import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/screens/signIn_screen.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../data/utils/urls.dart';
import '../widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String name = "/ResetPassScreen";

  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _inProgress = false;
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmPassTeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum length password should be 8 character with letter and number combination',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                _buildResetPasswordForm(),
                const SizedBox(height: 24),
                Center(
                  child: _buildHaveAccountSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Password'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your new Password';
              }
              if (value!.length < 8) {
                return "Password should be more then 8 character";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPassTeController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value != _passTEController.text) {
                return "Password does not match. Try again";
              }
            },
          ),
          const SizedBox(height: 24),
          Visibility(
            visible: _inProgress == false,
            replacement: const Center(
              child: const CenterCircularProgressIndicator(),
            ),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Have an account? ",
        children: [
          TextSpan(
              text: 'Sign in',
              style: const TextStyle(color: Colors.green),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp),
        ],
      ),
    );
  }

  Future<void> _resetPassword() async {
    _inProgress = true;
    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _confirmPassTeController.text
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.resetPassword, body: requestBody);
    _inProgress = false;
    if (response.isSuccess) {
      showSnackBar(context, 'Password reset successfully');
      setState(() {});
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false);
    } else {
      if (mounted) {
        showSnackBar(context, 'Password reset has been failed', true);
        setState(() {});
      }
    }
  }

  void _onTapNextButton() {
    _resetPassword();
  }

  void _onTapSignUp() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }
}
