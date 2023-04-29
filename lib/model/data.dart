class DataRTBD {
  
  String dsp;
  bool status;
  

  DataRTBD(
      {required this.status,
     
      required this.dsp,
     });

  factory DataRTBD.fromRTBD(Map<String, dynamic> data) {
    return DataRTBD(
      status: data['status'] ?? false,
      dsp: data['disp'] ?? "",
     
    );
  }
}
