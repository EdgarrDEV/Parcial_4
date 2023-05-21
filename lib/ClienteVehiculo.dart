import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Vehiculo extends StatefulWidget {
  const Vehiculo({super.key});

  @override
  State<Vehiculo> createState() => _VehiculoState();
}

class _VehiculoState extends State<Vehiculo> {
  // text fields' controllers
  final TextEditingController _kilometros = TextEditingController();
  final TextEditingController _matricula = TextEditingController();

  //final CollectionReference _cliente =
  //    FirebaseFirestore.instance.collection('MD_CLIENTES');

//insertar producto
  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _kilometros,
                  decoration: const InputDecoration(labelText: 'Kilometros'),
                ),
                TextField(
                  controller: _matricula,
                  decoration: const InputDecoration(labelText: 'Matricula'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Registrar'),
                  onPressed: () async {
                    final String kilometro = _kilometros.text;
                    final String matricula = _matricula.text;

                    _kilometros.text = '';
                    _matricula.text = '';
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }
//actualizar poducto

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _kilometros.text = documentSnapshot['iKilometros'].toString();
      _matricula.text = documentSnapshot['sMatricula'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _kilometros,
                  decoration: const InputDecoration(labelText: 'Marca'),
                ),
                TextField(
                  controller: _matricula,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Actualizar'),
                  onPressed: () async {
                    final String marca = _kilometros.text;
                    final String modelo = _matricula.text;

                    _kilometros.text = '';
                    _matricula.text = '';
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

//borrar productos
  Future<void> _delete(String productId) async {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El registro fue eliminado correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Registrado exitosamente')),
          backgroundColor: Colors.orange,
        ),
        body: StreamBuilder(
          //stream: _cliente.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    color: const Color.fromARGB(255, 255, 184, 77),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                documentSnapshot['iKilometros'].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                documentSnapshot['sMatricula'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// agregar productos
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            onPressed: () => _create(),
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
