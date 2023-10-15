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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      MyWidgets.text("Requests :", 25, FontWeight.bold, const Color(0xff111111), context, false),
                      const SizedBox(width: 10,),
                      MyWidgets.text("0", 25, FontWeight.bold, const Color(0xff111111), context, false),
                    ],
                  ),
                  Row(
                    children: [
                      MyWidgets.text("Tickets :", 25, FontWeight.bold, const Color(0xff111111), context, false),
                      const SizedBox(width: 10,),
                      MyWidgets.text("0", 25, FontWeight.bold, const Color(0xff111111), context, false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                MyWidgets.navigateP(const KYCRequests(), context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0,0),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                ),
                child: Row(
                  children: [
                    const Icon(Icons.groups,size: 30,color: Colors.green,),
                    const SizedBox(width: 20,),
                    MyWidgets.text("KYC Requests", 20, FontWeight.bold, const Color(0xff111111), context, false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                MyWidgets.navigateP(const Tickets(), context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0,0),
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.5)
                      )
                    ]
                ),
                child: Row(
                  children: [
                    const Icon(Icons.confirmation_num,size: 30,color: Colors.green,),
                    const SizedBox(width: 20,),
                    MyWidgets.text("Tickets", 20, FontWeight.bold, const Color(0xff111111), context, false),
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
      body: Center(
        child: Image.asset("assets/underconstruction.png",height: 200,),
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