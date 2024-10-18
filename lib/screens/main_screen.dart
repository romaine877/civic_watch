import 'package:civic_watch/screens/login_screen.dart';
import 'package:civic_watch/screens/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import 'map_screen.dart';
import 'profile_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (userModel) {
            return const MainScreen();
          },
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          orElse: () {
            return const LoginScreen();
          },
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    List<Widget> screens = [
      const MapScreen(),
      const ReportsScreen(),
      const ProfileScreen(),
    ];

    int _currentIndex = 0;

    

    void _onTabTapped(int index) {
     setState(() {
      _currentIndex = index;
    });
   
    }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 56,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              final icons = [Icons.map, Icons.book_rounded, Icons.person];
              return SizedBox(
                width: 36,
                height: 36,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => _onTabTapped(index),
                    child: Icon(
                      icons[index],
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body:  IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
      
    
    );
  }
}
