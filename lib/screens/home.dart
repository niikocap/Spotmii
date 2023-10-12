import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotmii/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:spotmii/components/featureIcons.dart';
import 'package:spotmii/main.dart';
import 'package:spotmii/screens/profile.dart';
import 'package:spotmii/screens/qrscanner.dart';
import 'package:spotmii/screens/request_money.dart';
import 'package:spotmii/screens/transaction.dart';
import 'package:spotmii/screens/underconstruction.dart';
import 'package:spotmii/widgets.dart';
import '../blocs/home_cubit/home_cubit.dart';
import '../components/constants.dart';
import '../models/currency.dart';
import '../database.dart';
import 'account.dart';
import 'cashin.dart';
import 'currency.dart';
import 'money.dart';
import 'package:forex_conversion/forex_conversion.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String balance = "${Currency.getSymbol(currentUser!.currency)} 1";
  String realBalance = "\$ ${currentUser!.balance.toStringAsFixed(2)}";
  bool listenerAdded = false;
  //bool isVisible = false; //use for send again
  //bool isHidden = false; //use for balance showing
  //bool featureOn = false;
  double listSize = 0; //dragsheetsize
  double containerSize = 0;
  List<CW> cwList = [
    CW(amount: currentUser!.usd, currencyText: "US Dollar", directory: "assets/flags/usd.png"),
    CW(amount: currentUser!.php, currencyText: "Philippine Peso", directory: "assets/flags/php.png"),
    CW(amount: currentUser!.jpy, currencyText: "Japanese Yen", directory: "assets/flags/jpy.png"),
    CW(amount: currentUser!.cny, currencyText: "Chinese Yuan", directory: "assets/flags/cny.png"),
    CW(amount: currentUser!.chf, currencyText: "Swiss Franc", directory: "assets/flags/chf.png"),
    CW(amount: currentUser!.eur, currencyText: "Euro", directory: "assets/flags/eur.png"),
    CW(amount: currentUser!.gbp, currencyText: "Pound", directory: "assets/flags/gbp.png"),
    CW(amount: currentUser!.aud, currencyText: "Australian Dollar", directory: "assets/flags/aud.png"),
  ];
  DraggableScrollableController _dragScroll = DraggableScrollableController();
  //late double dragSize = ( MediaQuery.of(widget.context).size.height * 0.6 ) - 6.4;
  Future<List> loadTransaction()async{
    var response = await Database(url: url).send({
      "req" : "transaction",
      "uid" : currentUser!.userID
    });
    return jsonDecode(response);
  }
  @override
  void initState() {
    super.initState();
  }
  getRates(currency)async{
    rates = await Database(url: url).send(
        {
          "req" : "getRates",
        }
    );
    rates = jsonDecode(jsonDecode(rates))["rates"];
    final fx = Forex();
    return rates;
  }
  @override
  Widget build(BuildContext context) {
    //dragSize = isVisible ? (MediaQuery.of(context).size.height * 0.35) : (MediaQuery.of(context).size.height * 0.575) - 170;
    var h1 = (MediaQuery.of(context).size.height * 0.575) + 15 - MediaQuery.of(context).viewPadding.top - MediaQuery.of(context).viewPadding.bottom;
    var padding = MediaQuery.of(context).viewPadding.bottom;
    var selectedImage = currentUser!.userPic != "" ? NetworkImage("https://app.spotmii.com.au/uploads/" + currentUser!.userPic) : NetworkImage("https://digitalfinger.id/wp-content/uploads/2019/12/no-image-available-icon-6.png");
    currencyWidget(amount,type,image){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2.5),
        margin: EdgeInsets.symmetric(horizontal: 2.5),
        width: 112.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(image),radius: 15,),
            SizedBox(width: 5,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyWidgets.text(amount.toString(),21, FontWeight.normal, Color(0xff111111), context, true),
                SizedBox(
                  width: 60,
                  child: Text(
                    type,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: MF(14, context),
                      fontFamily: "Poppins",
                      color: Color(0xff111111),

                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xff050E29),
      body: BlocProvider(
        create:(context) {
          var a = HomeCubit();
          a.changeDragSize(h1 + padding + 50);
          return a;
        },
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Color(0xff050E29),
            child: Column(
              children: [
                BlocBuilder<HomeCubit,HomeState>(
                  builder: (context,state){
                    return Container(
                      color: Color(0xff050E29),
                      height: state.estimatedSwitch ? MediaQuery.of(context).size.height * 0.35 - 15 : MediaQuery.of(context).size.height * 0.35 - 65 ,
                      child: Column(
                        children: [
                          Container(
                            height:120,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Stack(
                              children: [
                                Positioned(
                                  top:15,
                                  child: MyWidgets.text("SpotMii", 45, FontWeight.bold, Colors.white,context,false),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 25,
                                  child: GestureDetector(
                                    onTap: (){
                                      MyWidgets.navigateP(EditProfile(), context);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: selectedImage,
                                      radius: 30,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * .9,
                                    height: 20,
                                    child: BlocBuilder<HomeCubit,HomeState>(
                                        builder: (context,state) {
                                          return Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.9,
                                            child: Row(
                                                children: [
                                                  MyWidgets.text("Estimated Balance", 18.0,
                                                      FontWeight.normal, Colors.white, context,
                                                      false),
                                                  IconButton(
                                                    onPressed: () {

                                                      if(!state.estimatedSwitch && state.isVisible){
                                                        print("both on");
                                                        context.read<HomeCubit>().changeDragSize(h1-padding-111);
                                                      }else if(!state.estimatedSwitch){
                                                        print("ES SWITCH");
                                                        context.read<HomeCubit>().changeDragSize(h1-padding);
                                                      }else if(state.isVisible && state.estimatedSwitch){
                                                        print("IsVisible");
                                                        context.read<HomeCubit>().changeDragSize(h1-padding-61);
                                                      }else{
                                                        print("Both off");
                                                        context.read<HomeCubit>().changeDragSize(h1-padding+50);
                                                      }
                                                      context.read<HomeCubit>().esSwitch();
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    icon: Image.asset(
                                                      state.estimatedSwitch ? "assets/scroll_up.png" : "assets/drop_down.png",
                                                      height: 15,
                                                    ),
                                                  )
                                                ]
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ), ///Estimated Balance and button
                                Positioned(
                                  top :90,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child: FutureBuilder(
                                        future: getRates(currentUser!.currency),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData){
                                            var data = snapshot.data as Map;
                                            double estimated = Currency.getEstimated(data, currentUser!.currency);
                                            balance = "${Currency.getSymbol(currentUser!.currency)} ${estimated.toStringAsFixed(4)}";
                                            realBalance =  balance;
                                            return BlocBuilder<HomeCubit,HomeState>(
                                                builder: (context,state){
                                                  return Row(
                                                    children: [
                                                      MyWidgets.text(balance, 35, FontWeight.normal, Colors.white,context,false),
                                                      SizedBox(width: 10,),
                                                      IconButton(
                                                        padding: EdgeInsets.zero,
                                                        constraints: BoxConstraints(),
                                                        onPressed: ()async{
                                                          int length = balance.length;
                                                          balance = "*";
                                                          context.read<HomeCubit>().hiddenSwitch();
                                                          if(state.isHidden){
                                                            for(int i=0;i<length-1;i++){
                                                              balance += "*";
                                                            }
                                                          }else{
                                                            balance = realBalance;
                                                          }
                                                        },
                                                        icon: Icon(state.isHidden? Icons.visibility_off:Icons.remove_red_eye_outlined,color: Colors.white,size: 22,),
                                                      ),
                                                    ],
                                                  );
                                                }
                                            );

                                          }else{
                                            return Text("");
                                          }

                                        }
                                    ),

                                  ),
                                ), ///balance
                              ],
                            ),
                          ), ///Spotmii Title
                          SizedBox(height: 5,),
                          BlocBuilder<HomeCubit,HomeState>(
                            builder: (context,state){
                              return Visibility(
                                visible: state.estimatedSwitch,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cwList.length,
                                    itemBuilder: (context,index){
                                      cwList.sort((a, b) => b.amount.compareTo(a.amount));
                                      return currencyWidget(cwList[index].amount, cwList[index].currencyText, cwList[index].directory);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 17.5,),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 90,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    MyIcons.feature("assets/figma/send_money.png", (){
                                      MyWidgets.navigateP(Send(), context);
                                    }, Color(0xFF04123B), "Send Money",Colors.white, context),
                                    MyIcons.feature("assets/figma/add_money.png", (){
                                      MyWidgets.navigateP(CashInStore(), context);
                                    }, Color(0xFF04123B), "Add Money",Colors.white, context),
                                    MyIcons.feature("assets/figma/bank_transfer.png", (){
                                      MyWidgets.navigateP(UnderConstruction(title: "Bank Transfer"), context);
                                    }, Color(0xFF04123B), "Add Money",Colors.white, context),
                                    MyIcons.feature("assets/figma/bills_payment.png", (){
                                      MyWidgets.navigateP(UnderConstruction(title: "Bills Payment"), context);
                                    }, Color(0xFF04123B), "Bills Payment",Colors.white, context),
                                    MyIcons.feature("assets/figma/show_more.png", (){
                                      showModalBottomSheet(context: context,isScrollControlled: true,barrierColor: Colors.black.withOpacity(0), builder: (context){
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: ( MediaQuery.of(context).size.height * 0.65 ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                height: 3,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff8A8A8A).withOpacity(0.5),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),

                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                                  width:MediaQuery.of(context).size.width * 0.9,
                                                  alignment:Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      MyWidgets.text("My Favorites", 25,FontWeight.bold, Color(0xFF434343), context,false),
                                                    ],
                                                  )
                                              ),
                                              FutureBuilder(
                                                future: Database(url: url).send({
                                                  "req" : "getFavorites"
                                                }),
                                                builder: (context,AsyncSnapshot<String> snapshot){
                                                  if(snapshot.hasData){
                                                    List data = jsonDecode(snapshot.data!);
                                                    return Container(
                                                      width: MediaQuery.of(context).size.width * 0.95,
                                                      height: 70,
                                                      child: GridView.count(
                                                        padding: EdgeInsets.zero,
                                                        primary: false,
                                                        childAspectRatio: 0.9,
                                                        crossAxisSpacing: 1,
                                                        mainAxisSpacing: 1,
                                                        crossAxisCount: 5,
                                                        children: <Widget>[
                                                          ListView.builder(
                                                            itemCount: data.length + 1,
                                                            itemBuilder: (context,index){
                                                              if(data!.length == index){
                                                                return MyIcons.feature("assets/figma/add_favorites.png", (){
                                                                  MyWidgets.message("Feature to be added", context);
                                                                }, Color(0xFFd6d6d6).withOpacity(0.2), "Add Favorites",Color(0xff111111), context);
                                                              }else{
                                                                return MyIcons.feature(data[index]["fav_image"], (){
                                                                  //todo create a redirector
                                                                }, Color(0xFF04123B), data[index]["fav_name"],Color(0xff111111), context);
                                                              }

                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }else{
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 40,),
                                              Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                                  width:MediaQuery.of(context).size.width * 0.9,
                                                  alignment:Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      MyWidgets.text("Features", 25,FontWeight.bold, Color(0xFF434343), context,false),
                                                    ],
                                                  )
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.95,
                                                height: ( MediaQuery.of(context).size.height * 0.40 ),
                                                child: GridView.count(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  childAspectRatio: 0.9,
                                                  crossAxisSpacing: 1,
                                                  mainAxisSpacing: 1,
                                                  crossAxisCount: 5,
                                                  children: <Widget>[
                                                    MyIcons.feature("assets/figma/send_money.png", (){
                                                      MyWidgets.navigateP(Send(), context);
                                                    }, Color(0xFF04123B), "Send Money", Color(0xff111111),context),
                                                    MyWidgets.feature(Image.asset('assets/6.png'), "Add Money", () {
                                                      MyWidgets.navigateP(CashInStore(), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/7.png'), "Bank Transfer", () {
                                                      MyWidgets.navigateP(UnderConstruction(title: "Bank"), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/8.png'), "Remittance", () {
                                                      MyWidgets.navigateP(UnderConstruction(title: "Remittance"), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/request.png'), "Request", () {
                                                      MyWidgets.navigateP(RequestMoney(), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/44.png'), "My Cards", () {
                                                      MyWidgets.navigateP(LinkAccounts(), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/42.png'), "Currency", () {
                                                      MyWidgets.navigateP(LiveCurrency(), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/41.png'), "Converter", () {
                                                      MyWidgets.navigateP(ConvertMoney(), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/43.png'), "QR Code", () {
                                                      MyWidgets.navigateP(QRScanner(), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/43.png'), "Bills Payment", () {
                                                      MyWidgets.navigateP(UnderConstruction(title: "Bills Payment"), context);
                                                    },Colors.black,context),
                                                    MyWidgets.feature(Image.asset('assets/withdraw.png'), "Withdraw", () {
                                                      MyWidgets.navigateP(Withdraw(), context);
                                                    },Colors.black,context),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    }, Color(0xFF04123B), "Show More",Colors.white, context),
                                  ]
                              )
                          ),

                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<HomeCubit,HomeState>(
                  builder: (context,state){
                    return Visibility(
                      visible: state.isVisible,
                      child: Container(
                        height: ( MediaQuery.of(context).size.height * 0.13 ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                alignment:Alignment.centerLeft,
                                child: MyWidgets.text("Send Again", 16.0, FontWeight.bold, Colors.white, context,false)
                            ),
                            SizedBox(height: 5,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 60,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [

                                  MyWidgets.sendAgain(
                                        (){
                                      //recipient.text = "12456789";
                                    },
                                    NetworkImage("https://i.pravatar.cc/299"),
                                  ),
                                  MyWidgets.sendAgain(
                                        (){
                                      //recipient.text = "12456789";
                                    },
                                    NetworkImage("https://i.pravatar.cc/298"),
                                  ),
                                  MyWidgets.sendAgain(
                                        (){
                                      //recipient.text = "12456789";
                                    },
                                    NetworkImage("https://i.pravatar.cc/301"),
                                  ),MyWidgets.sendAgain(
                                        (){
                                      //recipient.text = "12456789";
                                    },
                                    NetworkImage("https://i.pravatar.cc/302"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<HomeCubit,HomeState>(
                  builder: (context,state){
                    return SizedBox(
                      height: state.dragSize,
                      child: DraggableScrollableSheet(
                        maxChildSize: 1,
                        minChildSize: 0.80,
                        snapSizes: [0.8,1],
                        snap: true,
                        initialChildSize: 1,
                        controller: _dragScroll,
                        builder: (BuildContext context, ScrollController scrollController) {
                          if(!listenerAdded){
                            //listenerAdded = true;
                            _dragScroll.addListener((){

                              if(state.estimatedSwitch){
                                print(_dragScroll.size);
                                if(_dragScroll.size == 1){
                                  context.read<HomeCubit>().changeDragSize(h1-padding);
                                  context.read<HomeCubit>().visibleSwitch(false);
                                }else if(_dragScroll.size <= 0.85){
                                  print("0.81");
                                  context.read<HomeCubit>().changeDragSize(h1 -padding- 111);
                                  context.read<HomeCubit>().visibleSwitch(true);
                                  _dragScroll.jumpTo(0.99999);
                                }
                              }else{
                                if(_dragScroll.size == 1){
                                  context.read<HomeCubit>().changeDragSize(h1-padding+50);
                                  context.read<HomeCubit>().visibleSwitch(false);
                                }else if(_dragScroll.size <= 0.81){
                                  context.read<HomeCubit>().changeDragSize(h1 - 61);
                                  context.read<HomeCubit>().visibleSwitch(true);
                                  _dragScroll.jumpTo(0.99999);
                                }else if(_dragScroll.size == 0.80){
                                  context.read<HomeCubit>().changeDragSize(h1 - 61);
                                  context.read<HomeCubit>().visibleSwitch(true);
                                  _dragScroll.jumpTo(0.99999);
                                }
                              }
                            });
                          }
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),
                            ),
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              controller: scrollController,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 150),
                                  width: 75,
                                  height: 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(99),
                                      color: Colors.grey[500]!.withOpacity(0.7)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyWidgets.text("Activities", 18.0, FontWeight.bold, Color(0xff111111),context,false),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: (){
                                            MyWidgets.navigateP(Transaction(), context);
                                          },
                                          icon: Image.asset("assets/viewall.png"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                BlocBuilder<HomeCubit,HomeState>(
                                  builder: (context,state){
                                    listSize = state.isVisible ? (MediaQuery.of(context).size.height * 0.35) : (MediaQuery.of(context).size.height * 0.575) - 170;
                                    return  SizedBox(
                                      height: listSize + 90,
                                      child: BlocBuilder<TransactionBloc,TransactionState>(
                                          builder: (context,state){

                                            if(state is TransactionLoading){
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                            if(state is TransactionLoaded){
                                              if(state.transactions.length > 0){
                                                return ListView.builder(
                                                  itemCount: state.transactions.length,
                                                  itemBuilder: (context,index){
                                                    return MyWidgets.transaction(AssetImage('assets/10.png'), state.transactions[index].from, state.transactions[index].type, state.transactions[index].amount, state.transactions[index].date, context, state.transactions[index].receiver);
                                                  },
                                                );
                                              }else{
                                                return Center(
                                                  child: Container(
                                                    height: listSize,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height:130,
                                                          child: Image.asset("assets/notransactions.png"),
                                                        ),
                                                        SizedBox(height:10),
                                                        MyWidgets.text("No Transactions Yet!", 22, FontWeight.bold, Color(0xff111111), context, false)
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }

                                            }else{
                                              return Text("Something Went Wrong");
                                            }
                                          }),
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                ),
                MyWidgets.myBottomBar(context,0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
double bannerHeight = 200;

class CW{
  final amount;
  final currencyText;
  final directory;
  CW({required this.amount,required this.currencyText,required this.directory});
}