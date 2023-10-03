class TransactionObj {
  final String type;
  final String receiver;
  final String? from;
  final String amount;
  final String date;
  TransactionObj(
      {required this.type,required this.receiver,this.from,required this.amount,required this.date});
  factory TransactionObj.convert(json){
    return TransactionObj(
      type: json["ts_type"],
      receiver: json["ts_to"],
      from: json["ts_by"],
      amount: json["ts_amount"],
      date: json["ts_date"],
    );
  }
}