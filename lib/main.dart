// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_client/core/di/injection_container.dart' as di;
import 'package:printer_client/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:printer_client/features/auth/presentation/bloc/auth_event.dart';
import 'package:printer_client/features/auth/presentation/bloc/auth_state.dart';

// Імпорти сторінок залишаються тут, але згодом будуть винесені в Router-делегат
import 'package:printer_client/features/auth/presentation/pages/splash_page.dart';
import 'package:printer_client/features/auth/presentation/pages/login_page.dart';
import 'package:printer_client/features/printer/presentation/pages/dashboard_page.dart';

void main() async {
  // Гарантуємо стабільність зв'язку з нативним шаром ОС перед ініціалізацією DI
  WidgetsFlutterBinding.ensureInitialized();
  
  // Запуск архітектурного конвеєра
  await di.initDependencies();

  runApp(const FilamentaryApp());
}

class FilamentaryApp extends StatelessWidget {
  const FilamentaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      // Івент AppStarted додається ТУТ, при створенні віджета в UI-дереві!
      // Це гарантує, що життєвий цикл логіки синхронізований з екраном.
      create: (_) => di.sl<AuthBloc>()..add(AppStarted()),
      child: MaterialApp(
        title: 'Filamentary',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const AppNavigator(),
      ),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Navigator(
          key: const ValueKey('root_declarative_navigator'),
          onDidRemovePage: (page) {},
          pages: [
            // Патерн Еквівалентності Стану та Сторінки (Morphed Page Mapping)
            if (state is AuthInitializing)
              const MaterialPage(
                key: ValueKey('SplashPage'),
                child: SplashPage(),
              ),
            if (state is Unauthenticated)
              MaterialPage(
                key: const ValueKey('LoginPage'),
                child: LoginPage(errorMessage: state.errorMessage),
              ),
            if (state is Authenticated)
              const MaterialPage(
                key: ValueKey('DashboardPage'),
                child: DashboardPage(),
              ),
          ],
        );
      },
    );
  }
}