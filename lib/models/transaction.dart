class TransactionObj {
  final String type;
  final String receiver;
  final String? to;
  final String amount;
  final String date;
  TransactionObj(
      {required this.type,required this.receiver,this.to,required this.amount,required this.date});
  factory TransactionObj.convert(json){
    return TransactionObj(
      type: json["type"],
      receiver: json["receiver"],
      to: json["to"],
      amount: json["amount"],
      date: json["date"],
    );
  }
}