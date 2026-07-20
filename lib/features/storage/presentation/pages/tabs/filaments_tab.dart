//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/filament/filament_bloc.dart';

class FilamentsTab extends StatefulWidget {
  const FilamentsTab({super.key});

  @override
  State<FilamentsTab> createState() => _FilamentsTabState();
}

class _FilamentsTabState extends State<FilamentsTab> {
  @override
  void initState() {
    super.initState();
    context.read<FilamentBloc>().add(SubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilamentBloc, FilamentState>(
      builder: (context, state) {
        if (state is FilamentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FilamentError) {
          return Center(child: Text(state.message));
        }

        if (state is FilamentLoaded) {
          if (state.filaments.isEmpty) {
            return const Center(child: Text('Пластику не знайдено'));
          }

          return ListView.builder(
            itemCount: state.filaments.length,
            itemBuilder: (context, index) {
              final filament = state.filaments[index];
              final intColor = int.tryParse(filament.colorHex.replaceAll('#', '0xFF')) ?? 0xFFCCCCCC;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(intColor),
                  ),
                  title: Text(filament.name),
                  subtitle: Text(
                    '${filament.material} • ${filament.diameter} мм\n'
                    'Хотенд: ${filament.peakExtruderTemp}°C • Стіл: ${filament.peakBedTemp}°C\n'
                    'Щільність: ${filament.density} г/см³',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        }

        return const Center(child: Text('Завантаження...'));
      },
    );
  }
}