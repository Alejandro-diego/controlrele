class Relay1 {
  bool allDay;
  String daysInit;
  String daysEnds;
  bool event;
  String initTime;
  int dataIcon;
  bool relay1;
  String alliasName;
  bool isEnable;
  String endTime;
  Relay1({
    required this.allDay,
    required this.daysInit,
    required this.daysEnds,
    required this.event,
    required this.endTime,
    required this.initTime,
    required this.dataIcon,
    required this.alliasName,
    required this.isEnable,
    required this.relay1,
  });

  factory Relay1.relay1RTDB(Map<String, dynamic> data) {
    return Relay1(
      relay1: data['relay1'] ?? false,
      isEnable: data['isEnable'] ?? false,
      alliasName: data['alliasName'] ?? "Relay1",
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
