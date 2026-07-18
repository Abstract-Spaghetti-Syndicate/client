import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/presentation/widgets/responsive_layout.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../filament/presentation/pages/filament_page.dart'; // Нова фіча
import '../bloc/printer_bloc.dart';
import '../bloc/printer_event.dart';
import '../bloc/printer_state.dart';
import '../widgets/dashboard_grid.dart';
import '../widgets/home_desktop.dart';
import '../widgets/home_mobile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? _refreshTimer;
  late PrinterBloc _printerBloc;
  int _currentTab = 0; // 0 - Монітор, 1 - Котушки

  @override
  void initState() {
    super.initState();
    _printerBloc = sl<PrinterBloc>();
    _printerBloc.add(FetchPrinterStatus());

    _refreshTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      // Моніторимо статус принтера у фоновому режимі
      _printerBloc.add(FetchPrinterStatus());
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
  }

  // Повертає контент для поточної активної вкладки
  Widget _buildTabContent(PrinterState printerState) {
    switch (_currentTab) {
      case 0:
        // Контент Монітора (наша адаптивна сітка з BLoC-обробкою)
        if (printerState is PrinterLoading && printerState.oldStatus == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (printerState is PrinterError && printerState.oldStatus == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(printerState.message, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _printerBloc.add(FetchPrinterStatus()),
                  child: const Text('Повторити спробу'),
                ),
              ],
            ),
          );
        }
        if (printerState is PrinterLoaded) {
          return DashboardGrid(status: printerState.status);
        } else if (printerState is PrinterLoading && printerState.oldStatus != null) {
          return DashboardGrid(status: printerState.oldStatus!);
        } else if (printerState is PrinterError && printerState.oldStatus != null) {
          return DashboardGrid(status: printerState.oldStatus!);
        }
        return const Center(child: CircularProgressIndicator());
      
      case 1:
        // Контент нової фічі котушок пластику
        return const FilamentPage();
        
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveLayout.isDesktop(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<PrinterBloc>(create: (context) => _printerBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is Unauthenticated) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: BlocBuilder<PrinterBloc, PrinterState>(
          builder: (context, printerState) {
            final Widget activeBody = _buildTabContent(printerState);

            return Scaffold(
              // На ПК ховаємо AppBar, бо логаут і назва дублюються в NavigationRail
              appBar: isDesktop
                  ? null
                  : AppBar(
                      title: Text(_currentTab == 0 ? 'ASS Printer Monitor' : 'ASS Filament Control'),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.redAccent),
                          onPressed: () => _handleLogout(context),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
              body: ResponsiveLayout(
                mobileBody: HomeMobile(
                  selectedIndex: _currentTab,
                  onTabChanged: (index) => setState(() => _currentTab = index),
                  body: activeBody,
                ),
                desktopBody: HomeDesktop(
                  selectedIndex: _currentTab,
                  onTabChanged: (index) => setState(() => _currentTab = index),
                  onLogout: () => _handleLogout(context),
                  body: activeBody,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}