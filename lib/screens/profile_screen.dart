import 'package:flutter/material.dart';
import 'package:task_manager/widgets/tm_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: 'Phone'),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Update'))
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPhotoPicker() {
    return Container(
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text("Selected Photo", style: TextStyle(color: Colors.grey, letterSpacing: 0.9),)
        ],
      ),
    );
  }
}
