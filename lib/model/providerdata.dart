import 'dart:async';
import 'package:controlrele/model/data.dart';
import 'package:controlrele/model/data_relay1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_relay2.dart';
import 'data_relay3.dart';
import 'data_relay4.dart';

class ProviderRTDB extends ChangeNotifier {
  DataRTBD? _rtbd;
  Relay1? _relay1;
  Relay2? _relay2;
  Relay3? _relay3;
  Relay4? _relay4;

  late String disp;

  final _db = FirebaseDatabase.instance.ref();

  late StreamSubscription<DatabaseEvent> streamSubscription0;
  late StreamSubscription<DatabaseEvent> streamSubscription1;
  late StreamSubscription<DatabaseEvent> streamSubscription2;
  late StreamSubscription<DatabaseEvent> streamSubscription3;
  late StreamSubscription<DatabaseEvent> streamSubscription4;
  

  DataRTBD? get datosProvider => _rtbd;
  Relay1? get relay1 => _relay1;
   Relay2? get relay2 => _relay2;
  Relay3? get relay3 => _relay3;
  Relay4? get relay4 => _relay4;

  ProviderRTDB() {
    _getDisp();
  }

  void _obterdatos() {
    if (disp.isNotEmpty) {
      streamSubscription0 = _db.child('data$disp').onValue.listen((event) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        _rtbd = DataRTBD.fromRTBD(data);
        notifyListeners();
      });

      _db.child('data$disp').update({'status': false});

      streamSubscription1 =
          _db.child('data$disp').child('Relay1').onValue.listen((event) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        _relay1 = Relay1.relay1RTDB(data);
        notifyListeners();
      });
       streamSubscription2 =
          _db.child('data$disp').child('Relay2').onValue.listen((event) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        _relay2 = Relay2.relay2RTDB(data);
        notifyListeners();
      });



      streamSubscription3 =
          _db.child('data$disp').child('Relay3').onValue.listen((event) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        _relay3 = Relay3.relay3RTDB(data);
        notifyListeners();
      });

      streamSubscription4 =
          _db.child('data$disp').child('Relay4').onValue.listen((event) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        _relay4 = Relay4.relay4RTDB(data);
        notifyListeners();
      });
    } else {
      print("base de datos podre");
    }
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription0.cancel();
     streamSubscription1.cancel();
    streamSubscription2.cancel();
    streamSubscription3.cancel();
    streamSubscription4.cancel();
  }

  Future<void> _getDisp() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    disp = store.getString("disp") ?? "";

    _obterdatos();
  }
}
