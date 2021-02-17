class SavingModel {
  String userId;
  DateTime savingDate;
  int amount;
  String status;

  SavingModel(this.userId, this.savingDate, this.amount, this.status);

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "savingDate": savingDate,
        "amount": amount,
        "status": status
      };

  SavingModel.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        savingDate = DateTime.parse(map['savingDate'].toDate().toString()),
        amount = map['amount'],
        status = map['status'];
}
