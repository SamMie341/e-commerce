import 'package:e_commerce/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce/features/auth/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    final remoteDataSource = AuthRemoteDataSource();
    final repository = AuthRepositoryImpl(remoteDataSource);
    final loginUseCase = LoginUseCase(repository);
    Get.lazyPut(() => LoginController(loginUseCase));
  }
}
