import 'package:controlrele/utils.dart';

class Relay4 {
  bool allDay;
  String daysInit;
  String daysEnds;
  bool event;
  String initTime;
  int dataIcon;
  bool relay4;
  String alliasName;
  bool isEnable;
  String endTime;
  Relay4({
    required this.allDay,
    required this.daysInit,
    required this.daysEnds,
    required this.event,
    required this.endTime,
    required this.initTime,
    required this.dataIcon,
    required this.alliasName,
    required this.isEnable,
    required this.relay4,
  });

  factory Relay4.relay4RTDB(Map<String, dynamic> data) {
    return Relay4(
      relay4: data['relay4'] ?? false,
      isEnable: data['isEnable'] ?? false,
      alliasName: data['alliasName'] ?? "Relay4",
      dataIcon: data['dataIcon'] ?? 63365,
      initTime: data['initTime'] ??  DateTime.now().toString(),
      endTime: data['endTime'] ??
          DateTime.now().add(const Duration(hours: 2)).toString(),
      event: data['event'] ?? false,
      daysInit: data['daysInit'] ??
          '[true, true, true, true, true, true, true]',
      daysEnds: data['daysEnds'] ??
          '[true, true, true, true, true, true, true]',
      allDay: data['allDay'] ?? true,
    );
  }
}
