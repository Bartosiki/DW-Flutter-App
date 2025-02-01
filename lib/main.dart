import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:dw_flutter_app/extensions/hex_string_color_to_color.dart';
import 'package:dw_flutter_app/provider/config_provider.dart';
import 'package:dw_flutter_app/provider/dark_mode/dark_mode_notifier.dart';
import 'package:dw_flutter_app/screens/home/main_screen.dart';
import 'package:dw_flutter_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'provider/auth/is_logged_in_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        const ProviderScope(
          child: App(),
        ),
      );
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Consumer(
      builder: (context, ref, child) {
        final configValue = ref.watch(configProvider);
        final mainColor = configValue.when(
          data: (config) =>
              config?.mainColor.toColor() ?? AppColors.defaultMainColor,
          loading: () => AppColors.defaultMainColor,
          error: (_, __) => AppColors.defaultMainColor,
        );

        final isDarkModeEnabled = ref.watch(darkModeProvider);
        final isLoggedIn = ref.watch(isLoggedInProvider);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(mainColor, Brightness.light),
          darkTheme: _buildTheme(mainColor, Brightness.dark),
          themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            body: isLoggedIn
                ? configValue.when(
                    data: (config) => config != null
                        ? const MainScreen()
                        : const Center(child: CircularProgressIndicator()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => const LoginScreen(),
                  )
                : const LoginScreen(),
          ),
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
      scaffoldBackgroundColor: colorScheme.surface,
    );
  }
}
