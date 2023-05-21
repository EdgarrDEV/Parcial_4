import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Cliente extends StatefulWidget {
  const Cliente({super.key});

  @override
  State<Cliente> createState() => _ClienteState();
}

class _ClienteState extends State<Cliente> {
  // text fields' controllers
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();

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
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombres'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                ),
                TextField(
                  controller: _direccionController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                ),
                TextField(
                  controller: _ciudadController,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Registrar'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String direccion = _direccionController.text;
                    final String ciudad = _ciudadController.text;

                    /* await _cliente.add({
                      "sNombreCliente": nombre,
                      "sApellidosCliente": apellido,
                      "sDireccionCliente": direccion,
                      "sCiudadCliente": ciudad
                    });*/

                    _nombreController.text = '';
                    _apellidoController.text = '';
                    _direccionController.text = '';
                    _ciudadController.text = '';
                    // ignore: use_build_context_synchronously
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
      _nombreController.text = documentSnapshot['sNombreCliente'].toString();
      _apellidoController.text =
          documentSnapshot['sApellidosCliente'].toString();
      _direccionController.text =
          documentSnapshot['sDireccionCliente'].toString();
      _ciudadController.text = documentSnapshot['sCiudadCliente'].toString();
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
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombres'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                ),
                TextField(
                  controller: _direccionController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                ),
                TextField(
                  controller: _ciudadController,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
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
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String direccion = _direccionController.text;
                    final String ciudad = _ciudadController.text;

                    _nombreController.text = '';
                    _apellidoController.text = '';
                    _direccionController.text = '';
                    _ciudadController.text = '';
                    // ignore: use_build_context_synchronously
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
        content: Text('El cliente fue eliminado correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Cliente Registrado')),
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
                                documentSnapshot['sNombreCliente'].toString(),
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
                                documentSnapshot['sApellidosCliente']
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                documentSnapshot['sDireccionCliente']
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                documentSnapshot['sCiudadCliente'].toString(),
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
