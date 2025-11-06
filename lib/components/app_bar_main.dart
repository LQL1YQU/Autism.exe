import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMain({
    super.key,
    required this.username,
    required this.avatarUrl,
  });
  final String username;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2),
            child: Container(color: Colors.grey[350], height: 2),
          ),
          title: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 12),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: const [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 20),
            Icon(Icons.more_horiz, color: Colors.black),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
