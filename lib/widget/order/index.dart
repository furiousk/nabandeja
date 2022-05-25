import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.receipt), text: 'Fila'),
                Tab(icon: Icon(Icons.access_alarms), text: 'Preparo'),
                Tab(icon: Icon(Icons.restaurant), text: 'Pronto'),
                Tab(icon: Icon(Icons.room_service), text: 'Retirado'),
              ],
            ),
            title: const Text('Na Bandeja'),
          ),
          body: const TabBarView(
            children: <Widget>[
              Icon(Icons.receipt),
              Icon(Icons.access_alarms),
              Icon(Icons.restaurant),
              Icon(Icons.room_service),
            ],
          ),
        ),
      ),
    );
  }
}

// child: ElevatedButton(
//   onPressed: () {
//     Navigator.pop(context);
//   },
//   child: const Text('Go back!'),
// ),