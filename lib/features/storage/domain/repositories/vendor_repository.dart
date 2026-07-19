import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/vendor.dart';

abstract class VendorRepository {
  Future<Either<Failure, List<Vendor>>> getVendors();
}