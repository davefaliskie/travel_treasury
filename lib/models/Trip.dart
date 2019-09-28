class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  Map budgetTypes;
  String travelType;


  Trip(
      this.title,
      this.startDate,
      this.endDate,
      this.budget,
      this.budgetTypes,
      this.travelType
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
    'budget': budget,
    'budgetTypes': budgetTypes,
    'travelType': travelType,
  };
}

