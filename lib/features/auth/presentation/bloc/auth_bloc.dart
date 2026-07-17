// lib/features/auth/presentation/bloc/auth_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_client/core/network/auth_event_bus.dart';
import 'package:printer_client/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:printer_client/features/auth/domain/entities/user_credentials.dart';
import 'package:printer_client/features/auth/domain/usecases/sign_in_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final AuthLocalDataSource _localDataSource;
  final AuthEventBus _eventBus;
  
  // Зберігаємо підписку, щоб вчасно її скасувати і запобігти витоку пам'яті
  StreamSubscription<AuthBusEvent>? _busSubscription;

  AuthBloc({
    required SignInUseCase signInUseCase,
    required AuthLocalDataSource localDataSource,
    required AuthEventBus eventBus,
  })  : _signInUseCase = signInUseCase,
        _localDataSource = localDataSource,
        _eventBus = eventBus,
        super(AuthInitializing()) {
    
    on<AppStarted>(_onAppStarted);
    on<SignInRequested>(_onSignInRequested);
    on<LogoutRequested>(_onLogoutRequested);

    // Слухаємо шину подій з мережевого шару
    _busSubscription = _eventBus.stream.listen((event) {
      if (event == AuthBusEvent.tokenExpired) {
        // Якщо токен протух, штучно додаємо подію Logout в самого себе
        add(LogoutRequested());
      }
    });
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final token = await _localDataSource.getToken();
      if (token != null && token.isNotEmpty) {
        emit(Authenticated(token: token));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated(errorMessage: 'Помилка доступу до сховища: $e'));
    }
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Валідуємо та створюємо сутність на рівні бізнес-правил
    try {
      final credentials = UserCredentials(email: event.email, password: event.password);
      
      // Викликаємо чистий сценарій використання
      final (failure, token) = await _signInUseCase(credentials);

      if (failure != null) {
        emit(Unauthenticated(errorMessage: failure.message));
      } else if (token != null) {
        emit(Authenticated(token: token));
      }
    } catch (e) {
      // Перехоплюємо помилки валідації assert конструктора сутності
      emit(Unauthenticated(errorMessage: e.toString().replaceAll('Assertion failed: ', '')));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _localDataSource.deleteToken();
    emit(const Unauthenticated(errorMessage: 'Сесію завершено або токен застарів.'));
  }

  @override
  Future<void> close() {
    // Безжально закриваємо підписку при знищенні блоку (Memory Leak Protection)
    _busSubscription?.cancel();
    return super.close();
  }
}