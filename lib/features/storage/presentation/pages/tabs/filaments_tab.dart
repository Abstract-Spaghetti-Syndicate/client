import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection_container.dart';
import '../../bloc/spool/spool_bloc.dart';
import '../../bloc/spool/spool_event.dart';
import '../../bloc/spool/spool_state.dart';
import '../../../domain/entities/filament_entity.dart';

class FilamentsTab extends StatelessWidget {
  const FilamentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilamentTabBloc>(
      create: (context) => sl<FilamentTabBloc>()..add(FetchFilamentsTab()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FilamentTabBloc, FilamentTabState>(
            builder: (context, state) {
              if (state is FilamentTabLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FilamentTabError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 14)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<FilamentTabBloc>().add(FetchFilamentsTab()),
                        child: const Text('Повторити спробу'),
                      ),
                    ],
                  ),
                );
              }

              if (state is FilamentTabLoaded) {
                if (state.filaments.isEmpty) {
                  return const Center(
                    child: Text(
                      'Не знайдено жодної марки філаменту.\nВони з\'являться після синхронізації бази.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  );
                }

                final double width = MediaQuery.of(context).size.width;
                int crossAxisCount = 1;
                if (width > 1200) {
                  crossAxisCount = 3;
                } else if (width > 700) {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  itemCount: state.filaments.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    mainAxisExtent: 120, // Оптимальна висота для розміщення тех-параметрів
                  ),
                  itemBuilder: (context, index) {
                    final filament = state.filaments[index];
                    return _buildFilamentCard(filament);
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

  Widget _buildFilamentCard(FilamentEntity filament) {
    // Безпечний парсинг HEX-кольору пластику
    Color plasticColor = Colors.transparent;
    if (filament.colorHex != null && filament.colorHex!.isNotEmpty) {
      final hexStr = filament.colorHex!.replaceFirst('#', '');
      plasticColor = Color(int.parse(hexStr.length == 6 ? 'FF$hexStr' : hexStr, radix: 16));
    }

    return Card(
      color: Colors.grey.shade100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Верхній рядок: Колір + Назва та Тип матеріалу
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filament.colorHex != null) ...[
                  Container(
                    width: 16,
                    height: 16,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: plasticColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filament.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Діаметр: ${filament.diameter?.toStringAsFixed(2) ?? '1.75'} мм',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    filament.material,
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            // Нижній рядок: Технічні температурні ліміти друку
            Divider(color: Colors.grey.shade300, height: 12, thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_fire_department, color: Colors.orange.shade700, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      filament.peakExtruderTemp != null ? '${filament.peakExtruderTemp}°C' : 'Н/Д',
                      style: const TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.layers, color: Colors.blue.shade700, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      filament.peakBedTemp != null ? '${filament.peakBedTemp}°C' : 'Н/Д',
                      style: const TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (filament.density != null)
                  Text(
                    '${filament.density!.toStringAsFixed(2)} г/см³',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontFamily: 'mono'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}