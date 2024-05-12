import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/extensions/hex_string_color_to_color.dart';
import 'package:dw_flutter_app/provider/config_provider.dart';
import 'package:dw_flutter_app/provider/dark_mode_notifier.dart';
import 'package:dw_flutter_app/views/home/home_view.dart';
import 'package:dw_flutter_app/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'auth/provider/is_logged_in_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final configValue = ref.watch(configProvider);
        final mainColor = configValue.value?.mainColor.toColor() ??
            AppColors.defaultMainColor;

        final isDarkModeEnabled = ref.watch(darkModeProvider);
        final isLoggedIn = ref.watch(isLoggedInProvider);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(mainColor, Brightness.light),
          darkTheme: _buildTheme(mainColor, Brightness.dark),
          themeMode:
              isDarkModeEnabled == true ? ThemeMode.dark : ThemeMode.light,
          home: isLoggedIn ? const HomeView() : const LoginView(),
        );
      },
    );
  }

  ThemeData _buildTheme(Color primaryColor, Brightness brightness) {
    var colorScheme =
        ColorScheme.fromSeed(seedColor: primaryColor, brightness: brightness);
    var basicTheme =
        brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();

    return basicTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
    );
  }
}
