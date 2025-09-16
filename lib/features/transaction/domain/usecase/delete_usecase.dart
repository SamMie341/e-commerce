import 'package:e_commerce/features/transaction/domain/repository/order_repository.dart';

class DeleteUseCase {
  final OrderRepository repository;

  DeleteUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteOrder(id);
  }
}
