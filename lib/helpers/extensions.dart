


import 'package:shadcn_ui/shadcn_ui.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String toFormattedTimeString() {
    return DateFormat('hh:mm a').format(this);
  }

  String toFormattedDateTimeString() {
    return DateFormat('dd/MM/yyyy hh:mm a').format(this);
  }

  String toFormattedTimeString24() {
    return DateFormat('HH:mm').format(this);
  }

  String toFormatedDayCountdown() {
    final now = DateTime.now();
    final difference = this.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours - (days * 24);
    final minutes = difference.inMinutes - (days * 24 * 60) - (hours * 60);
    return '$days days, $hours hours, $minutes minutes';
  }

  String toFormattedDayCountdownShort() {
    final now = DateTime.now();
    final difference = this.difference(now);
    final days = difference.inDays;
    if (days == 0) {
      return 'Today';

    }
 
    if (days == -1) {
      return 'Yesterday';
    }
    if (days < 0) {
      return '${days.abs()} days ago';
    }
    if(days < -3){
      return '$days days ago';
    }
    if(days < 3){
      return 'In $days days';
    }
    return '$days days';
  }
}