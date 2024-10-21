import 'package:flutter/material.dart';

class ReportItemScreen extends StatelessWidget {
  const ReportItemScreen({super.key, required this.reportId});

  final String reportId;

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
            const Text('Report Item Screen'),
            const SizedBox(height: 20),
            const Text('Report Details'),
            const SizedBox(height: 20),
            const Text('Report Description'),
            const SizedBox(height: 20),
            const Text('Report Location'),
            const SizedBox(height: 20),
            const Text('Report Image'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
