import '../components/constants.dart';

class Currency{
  static getSymbol(value){
    if(value.toString().toUpperCase() == "PHP"){
      return "P";
    }else if(value.toString().toUpperCase() == "USD"){
      return "\$";
    }else if(value.toString().toUpperCase() == "EUR"){
      return "€";
    }else if(value.toString().toUpperCase() == "JPY"){
      return "€";
    }else if(value.toString().toUpperCase() == "GBP"){
      return "£";
    }else if(value.toString().toUpperCase() == "CHF"){
      return "Fr";
    }else if(value.toString().toUpperCase() == "AUD"){
      return "A\$";
    }else if(value.toString().toUpperCase() == "CNY"){
      return "C¥";
    }
  }
  static getCode(value){
    var cur = "";
    if(value == 'Philippine Peso'){
      cur = "PHP";
    }else if(value == 'US Dollar'){
      cur = "USD";
    }else if(value == 'Euro'){
      cur = "EUR";
    }else if(value == 'Pound'){
      cur = "GBP";
    }else if(value == 'Australian Dollar'){
      cur = "AUD";
    }else if(value == 'Swiss Franc'){
      cur = "CHF";
    }else if(value == 'Chinese Yuan'){
      cur = "CNY";
    }else if(value == 'Japanese Yen'){
      cur = "JPY";
    }
    return cur;
  }
  static getLocale(value){
    var cur = "";
    if(value == 'Philippine Peso'){
      cur = "en_PH";
    }else if(value == 'US Dollar'){
      cur = "en_US";
    }else if(value == 'Euro'){
      cur = "es";
    }else if(value == 'Pound'){
      cur = "en_GB";
    }else if(value == 'Australian Dollar'){
      cur = "en_AU";
    }else if(value == 'Swiss Franc'){
      cur = "de_CH";
    }else if(value == 'Chinese Yuan'){
      cur = "zh_CN";
    }else if(value == 'Japanese Yen'){
      cur = "ja_JP";
    }
    return cur;
  }
  static getText(value){
    var cur = "";
    if(value == 'PHP'){
      cur = "Philippine Peso";
    }else if(value == '\$'){
      cur = "US Dollar";
    }else if(value == '€'){
      cur = "Euro";
    }else if(value == '£'){
      cur = "Pound";
    }else if(value == 'A\$'){
      cur = "Australian Dollar";
    }else if(value == 'Fr'){
      cur = "Swiss Franc";
    }else if(value == 'C¥'){
      cur = "Chinese Yuan";
    }else if(value == '¥'){
      cur = "Japanese Yen";
    }
    return cur;
  }
  static getEstimated(rates,String currency){
    double estimated = 0;
    Map cur = {"usd" : rates["USD"],"jpy" : rates["JPY"],"cny" : rates["CNY"],"gpb" : rates["GBP"],"eur" :rates["EUR"],"aud" : rates["AUD"],"php" : rates["PHP"],"chf" :rates["CHF"]};
    Map curr = {"usd" : currentUser!.usd,"jpy" : currentUser!.jpy,"cny" : currentUser!.cny,"gpb" : currentUser!.gbp,"eur" :currentUser!.eur,"aud" : currentUser!.aud,"php" : currentUser!.php,"chf" :currentUser!.chf};
    cur.forEach((key, value) {
      if(key != "eur"){
       estimated += (curr[key] * (cur[currency] / value));
      }else{
        estimated += curr[key] * 1;
      }
    });
    return estimated;
  }
}