class Relay2 {
  bool allDay;
  String daysInit;
  String daysEnds;
  bool event;
  String initTime;
  int dataIcon;
  bool relay2;
  String alliasName;
  bool isEnable;
  String endTime;
  Relay2({
    required this.allDay,
    required this.daysInit,
    required this.daysEnds,
    required this.event,
    required this.endTime,
    required this.initTime,
    required this.dataIcon,
    required this.alliasName,
    required this.isEnable,
    required this.relay2,
  });

  factory Relay2.relay2RTDB(Map<String, dynamic> data) {
    return Relay2(
      relay2: data['relay2'] ?? false,
      isEnable: data['isEnable'] ?? false,
      alliasName: data['alliasName'] ?? "Relay2",
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
