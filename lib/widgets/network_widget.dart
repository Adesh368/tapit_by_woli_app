import 'package:flutter/material.dart';

class NetworkWidget extends StatelessWidget {
  const NetworkWidget({required this.image, required this.text,super.key});

  final String image;
  final String text;
  //final void Function( network) onSelect;
  @override
  Widget build(BuildContext context) {
    //final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return InkWell(
      //onTap: onSelect,
      child: Card(
        child: Padding(
            padding: const EdgeInsets.only(right: 120,bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(image),
               const SizedBox(width: 20,),
                Text(text,),
              ],
            )),
      ),
    );
  }
}
