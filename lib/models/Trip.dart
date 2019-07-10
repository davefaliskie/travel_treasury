class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  String travelType;


  Trip(
      this.title,
      this.startDate,
      this.endDate,
      this.budget,
      this.travelType
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
    'budget': budget,
    'travelType': travelType,
  };
}

