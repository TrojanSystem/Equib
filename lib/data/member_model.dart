class MembersModel {
  String name;
  String phoneNumber;
  int equibQuantity;
  String price;

  MembersModel({
    required this.name,
    required this.price,
    required this.phoneNumber,
    required this.equibQuantity,
  });
}

class EquibModel {
  String collectorName;
  String phoneNumber;
  DateTime startDate;
  DateTime endDate;
  String every;

  EquibModel({
    required this.phoneNumber,
    required this.collectorName,
    required this.endDate,
    required this.every,
    required this.startDate,
  });
}
