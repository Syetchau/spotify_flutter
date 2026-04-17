import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/root/bloc/root_auth_state.dart';

class RootAuthCubit extends Cubit<RootAuthState> {

  RootAuthCubit() : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await user.getIdToken(true);
    } catch (e) {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(Unauthenticated(errorMessage: "Session expired. Please sign in again."));
      await Future.delayed(const Duration(milliseconds: 200));
      await FirebaseAuth.instance.signOut();
    }
  }
}