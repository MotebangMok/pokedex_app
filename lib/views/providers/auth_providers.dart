
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/auth/auth_repository.dart';
import 'package:pokedex_app/di/service_locator.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return getIt<AuthRepository>();
});

final authStateProvider = StreamProvider<User?>((ref){
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final currentUserProvider = Provider<User?>((ref){
  return ref.watch(authRepositoryProvider).getCurrentUser();
});