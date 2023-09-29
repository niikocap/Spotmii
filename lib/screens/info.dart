import "package:flutter/material.dart";
import 'package:spotmii/screens/home.dart';
import 'package:spotmii/widgets.dart';
import 'package:search_choices/search_choices.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Terms of Use", context),
      backgroundColor: Colors.white,
      body: Container(

      ),
    );
  }
}

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Privacy Policy", context),
      backgroundColor: Colors.white,
      body: Container(

      ),
    );
  }
}

class TalkToOurTeam extends StatefulWidget {
  const TalkToOurTeam({Key? key}) : super(key: key);

  @override
  State<TalkToOurTeam> createState() => _TalkToOurTeamState();
}

class _TalkToOurTeamState extends State<TalkToOurTeam> {
  int issue = 0;
  List titles = ["Transfer hasn't arrive yet","I sent the money to the wrong bank details","I want to cancel this transfer",""];
  body(index,context){
    List body = [
      Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        child: Text(
          "If your transfer is taking longer than expected, we recommend waiting 2 working days. Sometimes your recipient’s bank takes extra time to process your transfer. \n\n After 2 working days: \n\n \u2022 Check your recipient’s details are correct \n \u2022 Download your transfer receipt and share it with your recipient’s bank. They can use this to look for the transfer.",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: MF(18,context),
              fontWeight: FontWeight.normal
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        child: Text(
          "Sometimes, transfers get delayed because there's a mistake in the recipient's details.\n\nWhen this happens, some banks can still process the transfer, but it takes a little longer for them to match it to the right account.\n\nOther times, they'll send the money back to us — you can send it again, or cancel and refund your transfer",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: MF(18,context),
              fontWeight: FontWeight.normal
          ),
        ),
      ),
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "Once your transfer has been sent to your recipient — it can’t be cancelled.",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "Why can’t I cancel?",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "The money has already left our account, and we can’t get it back.",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "What if I was scammed?",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "We rely on you to trust who you’re sending money to — so we can’t get involved in disputes between senders and recipients. But, you can let us know and we’ll investigate and prevent this for the future.",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "What can I do next?  ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              "You can send your transfer receipt to your recipient, and ask them to reject the payment back to us. If we receive the money back, we’ll let you know.",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MF(18,context),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
        ],
      )
    ];
    return body[index];
  }

  var selectedValueSingleDialog = 0;
  createSolution(issue){
    return issue == 0 ? Container() : Container(
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              child: MyWidgets.text(titles[issue-1], 19, FontWeight.bold, Color(0xff3B4652),context,false),
            ),
            SizedBox(height: 20,),
            body(issue-1,context),
            SizedBox(height: 30,),
            issue != 2 ?
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width*0.6,
              child: MyWidgets.button("Download Receipt", (){}, Color(0xff04123B),context),
            ) : SizedBox(height: 5,),
            SizedBox(height: 5,),
            TextButton(
              onPressed: (){
                MyWidgets.navigateP(SomethingElse(), context);
              },
              child: Text(
                "I still need help",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: "Poppins",
                  fontSize: MF(18, context),
                  color: Color(0xff04123B),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Talk to our Team", context),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(padding:EdgeInsets.all(10),alignment:Alignment.centerLeft,child: MyWidgets.text("Select an Issue", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)),
            SearchChoices.single(
              items: [
                DropdownMenuItem(
                  child: MyWidgets.text("Transfer hasn't arrived yet", 18.0, FontWeight.normal, Color(0xff3B4652),context,false),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: MyWidgets.text("I sent the money to the wrong bank details", 18.0, FontWeight.normal, Color(0xff3B4652),context,false),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: MyWidgets.text("I want to cancel this transfer", 18.0, FontWeight.normal, Color(0xff3B4652),context,false),
                  value: 3,
                ),
                DropdownMenuItem(
                  child: MyWidgets.text("Something else", 18.0, FontWeight.normal, Color(0xff3B4652),context,false),
                  value: 4,
                ),
              ],
              onChanged: (value) {
                setState(() {
                  if(value != 4){
                    issue = value;
                    selectedValueSingleDialog = value;
                  }else{
                    MyWidgets.navigateP(SomethingElse(), context);
                  }
                  
                });
              },
              value: selectedValueSingleDialog,
              hint: "Select an Issue",
              dialogBox: true,
              isExpanded: true,
            ),
            createSolution(issue),
          ],
        ),
      )
      /*Container(
        child: Column(
          children: [
            MyWidgets.text("Select an Issue", 17.0, FontWeight.bold, Color(0xff3B4652)),
            MyWidgets.text("Transfer hasn't arrived yet", 17.0, FontWeight.normal, Color(0xff3B4652)),
            MyWidgets.text("I sent the money to the wrong bank details", 17.0, FontWeight.normal, Color(0xff3B4652)),
            MyWidgets.text("I want to cancel this transfer", 17.0, FontWeight.normal, Color(0xff3B4652)),
            MyWidgets.text("Something else", 17.0, FontWeight.normal, Color(0xff3B4652)),
          ],
        ),
      )
       */
    );
  }
}

class SomethingElse extends StatefulWidget {
  const SomethingElse({Key? key}) : super(key: key);

  @override
  State<SomethingElse> createState() => _SomethingElseState();
}

class _SomethingElseState extends State<SomethingElse> {
  var subject = TextEditingController();
  var description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Talk to our Team", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              child: MyWidgets.text("Tell us more", 21, FontWeight.bold, Color(0xff3B4652),context,false),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              child: MyWidgets.text("Tell us as much as you can about the problem, and we'll be in touch soon.", 16, FontWeight.normal, Color(0xff3B4652),context,false),
            ),
            SizedBox(height: 10,),
            MyWidgets.transaction(AssetImage("assets/10.png"), "Soa Palelei", "Bank Transfer", "- \$ 2,000", "25 March 2023", context,{
              "who":"Soa Palelei",
              "howmuch":"-\$ 2000",
              "transaction":"****1214",
              "account":"145***1",
            }),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffE4E4E6),
              ),

              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: subject,
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Subject",
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  hintStyle: TextStyle(
                      color: Color(0xff3B4652),
                      fontSize: 15
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              child: MyWidgets.text("Give as much detail as you can", 16, FontWeight.normal, Color(0xff3B4652),context,false),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE4E4E6),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description',
                ),
                autofocus: false,
                maxLines: null,
                controller: description,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyWidgets.button("Sign Up",(){
                MyWidgets.navigatePR(MyWidgets.congratulation("We've got your email","Check your email for our response. It usually takes up to 1 working day for us to answer.", (){
                  MyWidgets.navigateP(Home(), context);
                },context,"Home"), context);
              },Color(0xff0A1B4D),context),
            )
          ],
        )
      ),
    );
  }
}
 class Talk2Team extends StatefulWidget {
   const Talk2Team({Key? key}) : super(key: key);

   @override
   State<Talk2Team> createState() => _Talk2TeamState();
 }

 class _Talk2TeamState extends State<Talk2Team> {
   @override
   Widget build(BuildContext context) {
     return const Placeholder();
   }
 }
