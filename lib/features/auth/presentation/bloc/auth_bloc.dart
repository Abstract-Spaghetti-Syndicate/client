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

    // Слухаємо реактивну шину подій мережевого шару (захист периметра 401)
    _busSubscription = _eventBus.stream.listen((event) {
      if (event == AuthBusEvent.tokenExpired) {
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

    try {
      // Створюємо бізнес-сутність, що містить і динамічний хост сервера
      final credentials = UserCredentials(
        serverUrl: event.serverUrl,
        email: event.email,
        password: event.password,
      );
      
      final (failure, token) = await _signInUseCase(credentials);

      if (failure != null) {
        emit(Unauthenticated(errorMessage: failure.message));
      } else if (token != null) {
        emit(Authenticated(token: token));
      }
    } catch (e) {
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
    _busSubscription?.cancel();
    return super.close();
  }
}