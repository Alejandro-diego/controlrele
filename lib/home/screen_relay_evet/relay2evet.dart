import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/providerdata.dart';
import '../../utils.dart';
import '../../widget/day_button.dart';

class Relay2Event extends StatefulWidget {
  const Relay2Event({Key? key}) : super(key: key);

  @override
  State<Relay2Event> createState() => _Relay2EventState();
}

class _Relay2EventState extends State<Relay2Event> {
  final _db = FirebaseDatabase.instance.ref();
  late List<String> dias = ["D", "S", "T", "Q", "Q", "S", "S"];
  late String listTrue = '[true, true, true, true, true, true, true]';
  late String listFalse = '[false, false, false, false, false, false, false]';

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderRTDB>(builder: (context, data, child) {
    
      return data.relay2 != null
          ? Container(
              margin: const EdgeInsets.all(6),
              height: 210,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          data.relay2!.alliasName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.deepOrangeAccent),
                        ),
                      ),
                      Row(
                        children: [
                   CupertinoSwitch(
                              activeColor: const Color.fromARGB(255, 49, 255, 56), 
                            
                              value: data.relay2!.event,
                              onChanged: (bool a) {
                                _db
                                    .child('data${data.datosProvider!.dsp}')
                                    .child('Relay2')
                                    .update({'event': a});
                              }),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        child: Text(
                          "  Ligar: ${data.relay2!.initTime}      ",
                          style: const TextStyle(
                              color: Colors.yellow, fontSize: 18),
                        ),
                        onPressed: () async {
                          TimeOfDay? initTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                            if (initTime == null) return;

                          final now = DateTime.now();
                          final time = DateTime(now.year, now.month, now.day,
                              initTime.hour, initTime.minute);

                          _db
                              .child('data${data.datosProvider!.dsp}')
                              .child('Relay2')
                              .update(
                            {'initTime': Utils.toTime(time)},
                          );
                        },
                      ),
                      Row(
                        children: [
                          const Text('Tudos os Dias'),
                          Checkbox(
                            checkColor: Colors.black,
                            value: data.relay2!.allDay,
                            onChanged: (bool? value) {
                              value!
                                  ? _db
                                      .child("data${data.datosProvider!.dsp}")
                                      .child('Relay2')
                                      .update({
                                      'daysInit': listTrue,
                                      'daysEnds': listTrue,
                                      'allDay': value
                                    })
                                  : _db
                                      .child("data${data.datosProvider!.dsp}")
                                      .child('Relay2')
                                      .update({
                                      'daysInit': listFalse,
                                      'daysEnds': listFalse,
                                      'allDay': value
                                    });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dias.length,
                        itemBuilder: (context, index) {
                          var listOfDayBoll = json
                              .decode(data.relay2!.daysInit)
                              .cast<bool>()
                              .toList();

                          return DayButton(
                              isButtonPress: listOfDayBoll[index],
                              dia: dias[index],
                              onClicked: () {
                                listOfDayBoll[index] = !listOfDayBoll[index];
                                actualizarDays('Relay2',
                                    data.datosProvider!.dsp, listOfDayBoll);
                              });
                        }),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: Text(
                      "  Desligar: ${data.relay2!.endTime}",
                      style:
                          const TextStyle(color: Colors.yellow, fontSize: 18),
                    ),
                    onPressed: () async {
                      TimeOfDay? endTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                             if (endTime == null) return;

                      final now = DateTime.now();
                      final time = DateTime(now.year, now.month, now.day,
                          endTime.hour, endTime.minute);

                      _db
                          .child('data${data.datosProvider!.dsp}')
                          .child('Relay2')
                          .update({'endTime': Utils.toTime(time)});
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: dias.length,
                        itemBuilder: (context, index) {
                          var listEndDayBoll = json
                              .decode(data.relay2!.daysEnds)
                              .cast<bool>()
                              .toList();

                          return DayButton(
                              isButtonPress: listEndDayBoll[index],
                              dia: dias[index],
                              onClicked: () {
                                listEndDayBoll[index] = !listEndDayBoll[index];
                                actualizarEndeDays('Relay2',
                                    data.datosProvider!.dsp, listEndDayBoll);
                              });
                        }),
                  ),
                ],
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(),
            );
    });
  }

  actualizarDays(String reles, String dsp, List listadedias) {
    _db
        .child('data$dsp')
        .child(reles)
        .update({'daysInit': listadedias.toString()});
  }

  actualizarEndeDays(String reles, String dsp, List listadedias1) {
    _db
        .child('data$dsp')
        .child(reles)
        .update({'daysEnds': listadedias1.toString()});
  }
}
