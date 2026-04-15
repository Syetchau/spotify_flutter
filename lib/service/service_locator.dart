import 'package:get_it/get_it.dart';
import 'package:spotify/data/repositoryImpl/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/domain/usecases/auth/sign_up_use_case.dart';

final service = GetIt.instance;

// Singleton class - to init service once
Future<void> initDependencies() async {

  service.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  service.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  service.registerSingleton<SignUpUseCase>(SignUpUseCase());
}