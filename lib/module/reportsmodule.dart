// ignore_for_file: non_constant_identifier_names

class ReportModule {
  String location, crime_discription,user_name;
  DateTime occurenceTime;
  bool medicalAssistance;
  ReportModule(
      {
      
      required this.user_name,  
      required this.crime_discription,
      required this.location,
      required this.medicalAssistance,
      required this.occurenceTime});
}
