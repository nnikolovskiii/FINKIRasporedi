import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/login/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/presentation/screens/list/schedule_list_screen.dart';
import 'package:flutter_app/service/auth_service.dart';
import '../../domain/providers/schedule_provider.dart';
import '../widgets/custom_app_bar.dart';
import 'add/add_schedule_screen.dart';
import 'list/action_list_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<ScheduleProvider>(context, listen: false)
          .setIsDefault(index == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = Provider.of<ScheduleProvider>(context).isDefault;
    final name = Provider.of<ScheduleProvider>(context).name;

    return Scaffold(
      appBar: CustomAppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset(
              'resources/images/rasporedi_logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: <Widget>[
          FutureBuilder<Map<String, dynamic>?>(
            future: AuthService.getLoggedInUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == null) {
                return IconButton(
                  icon: const Icon(Icons.account_circle_sharp,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const AuthScreen()),
                    );
                  },
                );
              } else {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF123499).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.account_circle, color: Colors.white),
                          const SizedBox(width: 5),
                          Text(
                            snapshot.data!['username'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        AuthService.logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const AuthScreen()),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_sharp, color: Colors.white),
            onPressed: () {
              _showImageDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ToggleButtons(
              isSelected: [_selectedIndex == 0, _selectedIndex == 1],
              onPressed: (index) {
                _onToggle(index);
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: const Color(0xFF375f95).withOpacity(1),
              color: Colors.black,
              constraints: const BoxConstraints(minHeight: 40, minWidth: 150),
              children: const [
                Text('ФИНКИ распореди'),
                Text('Мои распореди'),
              ],
            ),
          ),
          Expanded(
            child: (_selectedIndex == 0)
                ? _getSelectedWidget(name)
                : const ScheduleListScreen(),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: AuthService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // Display nothing while loading
          } else if (snapshot.hasError || !snapshot.data!) {
            return Container(); // Display nothing if error or not logged in
          } else {
            return !isDefault
                ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddScheduleScreen()),
                );
              },
              child: const Icon(Icons.add),
            )
                : Container();
          }
        },
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: Colors.grey,
              width: 3.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xFF123499)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Image.asset('resources/images/info.png'),
            ],
          ),
        );
      },
    );
  }

  Widget _getSelectedWidget(String name) {
    switch (name) {
      case "Смер":
        return const ScheduleListScreen();
      default:
        return const ActionListScreen();
    }
  }
}
