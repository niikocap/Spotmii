import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotmii/components/appBar.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../database.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(title:"Notifications",size:MF(20,context),context: context).create(),
      body: SizedBox(
        width: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: Database(url:url).send({
            "req" : "getNotifications",
            "user" : currentUser!.userID,
          }),
          builder: (context,AsyncSnapshot snapshot){

            if(snapshot.hasData){
              List data = jsonDecode(snapshot.data);
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return MyWidgets.notification(data[index]["notif_message"], data[index]["notif_sender"], data[index]["notif_date"], context, "");
                  },
                ),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),                //child: MyWidgets.notification("hello everyone", "- admin", "10-12-2024", context, "aaa"),
              );
            }
          },
        )
      ),
    );
  }
}
