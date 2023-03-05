import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class uploadTimeFormat extends StatelessWidget {
  final DateTime uploadTime = DateTime(2022, 2, 23, 10, 0, 0); // replace with your upload time

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(uploadTime);

    if (difference.inDays == 1) {
      return Text('Yesterday');
    } else if (difference.inDays > 1) {
      final formatter = DateFormat('MMM d, yyyy');
      final formattedDate = formatter.format(uploadTime);
      return Text(formattedDate);
    } else if (difference.inHours >= 1) {
      return Text('${difference.inHours} hours ago');
    } else if (difference.inMinutes >= 1) {
      return Text('${difference.inMinutes} minutes ago');
    } else {
      return Text('Just now');
    }
  }
}