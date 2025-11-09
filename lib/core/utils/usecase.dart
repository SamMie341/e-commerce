import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params<T> {
  final T data;

  Params(this.data);
}

class NoParams {
  NoParams();
}

class FileParams {
  final File file;

  FileParams(this.file);
}

class UpdateImageProfileParams {
  final File? imageFile;

  UpdateImageProfileParams({required this.imageFile});
}
