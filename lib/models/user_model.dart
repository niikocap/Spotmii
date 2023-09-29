class SpotMiiUser{
  final String userID,username,fname,lname,email,verifyStatus,number,twoFactor,userPic,country,zipcode,birthday,nationality,gender,address,type,currency;
  final double balance,usd,php,eur,gbp,chf,cny,aud,jpy;
  SpotMiiUser({
    required this.currency,required this.userID,required this.username,required this.fname,required this.lname,required this.balance,required this.email,required this.verifyStatus,required this.number,required this.twoFactor,required this.userPic,required this.country,required this.zipcode,required this.birthday,required this.nationality,required this.gender,required this.address,required this.type, required this.usd,required this.php,required this.eur,required this.gbp, required this.chf,required this.cny,required this.aud,required this.jpy,
  });
  factory SpotMiiUser.convert(json){
    return SpotMiiUser(
      userID:json["id"],username: json["username"], fname: json["fname"], lname: json["lname"], balance: double.parse('${json["balance"]}'), email: json["email"], verifyStatus:json["verify_status"], number:json["number"], twoFactor: json["2fa"], userPic: json["picture"], country: json["country"], zipcode: json["zipcode"], birthday: json["birthday"], nationality: json["nationality"], gender: json["gender"], address: json["address"], type: json["type"], currency: json["currency"], usd:  double.parse('${json["usd"]}'), php:  double.parse('${json["php"]}'), eur:  double.parse('${json["eur"]}'), gbp:  double.parse('${json["gbp"]}'), chf:  double.parse('${json["chf"]}'), cny:  double.parse('${json["cny"]}'), aud:  double.parse('${json["aud"]}'), jpy:  double.parse('${json["jpy"]}'),
    );

  }
}