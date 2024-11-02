import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/Service/network_caller.dart';
import 'package:task_manager/data/controller/authcontroller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/widgets/tm_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _emailTEController = TextEditingController();
  TextEditingController _firstNameTEController = TextEditingController();
  TextEditingController _lastNameTEController = TextEditingController();
  TextEditingController _mobileTEController = TextEditingController();
  TextEditingController _passwordTEcontroller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _profilInProgress = false;
  XFile? _selectedImage;

  @override
  void initState() {
    _setUserData();
    super.initState();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Update Profile',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                _buildPhotoPicker(),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: false,
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),

                  // validator: ,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameTEController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'First Name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameTEController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mobileTEController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Phone'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO :
                      }
                    },
                    child: const Text('Update'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickedImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  'Photo',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _getSelectedPhotoTitle(),
              style: TextStyle(color: Colors.grey, letterSpacing: 0.9),
            )
          ],
        ),
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Select photo';
  }

  Future<void> _pickedImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  Future<void> _updateProfile() async {
    _profilInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text,
      "mobile" : _mobileTEController.text.trim()

    };

    if(_passwordTEcontroller.text.isNotEmpty){
      requestBody['password'] = _passwordTEcontroller.text;
    }
    if(_selectedImage != null){

      // requestBody['photo'] = _
    }
    // final NetworkResponse response = NetworkCaller.postRequest(url: url)



  }
}
