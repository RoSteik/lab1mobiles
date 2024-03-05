import 'package:flutter/material.dart';
import 'package:my_project/lab2/user_profile_page.dart'; // Ensure this import path matches your project structure

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute<UserProfilePage>(
          builder: (context) => const UserProfilePage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final iconSize = screenSize.width < 600 ? 24.0 : 30.0;
    final drawerFontSize = screenSize.width < 600 ? 16.0 : 20.0;
    final contentFontSize = screenSize.width < 600 ? 20.0 : 24.0;

    final List<Widget> pages = [
      Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: contentFontSize),
        ),
      ),
      Center(
        child: Text(
          'Activity',
          style: TextStyle(fontSize: contentFontSize),
        ),
      ),

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(fontSize: drawerFontSize),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(fontSize: drawerFontSize),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _selectedIndex < pages.length ? pages.elementAt(_selectedIndex) : Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: iconSize),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, size: iconSize),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: iconSize),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:my_project/lab2/user_profile_page.dart';
//
// class MainPage extends StatefulWidget {
//   const MainPage({super.key});
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute<UserProfilePage>(
//             builder: (context) => const UserProfilePage(),),
//       );
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> pages = [
//       const Center(child: Text('Home')),
//       const Center(child: Text('Activity')),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fitness Tracker'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text('Menu'),
//             ),
//             ListTile(
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: _selectedIndex < pages.length ?
//         pages.elementAt(_selectedIndex) : Container(),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center),
//             label: 'Activity',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
