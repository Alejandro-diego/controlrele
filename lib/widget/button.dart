import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NeuButton extends StatelessWidget {
  NeuButton(
      {Key? key,
      this.onTap,
      this.onLongPress,
      this.isEnable = false,
      this.eventStatus = false,
      required this.isButtonPressed,
      required this.title,
      required this.cupertinoIcon})
      : super(key: key);

  final String title;
  final dynamic onLongPress;
  bool isEnable  ;
  bool eventStatus ;

  final dynamic onTap;
  final IconData cupertinoIcon;

  bool isButtonPressed;

  IconData volOff = const IconData(0xf785,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);
  IconData volOn = const IconData(0xf785,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: isEnable ? onTap : () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 70.0,
        width: size.width * .80,
        decoration: BoxDecoration(
          border: Border.all(
              color: !isButtonPressed
                  ? const Color.fromARGB(255, 49, 45, 45)
                  : Colors.grey.shade900),
          color: Colors.black.withOpacity(.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: !isButtonPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: const Offset(6, 6),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(-6, -6),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: size.width * .6,
              child: Icon(
                !isButtonPressed ? cupertinoIcon : cupertinoIcon,
                size: !isButtonPressed ? 35 : 40,
                color: !isButtonPressed
                    ? Colors.grey[800]
                    : const Color.fromARGB(255, 85, 255, 85),
              ),
            ),
            Positioned(
              left: 10.0,
              top: 10,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: !isButtonPressed ? 12 : 15,
                    color: isEnable
                        ? (!isButtonPressed ? Colors.green : Colors.white)
                        : Colors.black),
              ),
            ),
            Positioned(
                left: 10.0,
                bottom: 10,
                child: Icon(                  
                  Icons.access_time,size: 17,
                  color: eventStatus ? Colors.red : Colors.grey.shade900,
                )),
          ],
        ),
      ),
    );
  }
}
