import 'package:ewallet/features/modfiy_transaction/screens/modify_transaction_screen.dart';
import 'package:ewallet/features/overview/screens/overview_screen.dart';
import 'package:ewallet/features/start/screens/start_screen.dart';
import 'package:ewallet/state/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:ewallet/shared/app_colors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return StateProvider(
      child: MaterialApp(
        title: 'Ewallet',
        theme: ThemeData(
            fontFamily: 'Sora',
            primarySwatch: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.primaryColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF0F18E2),
                  onPrimary: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  side: const BorderSide()),
            ),
            inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                filled: true,
                fillColor: Color(0xFFFDFDFD)),
            appBarTheme: const AppBarTheme(elevation: 0)),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const StartScreen(),
          OverviewScreen.routeName: (BuildContext context) =>
              const OverviewScreen(),
          ModifyTranactionScreen.routeName: (BuildContext context) =>
              const ModifyTranactionScreen(),
        },
      ),
    );
  }
}
