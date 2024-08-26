// import 'package:flutter/material.dart';
// import 'package:izesan/widgets/app_text.dart';
//
// class AppDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     // Clamp width between 200 and 300 pixels
//     double drawerWidth = (screenWidth * 0.75).clamp(200.0, 300.0);
//
//     return Drawer(
//       width: drawerWidth,
//       backgroundColor: Theme.of(context).cardColor,
//       semanticLabel: 'App Drawer',
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: const AppText(text: 'John Doe',),
//             accountEmail: const AppText(text:'user@izesan.com'),
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const AppText(text:'Home'),
//
//             onTap: () {
//               // Handle navigation to Home screen
//               Navigator.pop(context); // Close the drawer
//               // ... navigate to Home
//               setState(() {
//                 currentIndex = 0;
//               });
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.history),
//             title: const AppText(text: 'History'),
//             onTap: () {
//               // Handle navigation to History screen
//               Navigator.pop(context);
//               // ... navigate to History
//             },
//           ),
//           // Add more ListTiles for other navigation options
//         ],
//       ),
//     );
//   }
// }