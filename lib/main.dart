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
          key: GlobalKey<NavigatorState>(), // Забезпечує цілісність стану при перебудові
          onPopPage: (route, result) => route.didPop(result),
          pages: [
            // 1. Етап холодного старту додатка та перевірки SecureStorage
            if (state is AuthInitializing)
              const MaterialPage(
                key: ValueKey('SplashPage'),
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
                ),
              ),

            // 2. Еталонний оборонний рубіж: Будь-яка варіація Unauthenticated
            // (чиста форма, помилка 404, неправильний пароль або наслідки бану)
            if (state is Unauthenticated)
              MaterialPage(
                key: const ValueKey('LoginPage'),
                child: LoginPage(errorMessage: state.errorMessage),
              ),

            // 3. Стан завантаження мережевого запиту. 
            // Клієнт ОДНОЧАСНО утримує LoginPage на екрані, поки крутиться лоадер
            if (state is AuthLoading)
              const MaterialPage(
                key: ValueKey('LoginPageLoading'),
                child: LoginPage(),
              ),

            // 4. Успішний вхід у систему — перехід до моніторингу заліза
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