import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:spotmii/main.dart';
import 'package:spotmii/models/transaction.dart';
import '../models/user_model.dart';

class Database{
  final String url;
  Database({required this.url});
  Future<String> send(credential) async  {
    final response  = await http.post(
        Uri.parse(url),
        body: credential,
    );
    return response.body;
  }
  updateUser()async{
    final response  = await http.post(
      Uri.parse(url),
      body: {
        "req" : "getUser",
        "id" : currentUser!.userID,
      },
    );
    currentUser = SpotMiiUser.convert(jsonDecode(response.body)[0]);
    //rates = await conversionRates(currentUser!.currency)["result"];
  }
  imageSend(File image,File image1,File image2,fname,lname,address,country,zip,number,docType,gender,birthday)async{
    var img = image.path.split('/');
    var img1 = image1.path.split('/');
    var img2 = image2.path.split('/');
    String imageName = img[img.length-1];
    String imageName1 = img1[img1.length-1];
    String imageName2 = img2[img2.length-1];
    FormData formData = new FormData.fromMap({
      "id" : currentUser!.userID,
      "req": "verifyAccount",
      "fname": fname,
      "lname": lname,
      "address": address,
      "country": country,
      "zip": zip,
      "number": number,
      "docType": docType,
      "birthday" : birthday,
      "gender" : gender,
      "frontPic": await MultipartFile.fromFile(image.path,filename: imageName),
      "backPic": await MultipartFile.fromFile(image1.path,filename: imageName1),
      "selfie": await MultipartFile.fromFile(image2.path,filename: imageName2),
    });
    Response response = await Dio().post(url,data: formData);
    return response;
  }
  check(what,value)async{
    final response  = await http.post(
      Uri.parse(url),
      body: {
        "req" : "check",
        "what" : what,
        "target" : value
      },
    );
    return response.body;
  }
  static convertCurrency(from,to,amount)async{
    final response  = await http.get(
      Uri.parse("https://api.exchangerate.host/convert?from=${from}&to=${to}&amount=${amount}"),
    );
    return jsonDecode(response.body)["result"];
  }
  sendSMS(message,to)async{
    var uname = 'AC832d226c331da9c46854123395a13f0f';
    var pword = '72c5ec707249f658786c89861e2cab0f';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': authn,
    };

    var data = {
      'To': to,
      'From': '+14065180679',
      'Body': message,
    };

    var url = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/AC832d226c331da9c46854123395a13f0f/Messages.json');
    var res = await http.post(url, headers: headers, body: data);
    //if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
  }

  getTransaction(){
    List<TransactionObj> transactions = [];
    return transactions;
  }
}