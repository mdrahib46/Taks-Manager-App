import 'package:flutter/material.dart';
import 'package:task_manager/screens/signIn_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignInScreen()), (route)=> false);
          }, icon: const Icon(Icons.logout, color: Colors.white,))
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>const  Size.fromHeight(kToolbarHeight);
}
