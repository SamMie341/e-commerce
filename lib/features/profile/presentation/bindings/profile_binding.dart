import 'package:e_commerce/core/services/dio_config.dart';
import 'package:e_commerce/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:e_commerce/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:e_commerce/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final dio = DioConfig();
    final remoteDatasource = ProfileRemoteDatasourceImpl(dio);
    final repository = ProfileRepositoryImpl(remoteDatasource);
    final getProfileUseCase = GetProfileUseCase(repository);
    Get.put(ProfileController(getProfileUseCase));

    //------O-O-------------------<^>-----------------O-O-------\\
  }
}
