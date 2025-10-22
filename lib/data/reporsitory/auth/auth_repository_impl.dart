import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/data/reporsitory/auth/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository{

  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return const Left(AuthFailure('Failed to sign in'));
      }

      return Right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to sign in'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return const Left(AuthFailure('Failed to create account'));
      }

      return Right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Failed to create account'));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signout()async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  
}