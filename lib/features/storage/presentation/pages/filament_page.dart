//
import 'package:flutter/material.dart';
import 'tabs/filaments_tab.dart';
import 'tabs/spools_tab.dart';

class FilamentPage extends StatelessWidget {
  const FilamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Сховище матеріалів'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Пластик', icon: Icon(Icons.texture)),
              Tab(text: 'Котушки', icon: Icon(Icons.blur_circular)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FilamentsTab(),
            SpoolsTab(),
          ],
        ),
      ),
    );
  }
}