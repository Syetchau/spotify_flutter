import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/root/bloc/root_auth_state.dart';
import '../../../domain/usecases/auth/sign_out_use_case.dart';

class RootAuthCubit extends Cubit<RootAuthState> {
  // Use dependency injection
  final SignOutUseCase _signOutUseCase;
  StreamSubscription<User?>? _authSubscription;
  bool _isTimerDone = false;

  RootAuthCubit(this._signOutUseCase) : super(AuthInitial()) {
    _init();
  }

  Future<void> checkAuthStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await user.getIdToken(true);
    } catch (e) {
      await signOut(isExpired: true);
    }
  }

  Future<void> signOut({bool isExpired = false}) async {
    emit(AuthLoading());

    // Delay for showing loading
    await Future.delayed(const Duration(milliseconds: 1500));

    final result = await _signOutUseCase.call();

    result.fold(
          (error) => emit(SignOutError(errorMessage: error.toString())),
          (success) {
            if (isExpired) {
              // User unauthenticated
              emit(Unauthenticated(errorMessage: "Session expired. Please sign in again."));
            } else {
              // User manually sign out
              emit(SignOutSuccess());
            }
          },
    );
  }

  void _init() async {
    // Start the listener in the background immediately
    _authSubscription = FirebaseAuth.instance.idTokenChanges().listen((user) {
      // If timer isn't done, we don't emit anything yet to prevent flickering
      if (!_isTimerDone) return;
      _handleStateUpdate(user);
    });

    // Wait for your mandatory Splash delay
    await Future.delayed(const Duration(milliseconds: 2000));
    _isTimerDone = true;

    // Now that the timer is done, emit the current state based on current user
    _handleStateUpdate(FirebaseAuth.instance.currentUser);
  }

  void _handleStateUpdate(User? user) {
    if (user == null) {
      emit(Unauthenticated(errorMessage: ""));
    } else {
      emit(AuthAppReady());
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}