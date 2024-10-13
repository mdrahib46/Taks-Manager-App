import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/authcontroller.dart';
import 'package:task_manager/screens/profile_screen.dart';
import 'package:task_manager/screens/signIn_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen =  false
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isProfileScreenOpen){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen(),),);
      },
      child: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            const CircleAvatar(
              // backgroundImage: Image.asset('name'),,
              backgroundColor: Colors.white,
              radius: 16,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rabbil hasan', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),),
                  Text('rabbil@gmail.com', style: TextStyle(fontSize: 14, color: Colors.white),),
                ],
              ),
            ),
            IconButton(onPressed: (){
              AuthController.clearUserData();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (route)=> false);
            }, icon: const Icon(Icons.logout, color: Colors.white,))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>const  Size.fromHeight(kToolbarHeight);
}
