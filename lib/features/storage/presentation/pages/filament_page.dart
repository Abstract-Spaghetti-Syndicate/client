import 'package:flutter/material.dart';
import 'tabs/locations_tab.dart';
import 'tabs/filaments_tab.dart';
import 'tabs/spools_tab.dart';
import 'tabs/vendors_tab.dart';

class FilamentPage extends StatelessWidget {
  const FilamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0,
          bottom: const TabBar(
            isScrollable: false,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            // ВИПРАВЛЕНО: змінили на темний колір для гарної читаємості на світлому фоні
            unselectedLabelColor: Colors.black38,
            labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.blur_circular, size: 20), text: 'Котушки'),
              Tab(icon: Icon(Icons.gradient, size: 20), text: 'Філаменти'),
              Tab(icon: Icon(Icons.business, size: 20), text: 'Виробники'),
              Tab(icon: Icon(Icons.location_on, size: 20), text: 'Локації'),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: TabBarView(
            children: [
              SpoolsTab(),
              FilamentsTab(),
              VendorsTab(),
              LocationsTab(),
            ],
          ),
        ),
      ),
    );
  }
}