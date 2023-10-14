import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final newReport = await Get.to(ReportsPage());
            if (newReport != null) {
              // Handle the new report, e.g., update your data.
            }
          },
          child: Text('View Reports'),
        ),
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Display Reports Here'),
            ElevatedButton(
              onPressed: () {
                // Simulate adding a new report.
                final newReport = "New Report"; // Replace with your data
                Get.back(
                    result:
                        newReport); // Use Get to navigate back and pass data.
              },
              child: Text('Add Report'),
            ),
          ],
        ),
      ),
    );
  }
}
