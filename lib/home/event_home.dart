
import 'package:controlrele/home/screen_relay_evet/relay1evet.dart';
import 'package:controlrele/home/screen_relay_evet/relay2evet.dart';
import 'package:controlrele/home/screen_relay_evet/relay3evet.dart';
import 'package:controlrele/home/screen_relay_evet/relay4evet.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


class EventHome extends StatefulWidget {
  const EventHome({Key? key}) : super(key: key);

  @override
  State<EventHome> createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  
 
  @override
  void initState() {
    initializeDateFormatting();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
      ),
      body: const SingleChildScrollView(
     child:
             Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Relay1Event(),
                    Relay2Event(),
                    Relay3Event(),
                    Relay4Event(),
                  ],
                ),
              )
          
      ),
    );
  }

 
}
