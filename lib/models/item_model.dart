import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
  });

  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;

  String daysLeft() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String releaseDateFormatted() {
    initializeDateFormatting('pl', null);
    return DateFormat.yMMMMEEEEd('pl').format(releaseDate);
  }
}
