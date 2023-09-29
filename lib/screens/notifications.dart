import 'package:flutter/material.dart';
import 'package:spotmii/components/appBar.dart';
import 'package:spotmii/main.dart';
import '../components/constants.dart';
import '../database.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: Database(url:url).send({
            "req" : "getNotification",
            "user" : currentUser!.userID,
          }),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    return Container(
                      //todo backend
                    );
                  },
                ),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }
}
