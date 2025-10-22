
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure,User>> signInWithEmailAndPassword({
    required String email,
    required String password
  });

  Future<Either<Failure,User>> signUpWithEmailAndPassword({
    required String email,
    required String password
  });

  Future<Either<Failure,void>> signout();

  User? getCurrentUser();

  Stream<User?> get authStateChanges;
  
}