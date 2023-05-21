import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_parcial_4/Cliente.dart';
import 'package:flutter_parcial_4/ClienteVehiculo.dart';
import 'package:flutter_parcial_4/Vehiculo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseAPP());
}

class FirebaseAPP extends StatelessWidget {
  const FirebaseAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: Principal(),
    );
  }
}

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mantenimientos'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 100, //height of button
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                      style: TextStyle(height: 0, fontSize: 20),
                      'Mantto Cliente'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Cliente()));
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100, //height of button
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                      style: TextStyle(height: 0, fontSize: 20),
                      'Mantto Vehiculos'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Cliente()));
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100, //height of button
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                      style: TextStyle(height: 0, fontSize: 20),
                      'Mantto cliente vehiculo'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Cliente()));
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
