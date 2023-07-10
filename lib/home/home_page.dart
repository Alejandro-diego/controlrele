import 'package:controlrele/write/write.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/providerdata.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import '../widget/button.dart';
import 'ble_home_page.dart';
import 'event_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _disp = TextEditingController();
  //var list = List<int>.generate(30, (i) => 0 + i);
  var list = [0xf4B6, 0xf785, 0xf6cb];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RelayControl'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.support_agent,
                    ),
                    Text(" Whatsapp")
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.bluetooth,
                    ),
                    Text(" Add Disp")
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                    ),
                    Text(" LogOut")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                          controller: _disp,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Restore',
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 2),
                              child: Icon(
                                Icons.cloud,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                    ),
                    Text(" Event")
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: OverflowBox(
        maxHeight: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/picante.jpg"), fit: BoxFit.fill),
          ),
          child: Center(
            child: Consumer<ProviderRTDB>(
              builder: (context, data, child) {
                return data.datosProvider != null
                    ? Center(
                        child: SizedBox(
                          height: 550,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  NeuButton(
                                    eventStatus: data.relay1!.event,
                                    isEnable: data.relay1!.isEnable,
                                    title: data.relay1!.alliasName,
                                    isButtonPressed: data.relay1!.relay1,
                                    onTap: () {
                                      _db
                                          .child(
                                              'data${data.datosProvider!.dsp}')
                                          .child("Relay1")
                                          .update(
                                              {'relay1': !data.relay1!.relay1});
                                    },
                                    onLongPress: () {
                                      HapticFeedback.mediumImpact();

                                      _dispN2(
                                          "Relay1",
                                          "isEnable",
                                          "alliasName",
                                          "dataIcon",
                                          data.relay1!.isEnable);
                                    },
                                    cupertinoIcon: IconData(
                                        data.relay1!.dataIcon,
                                        fontFamily: CupertinoIcons.iconFont,
                                        fontPackage:
                                            CupertinoIcons.iconFontPackage),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  NeuButton(
                                    eventStatus:data.relay2!.event ,
                                    isEnable: data.relay2!.isEnable,
                                    onLongPress: () {
                                      HapticFeedback.mediumImpact();
                                      _dispN2(
                                          "Relay2",
                                          "isEnable",
                                          "alliasName",
                                          "dataIcon",
                                          data.relay2!.isEnable);
                                    },
                                    title: data.relay2!.alliasName,
                                    isButtonPressed: data.relay2!.relay2,
                                    onTap: () {
                                      _db
                                          .child(
                                              'data${data.datosProvider!.dsp}')
                                          .child("Relay2")
                                          .update(
                                              {'relay2': !data.relay2!.relay2});
                                    },
                                    cupertinoIcon: IconData(
                                        data.relay2!.dataIcon,
                                        fontFamily: CupertinoIcons.iconFont,
                                        fontPackage:
                                            CupertinoIcons.iconFontPackage),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  NeuButton(
                                    onLongPress: () {
                                      HapticFeedback.mediumImpact();
                                      _dispN2(
                                          "Relay3",
                                          "isEnable",
                                          "alliasName",
                                          "dataIcon",
                                          data.relay3!.isEnable);
                                    },
                                    isEnable: data.relay3!.isEnable,
                                    title: data.relay3!.alliasName,
                                    isButtonPressed: data.relay3!.relay3,
                                    onTap: () {
                                      _db
                                          .child(
                                              'data${data.datosProvider!.dsp}')
                                          .child("Relay3")
                                          .update(
                                              {'relay3': !data.relay3!.relay3});
                                    },
                                    cupertinoIcon: IconData(
                                        data.relay3!.dataIcon,
                                        fontFamily: CupertinoIcons.iconFont,
                                        fontPackage:
                                            CupertinoIcons.iconFontPackage),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  NeuButton(
                                    onLongPress: () {
                                      HapticFeedback.mediumImpact();
                                      _dispN2(
                                          "Relay4",
                                          "isEnable",
                                          "alliasName",
                                          "dataIcon",
                                          data.relay4!.isEnable);
                                    },
                                    isEnable: data.relay4!.isEnable,
                                    title: data.relay4!.alliasName,
                                    isButtonPressed: data.relay4!.relay4,
                                    onTap: () {
                                      _db
                                          .child(
                                              'data${data.datosProvider!.dsp}')
                                          .child("Relay4")
                                          .update(
                                              {'relay4': !data.relay4!.relay4});
                                    },
                                    cupertinoIcon: IconData(
                                        data.relay4!.dataIcon,
                                        fontFamily: CupertinoIcons.iconFont,
                                        fontPackage:
                                            CupertinoIcons.iconFontPackage),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 100,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black.withOpacity(.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                            "Estado do Dispositivo    : "),
                                        data.datosProvider!.status
                                            ? const Text("OnLine",
                                                style: TextStyle(
                                                    color: Colors.greenAccent))
                                            : const Text(
                                                "OffLine",
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            "Numero do Dispositivo  : ${data.datosProvider!.dsp}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Center(child: Text("Add Dispo Bluethooth"));
              },
            ),
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(_goToBle());
        break;
      case 2:
        await FirebaseAuth.instance.signOut();
        FlutterExitApp.exitApp();
        break;
      case 3:
        SharedPreferences preference = await SharedPreferences.getInstance();
        preference.setString("disp", _disp.text);
        Write().restoreDB(_disp.text);

        // Timer.periodic(const Duration(seconds: 6), (timer) {
        //   Restart.restartApp();
        // });
        break;
      case 4:
        Navigator.of(context).push(_goToEvent());
        break;
    }
  }

  void _dispN2(String reles, String isEnableChild, String alliasName,
      String dataIcon, bool isEnableInitBool) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<ProviderRTDB>(
          builder: (context, data, child) {
            return data.datosProvider != null
                ? AlertDialog(
                    scrollable: true,
                    backgroundColor: Colors.black.withOpacity(.7),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _db
                                .child('data${data.datosProvider!.dsp}')
                                .child(reles)
                                .update({alliasName: _nameController.text});
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Saves Name and Icon',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                    title: Text(reles),
                    content: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: OutlineInputBorder(),
                                labelText: 'Nome',
                              ),
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese Nome';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  value: isEnableInitBool,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isEnableInitBool = value!;
                                      _db
                                          .child(
                                              "data${data.datosProvider!.dsp}")
                                          .child(reles)
                                          .update({
                                        isEnableChild: value,
                                        reles.toLowerCase(): false
                                      });
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 60,
                                  width: 180,
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: 1),
                                      itemExtent: 64,
                                      children: list
                                          .map(
                                            (dataIcon) => RotatedBox(
                                              quarterTurns: 3,
                                              child: Icon(
                                                IconData(dataIcon,
                                                    fontFamily:
                                                        CupertinoIcons.iconFont,
                                                    fontPackage: CupertinoIcons
                                                        .iconFontPackage),
                                                size: 30,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onSelectedItemChanged: (index) async {
                                        setState(() {
                                          _db
                                              .child(
                                                  "data${data.datosProvider!.dsp}")
                                              .child(reles)
                                              .update({dataIcon: list[index]});
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CupertinoActivityIndicator(),
                  );
          },
        );
      },
    );
  }

  restoreRTDB() {}
}

Route _goToBle() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const BleHomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _goToEvent() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const EventHome(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
