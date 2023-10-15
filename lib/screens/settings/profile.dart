import 'package:dio/dio.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmii/screens/support/help_center.dart';
import 'package:spotmii/screens/settings/settings.dart';
import 'package:spotmii/screens/verification.dart';
import 'package:spotmii/widgets.dart';
import '../../components/constants.dart';
import '../../models/localauth.dart';
import '../account/link.dart';
import '../auth/login.dart';
import '../home.dart';
import 'dart:io';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var selectedImage = currentUser!.userPic != "" ? NetworkImage("https://app.spotmii.com.au/uploads/${currentUser!.userPic}") : const NetworkImage("https://digitalfinger.id/wp-content/uploads/2019/12/no-image-available-icon-6.png");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A1B4D),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xff050E29),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Row(

                  children: [
                    Container(
                      margin:const EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundImage: selectedImage,
                        radius: 35,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width:MediaQuery.of(context).size.width * 0.6,alignment:Alignment.centerLeft,child: MyWidgets.text("${currentUser!.fname} ${currentUser!.lname}", 25.0, FontWeight.bold,Colors.white,context,false)),
                        Container(width:MediaQuery.of(context).size.width * 0.6,alignment:Alignment.centerLeft,child: MyWidgets.text("@${currentUser!.username}", 17.0, FontWeight.normal,Colors.white,context,false)),
                        //TextButton(onPressed: (){}, child: Text("Fully Verified"))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height * 0.725),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )
                ),
                child : ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        MyWidgets.navigateP(const EditProfile(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/18.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("Edit Profile", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        if(currentUser!.verifyStatus == "verified"){
                          showModalBottomSheet(

                              context: context, builder: (context){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)
                                  )
                              ),
                              child: Column(
                                  children: [
                                    const SizedBox(height:10,),
                                    Container(height: 5,width:50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(99),color: Colors.grey)),
                                    const SizedBox(height:10),
                                    IconButton(
                                      icon: const Icon(Icons.check_circle,color: Colors.green,),
                                      iconSize: 125,
                                      onPressed: () {},
                                    ),
                                    const SizedBox(height:10),
                                    MyWidgets.text("Your account is verified!", 25, FontWeight.bold, const Color(0xff111111), context,false),
                                    SizedBox(width:MediaQuery.of(context).size.width * 1,child: MyWidgets.text("Congratulation, enjoy the benefits of verified account!", 17, FontWeight.normal, const Color(0xff111111), context,false)),
                                    const SizedBox(height:30),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: MyWidgets.button("Home", (){
                                        MyWidgets.navigatePR(const Home(), context);
                                      }, const Color(0xff04123B), context),
                                    ),

                                  ]
                              ),
                            );
                          });
                        }else if(currentUser!.verifyStatus == "pending"){
                          showModalBottomSheet(

                              context: context, builder: (context){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)
                                  )
                              ),
                              child: Column(
                                  children: [
                                    const SizedBox(height:10,),
                                    Container(height: 5,width:50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(99),color: Colors.grey)),
                                    const SizedBox(height:10),
                                    IconButton(
                                      icon: const Icon(Icons.warning_rounded,color: Colors.amber,),
                                      iconSize: 125,
                                      onPressed: () {},
                                    ),
                                    const SizedBox(height:10),
                                    MyWidgets.text("Verification Application Pending!", 25, FontWeight.bold, const Color(0xff111111), context,false),
                                    SizedBox(width:MediaQuery.of(context).size.width * 1,child: MyWidgets.text("Please wait till your application is being processed", 17, FontWeight.normal, const Color(0xff111111), context,false)),
                                    const SizedBox(height:30),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: MyWidgets.button("Home", (){
                                        MyWidgets.navigatePR(const Home(), context);
                                      }, const Color(0xff04123B), context),
                                    ),

                                  ]
                              ),
                            );
                          });
                        }else if(currentUser!.verifyStatus == "failed"){
                          showModalBottomSheet(

                              context: context, builder: (context){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)
                                  )
                              ),
                              child: Column(
                                  children: [
                                    const SizedBox(height:10,),
                                    Container(height: 5,width:50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(99),color: Colors.grey)),
                                    const SizedBox(height:10),
                                    IconButton(
                                      icon: const Icon(Icons.cancel,color: Colors.red,),
                                      iconSize: 125,
                                      onPressed: () {},
                                    ),
                                    const SizedBox(height:10),
                                    MyWidgets.text("Verification Application Failed!", 25, FontWeight.bold, const Color(0xff111111), context,false),
                                    SizedBox(width:MediaQuery.of(context).size.width * 1,child: MyWidgets.text("Your Verification is unsuccessful. Please double check your information before sending again.", 17, FontWeight.normal, const Color(0xff111111), context,false)),
                                    const SizedBox(height:30),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: MyWidgets.button("Send Again", (){
                                        MyWidgets.navigatePR(const verConfirm(), context);
                                      }, const Color(0xff04123B), context),
                                    ),

                                  ]
                              ),
                            );
                          });
                        }else{
                          MyWidgets.navigateP(const verConfirm(), context);
                        }

                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/19.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("KYC Verification", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        MyWidgets.navigateP(const Security(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/20.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("2FA Security", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        MyWidgets.navigateP(const LinkAccounts(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/21.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("My Link Accounts", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        MyWidgets.navigateP(const Settings(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/biometrics.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.70,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("Biometrics", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        MyWidgets.navigateP(const ResetPassword1(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/reset.png'),
                              iconSize: 20,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("Reset Password", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        MyWidgets.navigateP(const HelpCenter(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/24.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("Help Center", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        //LOGOUT
                        MyWidgets.navigatePR(const Login(), context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: IconButton(
                              icon: Image.asset('assets/26.png'),
                              iconSize: 25,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Align(alignment: Alignment.centerLeft,child: MyWidgets.text("Logout", 20.0, FontWeight.normal, const Color(0xff111111),context,false),),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          MyWidgets.myBottomBar(context, 4)
        ],
      ),
    //bottomNavigationBar: MyWidgets.bottombar(context, 4),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var numberController = TextEditingController();
  var nationalityController = TextEditingController();
  var birthdayController = TextEditingController();
  var addressController = TextEditingController();
  var countryController = TextEditingController();
  var zipcodeController = TextEditingController();
  @override
  void initState() {
    fNameController.text = currentUser!.fname;
    lNameController.text = currentUser!.lname;
    emailController.text = currentUser!.email;
    numberController.text = currentUser!.number;
    nationalityController.text = currentUser!.nationality;
    birthdayController.text = currentUser!.birthday;
    addressController.text = currentUser!.address;
    countryController.text = currentUser!.country;
    zipcodeController.text = currentUser!.zipcode;
    super.initState();
  }
  var items1 = [
    'Male',
    'Female',
  ];
  String genderValue = 'Male';
  var code = "";
  final countryPicker  = const FlCountryCodePicker(
    showDialCode: false,
  );
  var selectedImage = currentUser!.userPic != "" ? NetworkImage("https://app.spotmii.com.au/uploads/${currentUser!.userPic}") : const NetworkImage("https://digitalfinger.id/wp-content/uploads/2019/12/no-image-available-icon-6.png");
  late var imagetoupload;
  Future<File> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    return file;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyWidgets.appbar("Update Profile", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 110,
              child: Stack(
                children: [

                  Positioned(
                    left: ( MediaQuery.of(context).size.width / 2 ) + 32.5,
                    bottom: -5,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        iconSize: 20,
                        icon: Image.asset("assets/27.png"),
                        onPressed: () async{
                          imagetoupload = await getImage();
                          //print(selImage!.path);
                          //selectedImage = NetworkImage(File(selImage!.path).path);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: selectedImage,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("First name", 16.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 40,
                          child: MyWidgets.textFormField(fNameController, "First name", const Color(0xff3B4652),(value){
                            if(value == null){
                              return "First Name cannot be empty";
                            }
                          },context),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Last name", 16.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 40,
                          child: MyWidgets.textFormField(lNameController, "Last name", const Color(0xff3B4652),(value){
                            if(value == null){
                              return "Last Name cannot be empty";
                            }
                          },context),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Email Address", 16.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 40,
                    child: MyWidgets.textFormField(emailController, "Email Address", const Color(0xff3B4652),(value){
                      if(value == null){
                        return "First Name cannot be empty";
                      }
                    },context),
                  )

                ],
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Select Country", 17.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 40,
                            child:  TextField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: countryController,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: "Select Country",
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                prefixIcon: IconButton(
                                  color: const Color(0xff3B4652),
                                  onPressed: ()async{
                                    final code1 = await countryPicker.showPicker(context: context);
                                    setState(() {
                                      countryController.text = code1!.name;
                                      code = code1.dialCode;
                                    });
                                  },
                                  icon: const Icon(Icons.flag),
                                ),
                                hintStyle: TextStyle(
                                    fontSize: MF(18, context),
                                    fontFamily: "Poppins",
                                    color: const Color(0xff3B4652)
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: MF(18, context),
                                  fontFamily: "Poppins",
                                  color: const Color(0xff3B4652)
                              ),
                            )
                        )

                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      children: [
                        Align(
                            alignment:Alignment.centerLeft,
                            child: MyWidgets.text("Zip Code", 17.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                        ),
                        const SizedBox(height: 5,),
                        SizedBox(
                          height: 40,
                          child:  MyWidgets.textFormField(zipcodeController, "Zip Code", const Color(0xff3B4652),(value){
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
            const SizedBox(height: 15,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Mobile Number", 17.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                  ),
                  const SizedBox(height: 5,),
                  SizedBox(
                      height: 40,
                      child:  TextField(
                        controller: numberController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            isCollapsed: true,
                            hintText: "Enter Mobile Number",
                            prefixText: "$code | ",
                            focusedBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Color(0xff3B4652), width: 1.5,),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            hintStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: MF(18, context),
                                color: const Color(0xff3B4652)
                            )
                        ),
                        style:TextStyle(
                            fontFamily: "Poppins",
                            fontSize: MF(18, context),
                            color: const Color(0xff3B4652)
                        )
                      )
                  )

                ],
              ),
            ),
            //visibility
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Birthday", 17.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: birthdayController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed:()async{
                            var date = await showDatePicker(context: context, initialDate: DateTime(2010), firstDate: DateTime(1960), lastDate: DateTime(2010));
                            setState(() {
                              birthdayController.text = date.toString().split(" ")[0];
                            });
                          },
                          icon:const Icon(Icons.calendar_month,color: Color(0xff3B4652)),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(color: Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        hintStyle: TextStyle(
                            color: const Color(0xff3B4652),
                            fontSize: MF(18,context),
                            fontFamily: "Poppins"
                        ),
                        hintText: "DD/MM/YY",

                      ),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: MF(18, context),
                          color: const Color(0xff3B4652)
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Nationality", 17.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 40,
                    child: MyWidgets.textFormField(nationalityController, "Nationality", const Color(0xff3B4652),(value){
                      if(value == null){
                        return "Nationality cannot be empty";
                      }
                    },context),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Gender", 17.0, FontWeight.bold, const Color(0xff04123B),context,false)
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),

                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(color: Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff3B4652), width: 1.5,),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff3B4652), width: 1.5,),
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
                          color: const Color(0xff3B4652)
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
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: MyWidgets.text("Current Address", 17.0, FontWeight.bold, const Color(0xff3B4652),context,false)
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 40,
                    child: MyWidgets.textFormField(addressController, "Current Address", const Color(0xff3B4652),(value){
                      if(value == null){
                        return "Current cannot be empty";
                      }
                    },context),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyWidgets.button("Update Profile", (){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color:const Color(0xff04123B),
                        height: 60,
                        child: GestureDetector(
                          onTap: ()async{
                            final isAuthenticated = await LocalAuthApi.authenticate("Scan fingerprint to Update Profile!");
                            if(isAuthenticated){
                              MyWidgets.showLoading();
                              var img = imagetoupload.path.split('/');
                              String imageName = img[img.length-1];

                              FormData formData = FormData.fromMap({
                                "req" : "updateProfile",
                                "uid" : currentUser!.userID,
                                "fname" : fNameController.text,
                                "lname" : lNameController.text,
                                "email" : emailController.text.trim(),
                                "country" : countryController.text.trim(),
                                "zipcode" : zipcodeController.text.trim(),
                                "mobile" : code + numberController.text,
                                "birthday" : birthdayController.text.trim(),
                                "nationality" : nationalityController.text.trim(),
                                "gender" : genderValue,
                                "address" : addressController.text,
                                "picture" : await MultipartFile.fromFile(imagetoupload.path,filename: imageName),
                              });
                              Response response = await Dio().post(url,data: formData);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              if(response.statusCode == 200){
                                showModalBottomSheet(context: context, builder: (context){
                                  return Container(
                                    height: 300,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30,),
                                        Image.asset(
                                          "assets/3.png",
                                          height: 120,
                                        ),
                                        const SizedBox(height: 20,),
                                        MyWidgets.text("Update Success!", 25, FontWeight.bold, const Color(0xff111111), context, false),
                                        const SizedBox(height: 20,),
                                        FractionallySizedBox(
                                          widthFactor: 0.85,
                                          child: MyWidgets.button("Home", (){
                                            MyWidgets.navigatePR(const Home(), context);
                                          }, const Color(0xff04123B), context),
                                        )
                                      ],
                                    ),
                                  );
                                });
                              }
                            }else{
                              showModalBottomSheet(context: context, builder: (context){
                                return Container(
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 30,),
                                      Image.asset(
                                        "assets/failed.png",
                                        height: 120,
                                      ),
                                      const SizedBox(height: 20,),
                                      MyWidgets.text("Update Failed!", 25, FontWeight.bold, const Color(0xff111111), context, false),
                                      const SizedBox(height: 20,),
                                      FractionallySizedBox(
                                        widthFactor: 0.85,
                                        child: MyWidgets.button("Home", (){
                                          MyWidgets.navigatePR(const Home(), context);
                                        }, const Color(0xff04123B), context),
                                      )
                                    ],
                                  ),
                                );
                              });
                            }
                          },
                          child: Center(
                            child: MyWidgets.text("Continue", 25.0, FontWeight.bold, Colors.white,context,false),
                          ),
                        ),
                      );
                    });
              }, const Color(0xff04123B),context),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      )
    );
  }
}
