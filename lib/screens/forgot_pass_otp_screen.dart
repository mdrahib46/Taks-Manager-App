import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/controller/forgotPassOTP_controller.dart';
import 'package:task_manager/screens/reset_password_screen.dart';
import 'package:task_manager/screens/signIn_screen.dart';
import 'package:task_manager/widgets/circularProgressIndicator.dart';
import 'package:task_manager/widgets/snackBar_message.dart';
import '../widgets/screen_background.dart';
import 'package:get/get.dart';

class ForgotPasswdOTPScreen extends StatefulWidget {
  static const String name = '/ForgotPassOtpScreen';
  const ForgotPasswdOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<ForgotPasswdOTPScreen> createState() => _ForgotPasswdOTPScreenState();
}

class _ForgotPasswdOTPScreenState extends State<ForgotPasswdOTPScreen> {
  final TextEditingController _otpTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPassOTPVerityController _forgotPassOTPVerityController =
      Get.find<ForgotPassOTPVerityController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 82),
                  Text(
                    'Pin Verification',
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A 6 digit verification OTP has been sent to your email address',
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
      ),
    );
  }

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PinCodeTextField(
            controller: _otpTeController,
            length: 6,
            keyboardType: TextInputType.number,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              selectedColor: Colors.green,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            appContext: context,
          ),
          const SizedBox(height: 24),
          GetBuilder<ForgotPassOTPVerityController>(
            builder: (forgotPassOtpController) {
              return Visibility(
                visible: !forgotPassOtpController.inProgress,
                replacement: const Center(
                  child: CenterCircularProgressIndicator(),
                ),
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

  Future<void> _verifyOTP() async {
    final bool result = await _forgotPassOTPVerityController
        .getForgotPassOTPVerifyController(widget.email, _otpTeController.text);

    if (result) {
      showSnackBar(context, "Successfully verified");
      Get.toNamed(ResetPasswordScreen.name,
          arguments: {widget.email, _otpTeController.text});
    } else {
      showSnackBar(context, _forgotPassOTPVerityController.errorMessage!, true);
    }
  }

  void _onTapNextButton() {
    _verifyOTP();
  }

  void _onTapSignUp() {
    Get.offAllNamed(SignInScreen.name);
  }
}
