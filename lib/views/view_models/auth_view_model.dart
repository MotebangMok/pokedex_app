import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/auth/auth_repository.dart';
import 'package:pokedex_app/views/providers/auth_providers.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.isLoading = false, this.errorMessage});

  AuthState copyWith({bool? isLoading, String? errorMessage}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthViewModel(this.authRepository) : super(AuthState());

  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (user) {
        state = state.copyWith(isLoading: false, errorMessage: null);
        return true;
      },
    );
  }

  Future<bool> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (user) {
        state = state.copyWith(isLoading: false, errorMessage: null);
        return true;
      },
    );
  }

  Future<void> signOut() async {
    await authRepository.signout();
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((
  ref,
) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthViewModel(authRepository);
});
