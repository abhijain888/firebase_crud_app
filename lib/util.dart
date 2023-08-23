import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

String formatTimestamp(Timestamp timestamp) {
  var format = DateFormat('y-M-d hh:mm a'); // <- use skeleton here
  return format.format(timestamp.toDate());
}
