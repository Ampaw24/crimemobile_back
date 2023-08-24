import 'package:intl/intl.dart';

class NewsModule {
  String title, discription, image_url, author;
  DateTime date;
  NewsModule({
    required this.title,
    required this.discription,
    required this.image_url,
    required this.author,
    required this.date,
  });

  get FormattedTime{
  DateTime dateTime = DateTime.now();
  DateFormat timeFormat = DateFormat('HH:mm:ss');

  // Format the DateTime object to get only the time
  String formattedTime = timeFormat.format(dateTime);
   return formattedTime;
 
  }
}
