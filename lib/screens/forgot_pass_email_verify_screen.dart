import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/screens/forgot_pass_otp_screen.dart';
import 'package:task_manager/screens/signIn_screen.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackbar_message.dart';
import '../data/Service/network_caller.dart';
import '../data/models/network_response.dart';
import '../widgets/screen_background.dart';

class ForgotPasswdEmailScreen extends StatefulWidget {
  const ForgotPasswdEmailScreen({
    super.key,
  });

  @override
  State<ForgotPasswdEmailScreen> createState() =>
      _ForgotPasswdEmailScreenState();
}

class _ForgotPasswdEmailScreenState extends State<ForgotPasswdEmailScreen> {
  bool _inProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailVerifyTEController =
      TextEditingController();

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
                  'Your Email Address',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification OTP will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
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

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailVerifyTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter a valid email !';
              }
              if (!value!.contains('@')) {
                return '@ must be contain in email !';
              }
            },
          ),
          const SizedBox(height: 24),
          Visibility(
            visible: _inProgress == false,
            replacement: const Center(child: CenterCircularProgressIndicator(),),
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

  Future<void> _sendOTPToEmail() async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.emailVerification(_emailVerifyTEController.text.trim()));

    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswdOTPScreen(
              email: _emailVerifyTEController.text.trim(),
            ),
          ),
        );
      }
    }
    else{
      showSnackBar(context, 'Email verification has been failed', true);
    }
  }

  void _onTapNextButton() {
    _sendOTPToEmail();
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }
}
