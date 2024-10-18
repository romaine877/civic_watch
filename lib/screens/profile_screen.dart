import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../cubits/auth/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('John Doe'),
                    
                    ],
            ),
                
                const CircleAvatar(
                  radius: 30,
                  
                ),
            ],
            ),
            Text('Profile Screen'),
            ShadButton.destructive(
  child: const Text('Logout'),
  onPressed: () {
    context.read<AuthCubit>().signOut();
  },
)
          ],
        ),
      ),
    );
  }
}