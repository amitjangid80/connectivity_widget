import 'package:flutter/material.dart';
import 'package:connectivity_widget/connectivity_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // let's add a widget here
      home: Scaffold(
        body: ConnectivityBuilder(
          builder: (isConnected) {
            // i will change the text widget to button to show interaction
            return Center(child: MaterialButton(onPressed: () {}, color: Colors.green, child: const Text('Press')));
          },
        ),
      ),
    );
  }
}
