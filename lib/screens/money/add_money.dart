import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spotmii/widgets.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/custom_form.dart';
import '../../components/text.dart';
import '../../database.dart';
import 'package:path_provider/path_provider.dart';

class Provider{
  final image;
  final String text;
  final String type;
  Provider({required this.image,required this.text,required this.type});
}

class CashInStore extends StatefulWidget {
  const CashInStore({super.key});

  @override
  State<CashInStore> createState() => _CashInStoreState();
}

class _CashInStoreState extends State<CashInStore> {
  bool showList = false;
  Provider selected = Provider(image: const Icon(Icons.shopping_bag), text: "Merchant Store",type: "store");
  var amountController = TextEditingController();
  List<Provider> provList = [
    Provider(
        image: const CircleAvatar(
          backgroundImage: NetworkImage("https://play-lh.googleusercontent.com/sG15qNhfx0Rc746q2416LCozt7wCoHI-VcwohvvLwZfp2fRFPCx7zysZrlNpmIaEvQ=w240-h480-rw"),
        ),
        text: "ANZ – Australia and New Zealand Banking Group",type: "bank"),
    Provider(
        image: const CircleAvatar(
          backgroundImage: NetworkImage("https://play-lh.googleusercontent.com/sG15qNhfx0Rc746q2416LCozt7wCoHI-VcwohvvLwZfp2fRFPCx7zysZrlNpmIaEvQ=w240-h480-rw"),
        ),
        text: "TEST – Australia and New Zealand Banking Group",type: "bank"),
  ];
  Widget myListTile(Provider prov,index){
    return GestureDetector(
      onTap: (){
        setState(() {
          provList.removeAt(index);
          provList.add(selected);
          selected = prov;
          //provList[index] = selected;
        });

      },
      child: Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(offset: const Offset(0,2),blurRadius: 2,color: Colors.grey.withOpacity(0.5))
              ]
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: Row(
            children: [
              prov.image,
              const SizedBox(width: 10,),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.60,
                child: MyWidgets.text(prov.text, 17, FontWeight.bold, const Color(0xff111111), context, false),
              )
            ],
          )
      ),
    );
  }
  Widget myListTileButton(Provider prov){
    return GestureDetector(
      onTap: (){
        setState(() {
          showList = !showList;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: const Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(10)
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Row(
          children: [
            Icon(!showList ? Icons.expand_circle_down : Icons.cancel,size: 25,),
            const SizedBox(width: 10,),
            prov.image,
            const SizedBox(width: 10,),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.55,
              child: MyWidgets.text(prov.text, 17, FontWeight.bold, const Color(0xff111111), context, false),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Top Up", context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            FractionallySizedBox(widthFactor: 0.85,child: CustomFormWidget(controller: amountController,),),
            const SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              alignment: Alignment.centerLeft,
              child: MyWidgets.text("Choose Account", 20, FontWeight.bold, const Color(0xff111111), context, false),
            ),
            const SizedBox(height: 20,),
            myListTileButton(selected),
            const SizedBox(height: 20,),
            AnimatedOpacity(
              opacity: showList ? 1 : 0,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(seconds: 1),
              child: Visibility(
                visible: showList,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.40,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provList.length,
                      itemBuilder: (context,index){
                        return  myListTile(provList[index],index);
                      },
                    )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              child: MyWidgets.text("Please choose where to get your money.", 16, FontWeight.normal, const Color(0xff111111), context, false),
            ),
            const SizedBox(height: 20,),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: MyWidgets.button("Add Money", ()async{

                int amount = amountController.text == "" ? 0 : int.parse(amountController.text.trim());
                if(amount > 0){
                  var response = await Database(url:url).send({
                    "req" : "topuprequest",
                    "amount" : amountController.text,
                    "currency" : selectedCurrency,
                    "user" : currentUser!.userID,
                    "type" : "cashin",
                    "merchant" : "store",
                  });
                  if(selected.type == "store"){
                    MyWidgets.navigateP(TopUpMerchant(transaction: response, amount: amountController.text,currency: selectedCurrency,), context);
                  }else if(selected.type  == "bank"){
                    showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                )
                            ),
                            height: MediaQuery.of(context).size.height* 0.4,
                            child: Center(
                              child: Image.asset("assets/underconstruction.png",height: 250,),
                            ),
                          );
                        }
                    );
                  }else if(selected.type == "card"){
                    showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                )
                            ),
                            height: MediaQuery.of(context).size.height* 0.4,
                            child: Center(
                              child: Image.asset("assets/underconstruction.png"),
                            ),
                          );
                        }
                    );
                  }
                }else{
                  MyWidgets.message("Amount cannot be 0 or less", context);
                }

              }, const Color(0xff04123B), context),
            )
          ],
        ),
      ),
    );
  }
}

//merchant store top up qr

class TopUpMerchant extends StatefulWidget {
  final String transaction;
  final String amount;
  final String currency;

  const TopUpMerchant({super.key, required this.transaction,required this.amount,required this.currency});

  @override
  State<TopUpMerchant> createState() => _TopUpMerchantState();
}

class _TopUpMerchantState extends State<TopUpMerchant> {
  final ScreenshotController screenshotController = ScreenshotController();
  Widget myBorder(){
    return Container(margin:const EdgeInsets.only(right: 2.5),width: 5,height: 3,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("Top Up - Scan Me", context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Screenshot(
              controller: screenshotController,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color(0xff04123B),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    SizedBox(
                      width: 225,
                      height: 225,
                      child: QrImageView(
                        backgroundColor: const Color(0xff04123B),
                        // ignore: deprecated_member_use
                        foregroundColor: Colors.white,
                        data: widget.transaction,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    MyWidgets.text(widget.currency + widget.amount, 50, FontWeight.bold, Colors.white, context, false),
                    MyWidgets.text("Amount", 20, FontWeight.bold, Colors.white, context, false),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),
                        myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),myBorder(),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    MyWidgets.text("Go to the nearest partner store to continue!", 16, FontWeight.bold, Colors.white, context, false),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      await screenshotController.capture(delay: const Duration(milliseconds: 20)).then((Uint8List? image)async{
                        String fileName = "Screenshot_${DateTime.now().microsecondsSinceEpoch}";
                        if (image != null) {
                          final result = await ImageGallerySaver.saveImage(image,name: fileName);
                          if(result["isSuccess"]){
                            MyWidgets.message("Success", context);
                            //fix diaglog
                          }else{
                            MyWidgets.message("failed", context);
                          }
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.file_download_outlined),
                        const SizedBox(width: 5,),
                        MyWidgets.text("Download", 20, FontWeight.bold, const Color(0xff04123B), context, false)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((Uint8List? image) async {
                        if (image != null) {
                          final directory = await getApplicationDocumentsDirectory();
                          final imagePath = await File('${directory.path}/image.png').create();
                          await imagePath.writeAsBytes(image);
                          await Share.shareFiles([imagePath.path]);
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.share_rounded),
                        const SizedBox(width: 5,),
                        MyWidgets.text("Share QR", 20, FontWeight.bold, const Color(0xff04123B), context, false)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
