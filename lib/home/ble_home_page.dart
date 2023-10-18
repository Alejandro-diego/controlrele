import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert' show utf8;

import 'package:shared_preferences/shared_preferences.dart';



class BleHomePage extends StatefulWidget {
  const BleHomePage({Key? key}) : super(key: key);

  @override
  State<BleHomePage> createState() => _BleHomePageState();
}

class _BleHomePageState extends State<BleHomePage> {
  final utf8Decoder = utf8.decoder;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  List<BluetoothService> services = [];
  List<String> ssid = [];

  @override
  void initState() {
    super.initState();
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan(timeout: const Duration(seconds: 8));
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dispositivos Encontrados"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              for (BluetoothDevice device in devicesList)
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.green)),
                    child: Center(
                      child: device.name == ""
                          ? const Text(
                              '(Dispositivo Desconocido)',
                              style: TextStyle(color: Colors.grey),
                            )
                          : Text(
                              device.name,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent),
                            ),
                    ),
                  ),
                  onTap: () async {
                    flutterBlue.stopScan();
                    try {
                      await device.connect();
                      await device.requestMtu(512);
                    } on PlatformException catch (e) {
                      if (e.code != 'already_connected') {
                        rethrow;
                      }
                    } finally {
                      services = await device.discoverServices();
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Device(
                          services: services,
                          device: device,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Device extends StatefulWidget {
  Device({Key? key, required this.services, required this.device})
      : super(key: key);

  // String title;
  List<BluetoothService> services = [];
  BluetoothDevice device;

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  final utf8Decoder = utf8.decoder;
  final String serviceUuid = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  final String txCharacterstic = "6e400002-b5a3-f393-e0a9-e50e24dcca9e";
  final String rxCharacterstic = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
  bool showpass = false;

  final ssidController = TextEditingController();
  final passController = TextEditingController();
  final dispController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late BluetoothCharacteristic characteristic;
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  List<String> ssid = [];

  String nome = "";
  final _db = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();

    _getDisp();
    for (BluetoothService service in widget.services) {
      if (service.uuid.toString() == serviceUuid) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == rxCharacterstic) {
            if (characteristic.properties.notify) {
              characteristic.value.listen((value) {
                setState(() {
                  readValues[characteristic.uuid] = value;
                  ssid = utf8Decoder
                      .convert(readValues[characteristic.uuid]!)
                      .split(",");
                });
              });
              characteristic.setNotifyValue(true);
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ssid == []
                ? const CupertinoActivityIndicator()
                : ListView.builder(
                    itemCount: ssid.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Center(
                            child: Text(
                              ssid[index],
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {
                          var nome = ssid[index].split(" ");
                          ssidController.text = nome[0].trim();
                        },
                      );
                    }),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.10),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: ssidController,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(.5),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.deepPurple),
                      ),
                      hintText: "Ssid da rede",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese Siid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passController,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(.5),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.deepPurple),
                      ),
                      hintText: "Password da rede",
                      suffixIcon: IconButton(
                        onPressed: passController.text.isNotEmpty
                            ? () {
                                setState(() {
                                  showpass = !showpass;
                                });
                              }
                            : () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: showpass ? Colors.amber : Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: !showpass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: dispController,
                    cursorColor: Colors.deepPurple,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(.5),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.deepPurple),
                      ),
                      hintText: "Dispositivo ",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese Dispositivo";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          writeToEsp32();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.blueGrey,
                              content: Text(
                                  "Enviando Credeciales para el Dispositivo"),
                            ),
                          );
                        }
                      },
                      child: const Text("Send To Disp"))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getDisp() async {
    SharedPreferences store = await SharedPreferences.getInstance();

    nome = store.getString("nome") ?? "alex";
  }

  writeToEsp32() {
    for (BluetoothService service in widget.services) {
      if (service.uuid.toString() == serviceUuid) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == txCharacterstic) {
            if (characteristic.properties.write) {
              characteristic.write(utf8.encode(
                  "${ssidController.text.trim()},${passController.text.trim()},${dispController.text}"));
            }
          }
        }
      }
    }
    _db.child('data${dispController.text}').update({
      'disp': dispController.text,
      'nome': nome,
      'status': false,
    });

    _db
        .child('data${dispController.text}')
        .child("Relay1")
        .update({'relay1': false});
    _db
        .child('data${dispController.text}')
        .child("Relay2")
        .update({'relay2': false});
    _db
        .child('data${dispController.text}')
        .child("Relay3")
        .update({'relay3': false});
    _db
        .child('data${dispController.text}')
        .child("Relay4")
        .update({'relay4': false});

    colocarCredenciales();

    widget.device.disconnect();
/*
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );*/
   
  }

  Future<void> colocarCredenciales() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    preference.setString("disp", dispController.text);
  }
}
