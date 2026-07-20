//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/filament/filament_bloc.dart';

class SpoolsTab extends StatefulWidget {
  const SpoolsTab({super.key});

  @override
  State<SpoolsTab> createState() => _SpoolsTabState();
}

class _SpoolsTabState extends State<SpoolsTab> {
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
            return const Center(child: Text('Котушок не знайдено'));
          }

          return ListView.builder(
            itemCount: state.filaments.length,
            itemBuilder: (context, index) {
              final filament = state.filaments[index];
              final intColor = int.tryParse(filament.colorHex.replaceAll('#', '0xFF')) ?? 0xFFCCCCCC;

              return ListTile(
                title: Text(filament.name),
                subtitle: Text('${filament.material} - ${filament.diameter}mm'),
                leading: CircleAvatar(
                  backgroundColor: Color(intColor),
                ),
              );
            },
          );
        }

        return const Center(child: Text('Ініціалізація сховища...'));
      },
    );
  }
}