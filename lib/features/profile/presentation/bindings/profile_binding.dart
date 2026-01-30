import 'package:e_commerce/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:e_commerce/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:e_commerce/features/profile/domain/usecases/buy_history_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/fetch_shop_status_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:e_commerce/features/profile/domain/usecases/request_shop_usecase.dart';
import 'package:e_commerce/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final remoteDatasource = ProfileRemoteDatasourceImpl();
    final profileRepository = ProfileRepositoryImpl(remoteDatasource);
    final getProfileUseCase = GetProfileUseCase(profileRepository);
    final requestShop = RequestShopUseCase(profileRepository);
    final fetchStatus = FetchShopStatusUseCase(profileRepository);
    final historyUseCase = BuyHistoryUseCase(profileRepository);
    Get.put(ProfileController(
      getProfileUseCase,
      requestShop,
      fetchStatus,
      historyUseCase,
    ));

    //------O-O-------------------<^>-----------------O-O-------\\
  }
}
