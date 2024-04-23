import 'package:dw_flutter_app/auth/provider/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authStateProvider.notifier).logOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'You are logged in!',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }
}
