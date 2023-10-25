class TransactionObj {
  final String type;
  final String note;
  final String amount;
  final String date;
  final String sign;
  final String currency;
  TransactionObj(
      {required this.type,required this.currency,required this.amount,required this.date,required this.note,required this.sign});
  factory TransactionObj.convert(json){
    return TransactionObj(
      type: json["ts_type"],
      currency: json["ts_currency"],
      amount: json["ts_amount"],
      date: json["ts_date"],
      sign: json["ts_pn"],
      note: json["ts_note"]
    );
  }
}