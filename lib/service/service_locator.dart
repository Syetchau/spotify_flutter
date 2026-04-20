import 'package:get_it/get_it.dart';
import 'package:spotify/data/repositoryImpl/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/domain/usecases/auth/sign_in_facebook_use_case.dart';
import 'package:spotify/domain/usecases/auth/sign_in_google_use_case.dart';
import 'package:spotify/domain/usecases/auth/sign_in_use_case.dart';
import 'package:spotify/domain/usecases/auth/sign_out_use_case.dart';
import 'package:spotify/domain/usecases/auth/sign_up_use_case.dart';
import '../presentation/root/bloc/root_auth_cubit.dart';

final service = GetIt.instance;

// Singleton class - to init service once
Future<void> initDependencies() async {

  service.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  service.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  service.registerSingleton<SignUpUseCase>(SignUpUseCase());

  service.registerSingleton<SignInUseCase>(SignInUseCase());

  service.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());

  service.registerSingleton<SignInWithFacebookUseCase>(SignInWithFacebookUseCase());

  service.registerSingleton<SignOutUseCase>(SignOutUseCase());

  service.registerFactory<RootAuthCubit>(() => RootAuthCubit(service<SignOutUseCase>()));
}