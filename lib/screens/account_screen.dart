import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Doe'),
                    Text('Reported 2 days ago'),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                ),
              ],
            ),
            const Text('Account Screen'),
            const SizedBox(height: 20),
            const Text('Account Details'),
            const SizedBox(height: 20),
            const Text('Account Description'),
            const SizedBox(height: 20),
            const Text('Account Location'),
            const SizedBox(height: 20),
            const Text('Account Image'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
