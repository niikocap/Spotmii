import 'dart:io';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:spotmii/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../components/constants.dart';
import 'package:file_picker/file_picker.dart';
import '../database.dart';
import '../models/localauth.dart';
import 'home.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var addressController = TextEditingController();
  var countryController = TextEditingController();
  var zipCodeController = TextEditingController();
  var numberController = TextEditingController();
  var passwordController = TextEditingController();
  var birthdayController = TextEditingController();
  //var genderController = TextEditingController();
  var frontImage;
  var backImage;
  var selfieImage;
  var code = "";
  final countryPicker  = const FlCountryCodePicker(
    showDialCode: false,
  );
  String dropdownvalue = 'Passport';
  String genderValue = 'Male';
  Future<File> getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    return file;
  }
  Future<File> getImage1() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    File file = File(image!.path);
    return file;
  }
  // List of items in our dropdown menu
  var items = [
    'Passport',
    'Drivers License',
    'National ID',
    'Bank Account Statement',
  ];
  var items1 = [
    'Male',
    'Female',
  ];
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      appBar: MyWidgets.appbar("KYC Verification", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        children: [
                          Align(
                              alignment:Alignment.centerLeft,
                              child: MyWidgets.text("First name", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                            height: 40,
                            child: MyWidgets.textFormField(fNameController, "First name", Color(0xff3B4652),(value){
                              if(value == null){
                                return "First Name cannot be empty";
                              }
                            },context),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        children: [
                          Align(
                              alignment:Alignment.centerLeft,
                              child: MyWidgets.text("Last name", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                            height: 40,
                            child: MyWidgets.textFormField(lNameController, "Last name", Color(0xff3B4652),(value){
                              if(value == null){
                                return "First Name cannot be empty";
                              }
                            },context),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Full Address", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    height: 40,
                    child:  MyWidgets.textFormField(addressController, "Full Address", Color(0xff3B4652),(value){
                      if(value == null){
                        return "First Name cannot be empty";
                      }
                    },context),
                  )

                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Select Country", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: 40,
                          child:  TextField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: countryController,
                            decoration: InputDecoration(
                                isCollapsed: true,
                              hintText: "Select Country",
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              prefixIcon: IconButton(
                                color: Color(0xff3B4652),
                                onPressed: ()async{
                                  final code1 = await countryPicker.showPicker(context: context);
                                  setState(() {
                                    countryController.text = code1!.name;
                                    code = code1.dialCode;
                                  });
                                },
                                icon: Icon(Icons.flag),
                              ),
                              hintStyle: TextStyle(
                                  fontSize: MF(18, context),
                                  fontFamily: "Poppins",
                                  color: Color(0xff3B4652)
                              ),
                            ),
                            style: TextStyle(
                                fontSize: MF(18, context),
                                fontFamily: "Poppins",
                                color: Color(0xff3B4652)
                            ),
                          )
                        )

                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Zip Code", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          height: 40,
                          child:  MyWidgets.textFormField(controller, "Zip Code", Color(0xff3B4652),(value){
                            if(value == null){
                              return "First Name cannot be empty";
                            }
                          },context),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Mobile Number", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 40,
                    child:  TextField(
                      controller: numberController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        isCollapsed: true,
                        hintText: "Enter Mobile Number",
                        prefixText: code + " | ",
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: MF(18, context),
                          color: Color(0xff3B4652)
                        )
                      ),
                    )
                  )

                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Birthdate", 17.0, FontWeight.bold, Color(0xff3B4652),context,false)
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          height: 40,
                          child:  TextField(
                            enabled: true,
                            controller: birthdayController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                isCollapsed: true,

                              hintText: "Select Date",
                              prefixIcon: IconButton(
                                color: Color(0xff04123B),
                                onPressed: ()async{
                                  var date = await showDatePicker(context: context, initialDate: DateTime(2010), firstDate: DateTime(1960), lastDate: DateTime(2010));
                                  setState(() {
                                    birthdayController.text = date.toString().split(" ")[0];
                                  });
                                },
                                icon: Icon(Icons.calendar_month_rounded,color: Color(0xff3B4652),),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:  BorderSide(color: Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              hintStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: MF(18, context),
                                color: Color(0xff3B4652)
                              )
                            ),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: MF(18, context),
                                color: Color(0xff3B4652)
                            ),
                          )
                        )

                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Gender", 17.0, FontWeight.bold, Color(0xff04123B),context,false)
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),

                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:  BorderSide(color: Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            // Initial Value
                            value: "Male",
                            borderRadius: BorderRadius.circular(15),
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: MF(18,context),
                              color: Color(0xff3B4652)
                            ),
                            // Array list of items
                            items: items1.map((String items1) {
                              return DropdownMenuItem(
                                value: items1,
                                child: Text(items1),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                genderValue = newValue!;
                              });
                            },
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              
              width: MediaQuery.of(context).size.width * 0.85,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: Color(0xff3B4652), width: 1.5,),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3B4652), width: 1.5,),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // Initial Value
                value: "Passport",
                borderRadius: BorderRadius.circular(15),
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                style: TextStyle(
                  fontSize: MF(18, context),
                  fontFamily: "Poppins",
                  color:Color(0xff3B4652)
                ),
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.bottomLeft,
                      child: MyWidgets.text("Upload ID type for verification", 16.0, FontWeight.normal, Color(0xff3B4652),context,false)
                  ),
                  Visibility(
                    visible: dropdownvalue != 'Bank Account Statement',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              color: Colors.red,
                              child: IconButton(
                                iconSize: 120,
                                onPressed: () async {
                                  frontImage = await getImage();
                                  setState(() {

                                  });
                                },
                                icon: Image.asset("assets/28.png"),
                              ),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width * 0.40),
                              height: backImage != null || frontImage != null ? 100 : 30,
                              child:  frontImage == null ? Column(children: [Text("Front ID Image")],) : Column(
                                children: [
                                   GestureDetector(
                                       onTap: (){
                                         showDialog(
                                             context: context,
                                             builder: (context){
                                               return Column(
                                                 children: [
                                                   SizedBox(height: 10,),
                                                   SizedBox(
                                                     height: 40,
                                                     width:MediaQuery.of(context).size.width * 0.85,
                                                     child: MyWidgets.button("Close", (){
                                                       Navigator.pop(context);
                                                     }, Colors.redAccent, context),
                                                   ),
                                                   SizedBox(height: 10,),
                                                   Container(
                                                     child: Image.file(File(frontImage.path),fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.85,),
                                                   ),


                                                 ],
                                               );
                                             }
                                         );
                                       },
                                       child: MyWidgets.text(frontImage.path.split("/")[frontImage.path.split("/").length-1], 15, FontWeight.normal, Color(0xff111111), context,false)
                                   ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          frontImage = null;
                                        });
                                      },
                                      child: MyWidgets.text("REMOVE", 19, FontWeight.normal, Colors.red, context,false),
                                    ),
                                  )
                                ],
                              ) ,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width * 0.40),
                              child: IconButton(
                                iconSize: (MediaQuery.of(context).size.width * 0.40),
                                onPressed: () async {
                                  backImage = await getImage();
                                  setState(() {

                                  });
                                },
                                icon: Image.asset("assets/29.png"),
                              ),
                            ),
                            Container(
                              height: backImage != null || frontImage != null ? 100 : 30,
                              width: (MediaQuery.of(context).size.width * 0.40),
                              child: backImage == null ? Column(children: [Text("Back ID Image")],) : Column(
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return Column(
                                                children: [
                                                  SizedBox(height: 10,),
                                                  SizedBox(
                                                    height: 40,
                                                    width:MediaQuery.of(context).size.width * 0.85,
                                                    child: MyWidgets.button("Close", (){
                                                      Navigator.pop(context);
                                                    }, Colors.redAccent, context),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    child: Image.file(File(backImage.path),fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.85,),
                                                  ),


                                                ],
                                              );
                                            }
                                        );
                                      },
                                      child: MyWidgets.text(backImage.path.split("/")[backImage.path.split("/").length-1], 15, FontWeight.normal, Color(0xff111111), context,false)
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          backImage = null;
                                        });
                                      },
                                      child: MyWidgets.text("REMOVE", 19, FontWeight.normal, Colors.red, context,false),
                                    ),
                                  )
                                ],
                              ) ,

                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: dropdownvalue == 'Bank Account Statement',
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: MyWidgets.button("Upload Bank Statement", ()async{
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowMultiple: false,
                              allowedExtensions: ['jpg', 'pdf','jpeg','webp',],
                            );
                            if (result != null) {
                              selfieImage = File(result.files.single.path!);
                            } else {
                              // User canceled the picker
                            }
                          }, Color(0xff04123B), context),
                        ),
                        SizedBox(height: 10,),
                        MyWidgets.text("We accept PDF, PNG, WEBP, JPEG", 15, FontWeight.normal, Color(0xff111111), context,false),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.center,
                      child: MyWidgets.text("Upload Selfie Holding your ID for verification", 16.0, FontWeight.normal, Color(0xff3B4652),context,false)
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 40,
                    child: MyWidgets.button("Take a selfie now", ()async{
                      selfieImage = await getImage1();
                      setState(() {

                      });

                    }, Color(0xff04123B),context),
                  ),
                  SizedBox(height: 5,),
                  selfieImage == null ? Text("") : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (context){
                                return Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      height: 40,
                                      width:MediaQuery.of(context).size.width * 0.85,
                                      child: MyWidgets.button("Close", (){
                                        Navigator.pop(context);
                                      }, Colors.redAccent, context),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      child: Image.file(File(selfieImage.path),fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.85,),
                                    ),


                                  ],
                                );
                              }
                            );
                          },
                          child: MyWidgets.text("VIEW SELFIE", 19, FontWeight.normal, Colors.green, context,false),
                        ),
                      ),
                      //MyWidgets.text(selfieImage.path.split("/")[selfieImage.path.split("/").length-1], 15, FontWeight.normal, Color(0xff111111), context),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              selfieImage = null;
                            });
                          },
                          child: MyWidgets.text("REMOVE SELFIE", 19, FontWeight.normal, Colors.red, context,false),
                        ),
                      )
                    ],
                  ) ,
                ],
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 40,
              child: MyWidgets.button("Submit", ()async{
                final isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Send Verify Request!");

                if (isAuthenticated) {

                  showDialog(barrierDismissible:false,context: context, builder: (context){
                    return MyWidgets.showLoading();
                  });

                  var response = await Database(url:url).imageSend(frontImage,backImage,selfieImage,fNameController.text,lNameController.text,addressController.text,countryController.text,zipCodeController.text,numberController.text,dropdownvalue,genderValue,birthdayController.text);
                  print(response);
                  if(response == "\"success\""){
                    Navigator.pop(context);
                    showModalBottomSheet(

                        context: context, builder: (context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            )
                        ),
                        child: Column(
                            children: [
                              SizedBox(height:10,),
                              Container(height: 5,width:50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(99),color: Colors.grey)),
                              SizedBox(height:10),
                              IconButton(
                                icon: Icon(Icons.warning_rounded,color: Colors.amber,),
                                iconSize: 125,
                                onPressed: () {},
                              ),
                              SizedBox(height:10),
                              MyWidgets.text("Verification Application Pending!", 25, FontWeight.bold, Color(0xff111111), context,false),
                              Container(width:MediaQuery.of(context).size.width * 1,child: MyWidgets.text("Please wait till your application is being processed", 17, FontWeight.normal, Color(0xff111111), context,false)),
                              SizedBox(height:30),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: MyWidgets.button("Home", (){
                                  MyWidgets.navigatePR(Home(), context);
                                }, Color(0xff04123B), context),
                              ),

                            ]
                        ),
                      );
                    });
                  }else{
                    Navigator.pop(context);
                    showDialog(context: context, builder: (context){
                      return Text("Sample Dialog for failed submit");
                    });
                  }

                }
              }, Color(0xff04123B),context),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}

class verConfirm extends StatefulWidget {
  const verConfirm({super.key});

  @override
  State<verConfirm> createState() => _verConfirmState();
}

class _verConfirmState extends State<verConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("KYC Verification", context),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40,),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: (){
               
              },
              iconSize: 200,
              icon: Image.asset("assets/verIcon.png"),
            ),
            SizedBox(height: 10,),
            FractionallySizedBox(widthFactor: 1,),
            MyWidgets.text("Verify your identity!", 30, FontWeight.bold, Color(0xff111111), context,false),
            SizedBox(height: 20,),
            FractionallySizedBox(widthFactor: 0.85,child:  MyWidgets.text("This process is designed to verify your identity, and to protect you from identity theft. As we're a financial service, we have to comply with KYC and AML requirements. \n\n You just need to go through some steps which will help us to build a secure system together.", 18, FontWeight.bold, Color(0xff111111), context,false),),
            SizedBox(height: 20,),
            SizedBox(width: MediaQuery.of(context).size.width * 0.85,height: 40,child: MyWidgets.button("Verify", (){
              MyWidgets.navigatePR(Verification(), context);
            }, Color(0xff04123B), context),)
          ],
        ),
      ),
    );
  }
}


class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({Key? key}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.appbar("KYC Verification", context),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                MyWidgets.text("Last Name", 14.0, FontWeight.bold, Color(0xff3B4652),context,false),
                MyWidgets.textField(controller, "Enter Last Name",Color(0xff0A1B4D),context),
              ],
            ),
            MyWidgets.button("Submit", (){}, Color(0xff04123B),context),
          ],
        ),
      ),
    );
  }
}

