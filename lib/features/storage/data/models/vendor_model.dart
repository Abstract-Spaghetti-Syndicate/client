import '../../domain/entities/vendor.dart';

class VendorModel extends Vendor {
  const VendorModel({
    required super.id,
    required super.name,
    super.comment,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] as int,
      name: json['name'] ?? 'Unknown Vendor',
      comment: json['comment'],
    );
  }
}