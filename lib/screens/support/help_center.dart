import 'package:flutter/material.dart';
import 'package:spotmii/screens/support/live_chat.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../home.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  var subject = TextEditingController();
  var description = TextEditingController();
  bool chatBool = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Help Center", context),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.centerLeft,
                child: MyWidgets.text("Hi, how can we help you?", 21.0, FontWeight.bold, const Color(0xff3B4652),context,false),
              ),
              const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tell us as much as you can about the problem, and we'll be in touch soon.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: MF(17,context),
                    color: const Color(0xff3B4652)
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffE4E4E6),
                ),

                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: subject,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Subject",
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    hintStyle: TextStyle(
                        color: const Color(0xff3B4652),
                        fontSize: MF(18, context),
                        fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.centerLeft,
                child: MyWidgets.text("Give as much detail as you can", 17.0, FontWeight.normal, const Color(0xff3B4652),context,false),
              ),
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffE4E4E6),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(
                        color: const Color(0xff3B4652),
                        fontSize: MF(18, context),
                        fontFamily: "Poppins"
                    )
                  ),
                  autofocus: false,
                  maxLines: null,
                  controller: description,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 40,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                child: MyWidgets.button("Submit",(){
                  MyWidgets.navigatePR(MyWidgets.congratulation("We've got your email","Check your email for our response. It usually takes up to 1 working day for us to answer.", (){
                    MyWidgets.navigateP(const Home(), context);
                  },context,"Home"), context);
                },const Color(0xff0A1B4D),context),
              ),


            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          MyWidgets.navigateP(const LiveChat(), context);
        },
        backgroundColor: const Color(0xff0A1B4D),
        child: const Icon(Icons.messenger),
      ),
    );
  }
}
