class Relay3 {
  bool allDay;
  String daysInit;
  String daysEnds;
  bool event;
  String initTime;
  int dataIcon;
  bool relay3;
  String alliasName;
  bool isEnable;
  String endTime;
  Relay3({
    required this.allDay,
    required this.daysInit,
    required this.daysEnds,
    required this.event,
    required this.endTime,
    required this.initTime,
    required this.dataIcon,
    required this.alliasName,
    required this.isEnable,
    required this.relay3,
  });

  factory Relay3.relay3RTDB(Map<String, dynamic> data) {
    return Relay3(
      relay3: data['relay3'] ?? false,
      isEnable: data['isEnable'] ?? false,
      alliasName: data['alliasName'] ?? "Relay3",
      dataIcon: data['dataIcon'] ?? 63365,
      initTime: data['initTime'] ?? DateTime.now().toString(),
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
