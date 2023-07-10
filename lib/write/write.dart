import 'package:firebase_database/firebase_database.dart';

class Write {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  void restoreDB(String disp) async {
    _db.child("data$disp").update(
      {
        "Relay1": {
          "allDay": true,
          "alliasName": "Button 1",
          "dataIcon": 62646,
          "dataIconIOS": "power",
          "daysEnds": "[true, true, true, true, true, true, true]",
          "daysInit": "[true, true, true, true, true, true, true]",
          "endTime": "21:20",
          "event": true,
          "initTime": "21:00",
          "isEnable": true,
          "relay1": false
        },
        "Relay2": {
          "allDay": false,
          "alliasName": "Button 2",
          "dataIcon": 62646,
          "dataIconIOS": "fanblades",
          "daysEnds": "[false, false, false, false, false, false, false]",
          "daysInit": "[false, false, false, false, false, false, false]",
          "endTime": "17:23",
          "event": false,
          "initTime": "14:00",
          "isEnable": true,
          "relay2": false
        },
        "Relay3": {
          "allDay": false,
          "alliasName": "Button 3",
          "dataIcon": 63365,
          "dataIconIOS": "power",
          "daysEnds": "[false, false, false, false, false, false, false]",
          "daysInit": "[false, false, false, false, false, false, false]",
          "endTime": "17:26",
          "event": false,
          "initTime": "17:08",
          "isEnable": true,
          "relay3": false
        },
        "Relay4": {
          "allDay": true,
          "alliasName": "Button 4",
          "dataIcon": 62646,
          "dataIconIOS": "lightbulb",
          "daysEnds": "[true, true, true, true, true, true, true]",
          "daysInit": "[true, true, true, true, true, true, true]",
          "endTime": "00:00",
          "event": false,
          "iconDataIOS": "power",
          "initTime": "00:00",
          "isEnable": true,
          "relay4": false
        },
        "disp": disp,
        "nome": "nome",
        "status": false
      },
    );
  }
}
