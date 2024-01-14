import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';
class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontweight;
  final alignment;
  const OpenSans(
      {super.key,
      this.text,
      this.size,
      this.fontweight,
      this.color,
      this.alignment});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == null ? TextAlign.center : alignment,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color == null ? Colors.white : color,
        fontWeight: fontweight == null ? FontWeight.normal : fontweight,
      ),
    );
  }
}

DialogBox(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      title: OpenSans(
        text: title,
        size: 20.0,
        color: Colors.black,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: OpenSans(
            text: "Ok",
            size: 20.0,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}

TextEditingController _name = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _phone = TextEditingController();
TextEditingController _address = TextEditingController();

//Add Data To FireStore
class AddDataFireStore {
  CollectionReference respose = FirebaseFirestore.instance.collection('Orders');
  Future addResponse(
      final name,
      final email,
      final number,
      final address,
      final orderedCakes,
      final currentstatus,
      final orderSize,
      final totalPrice,
      bool orderAccepted,
      bool prepared,
      bool outForDelivery,
      bool delivered) async {
    return respose
        .add({
          'Name': name,
          'Email': email,
          'Number': number,
          'Address': address,
          'OrderDetails': orderedCakes,
          'currentStatus': currentstatus,
          'order_id': 'B.TechCKW${name.toString().substring(0, 2) + number}',
          "status": {
            "orderAccepted": orderAccepted,
            "prepared": prepared,
            "outForDelivery": outForDelivery,
            "delivered": delivered,
          },
          'orderSize': orderSize,
          'totalPrice': totalPrice
        })
        .then((value) => true)
        .catchError(
          (error) {
            return false;
          },
        );
  }
}

class TextForm extends StatefulWidget {
  final text;
  final containerWidhth;
  final hinttext;
  final controller;
  final validator;
  final initialvalue;
  final Function(String text) onChanged;
  const TextForm(
      {super.key,
      required this.text,
      required this.containerWidhth,
      required this.hinttext,
      this.controller,
      this.validator,
      required this.onChanged,
      this.initialvalue});
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: widget.containerWidhth,
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            initialValue: widget.initialvalue,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: widget.hinttext,
            ),
          ),
        )
      ],
    );
  }
}
