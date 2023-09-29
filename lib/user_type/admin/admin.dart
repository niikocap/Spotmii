import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Admin Home", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      MyWidgets.text("Requests :", 25, FontWeight.bold, Color(0xff111111), context, false),
                      SizedBox(width: 10,),
                      MyWidgets.text("0", 25, FontWeight.bold, Color(0xff111111), context, false),
                    ],
                  ),
                  Row(
                    children: [
                      MyWidgets.text("Tickets :", 25, FontWeight.bold, Color(0xff111111), context, false),
                      SizedBox(width: 10,),
                      MyWidgets.text("0", 25, FontWeight.bold, Color(0xff111111), context, false),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                MyWidgets.navigateP(KYCRequests(), context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,0),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.groups,size: 30,color: Colors.green,),
                    SizedBox(width: 20,),
                    MyWidgets.text("KYC Requests", 20, FontWeight.bold, Color(0xff111111), context, false),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                MyWidgets.navigateP(Tickets(), context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,0),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.confirmation_num,size: 30,color: Colors.green,),
                    SizedBox(width: 20,),
                    MyWidgets.text("Tickets", 20, FontWeight.bold, Color(0xff111111), context, false),
                  ],
                ),
              ),
            ),
            //ticket count
            //button to show kyc requst
            //button to show ticket
          ],
        ),
      ),
    );
  }
}

class KYCRequests extends StatefulWidget {
  const KYCRequests({super.key});

  @override
  State<KYCRequests> createState() => _KYCRequestsState();
}

class _KYCRequestsState extends State<KYCRequests> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class KYCView extends StatefulWidget {
  const KYCView({super.key});

  @override
  State<KYCView> createState() => _KYCViewState();
}

class _KYCViewState extends State<KYCView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Tickets extends StatefulWidget {
  const Tickets({super.key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar1("Tickets", context),
      body: Container(
        child: Center(
          child: Image.asset("assets/underconstruction.png",height: 200,),
        ),
      ),
    );
  }
}

class TicketsView extends StatefulWidget {
  const TicketsView({super.key});

  @override
  State<TicketsView> createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}