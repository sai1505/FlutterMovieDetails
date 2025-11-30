import 'package:flutter/material.dart';
import 'package:moviedetails/screens/signin_page.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Load from your local DB (SharedPrefs / Hive / SQLite)
    const userName = "Sai Venkat";
    const userEmail = "saivenkat@example.com";

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple.shade300,
              child: const Text(
                "S",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // NAME
            Text(
              userName,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            // EMAIL
            Text(
              userEmail,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // Profile options
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("Edit Profile"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Implement edit page if needed
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),

            const Spacer(),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    SignInPage.routeName,
                    (_) => false,
                  );
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
