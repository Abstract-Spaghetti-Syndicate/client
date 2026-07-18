import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/filament_bloc.dart';
import '../bloc/filament_event.dart';
import '../bloc/filament_state.dart';
import '../../domain/entities/spool.dart';

class FilamentPage extends StatelessWidget {
  const FilamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilamentBloc>(
      create: (context) => sl<FilamentBloc>()..add(FetchFilaments()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FilamentBloc, FilamentState>(
            builder: (context, state) {
              if (state is FilamentLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FilamentError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<FilamentBloc>().add(FetchFilaments()),
                        child: const Text('Повторити спробу'),
                      ),
                    ],
                  ),
                );
              }

              if (state is FilamentLoaded) {
                if (state.spools.isEmpty) {
                  return const Center(
                    child: Text(
                      'У вашій базі немає жодної активної котушки.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }

                final double width = MediaQuery.of(context).size.width;
                int crossAxisCount = 1;
                if (width > 900) {
                  crossAxisCount = 3;
                } else if (width > 600) {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  itemCount: state.spools.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 130,
                  ),
                  itemBuilder: (context, index) {
                    final spool = state.spools[index];
                    return _buildSpoolCard(spool);
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

  Widget _buildSpoolCard(Spool spool) {
    Color markerColor = Colors.transparent;
    if (spool.colorHex != null && spool.colorHex!.isNotEmpty) {
      final hexStr = spool.colorHex!.replaceFirst('#', '');
      markerColor = Color(int.parse(hexStr.length == 6 ? 'FF$hexStr' : hexStr, radix: 16));
    }

    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      spool.vendor.toUpperCase(),
                      style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        spool.material,
                        style: TextStyle(color: Colors.blue.shade300, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (spool.colorHex != null) ...[
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: markerColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade700, width: 1),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        spool.name,
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  // ВИПРАВЛЕНО: замінено MainAxisAlignment.between на spaceBetween на 154 рядку
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Залишилося:', style: TextStyle(color: Colors.white38, fontSize: 11)),
                    Text(
                      '${spool.remainingWeight.toStringAsFixed(0)}г / ${spool.initialWeight.toStringAsFixed(0)}г',
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'mono'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: spool.remainingPercentage / 100,
                    backgroundColor: Colors.grey.shade800,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}