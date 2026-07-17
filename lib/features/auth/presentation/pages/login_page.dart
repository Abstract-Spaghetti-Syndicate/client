// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_client/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:printer_client/features/auth/presentation/bloc/auth_event.dart';
import 'package:printer_client/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  final String? errorMessage;

  const LoginPage({super.key, this.errorMessage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Безжально очищаємо пам'ять від чутливих даних користувача
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Визначаємо, чи перебуває система в стані очікування відповіді від сервера
          final isLoading = state is AuthLoading;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.lock_person_rounded, 
                        size: 64, 
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Вхід у Filamentary',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      
                      // Поле введення Email
                      TextFormField(
                        controller: _emailController,
                        enabled: !isLoading, // Блокуємо поле під час завантаження
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Будь ласка, введіть Email';
                          }
                          if (!value.contains('@')) {
                            return 'Email повинен містити символ @';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Поле введення Паролю
                      TextFormField(
                        controller: _passwordController,
                        enabled: !isLoading, // Блокуємо поле під час завантаження
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.vpn_key_rounded),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Будь ласка, введіть пароль';
                          }
                          if (value.length < 6) {
                            return 'Пароль не може бути коротшим за 6 символів';
                          }
                          return null;
                        },
                      ),
                      
                      // Динамічний вивід помилок автентифікації
                      if (state is Unauthenticated && state.errorMessage != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 24),
                      
                      // Кнопка відправки форми
                      ElevatedButton(
                        // Якщо йде завантаження — передаємо null, що робить кнопку disabled на рівні ОС
                        onPressed: isLoading 
                            ? null 
                            : () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<AuthBloc>().add(
                                    SignInRequested(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 16, bottom: 16), // Виправлений const-відступ
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.deepOrange.withValues(alpha: 0.6),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Увійти'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}