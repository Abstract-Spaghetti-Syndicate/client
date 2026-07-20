import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection_container.dart';
import '../../bloc/vendor/vendor_bloc.dart';
import '../../bloc/vendor/vendor_event.dart';
import '../../bloc/vendor/vendor_state.dart';
import '../../../domain/entities/vendor_entity.dart';

class VendorsTab extends StatelessWidget {
  const VendorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendorBloc>(
      // Створюємо БЛоК та відразу ініціюємо завантаження даних із SQLite
      create: (context) => sl<VendorBloc>()..add(FetchVendors()),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Щоб колір не перекривав загальний фон
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<VendorBloc, VendorState>(
            builder: (context, state) {
              if (state is VendorLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is VendorError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 14)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<VendorBloc>().add(FetchVendors()),
                        child: const Text('Повторити спробу'),
                      ),
                    ],
                  ),
                );
              }

              if (state is VendorLoaded) {
                if (state.vendors.isEmpty) {
                  return const Center(
                    child: Text(
                      'У базі даних немає жодного виробника.\nВиконайте імпорт зі Spoolman.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  );
                }

                // Визначаємо кількість колонок для адаптивності (ПК / мобільні)
                final double width = MediaQuery.of(context).size.width;
                int crossAxisCount = 1;
                if (width > 900) {
                  crossAxisCount = 4;
                } else if (width > 600) {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  itemCount: state.vendors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 90, // Акуратна фіксована висота для плашок брендів
                  ),
                  itemBuilder: (context, index) {
                    final vendor = state.vendors[index];
                    return _buildVendorCard(vendor);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVendorCard(Vendor vendor) {
    return Card(
      // Робимо картку світло-сірою та контрастною для білого фону вікна
      color: Colors.grey.shade100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Кругла іконка-маркер бренду
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.business, color: Colors.blue.shade700, size: 24),
            ),
            const SizedBox(width: 14),
            // Текстовий блок інформації
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vendor.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (vendor.comment != null && vendor.comment!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      vendor.comment!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}