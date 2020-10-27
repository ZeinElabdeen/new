import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/MainWidgets/mapCard.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/details_text_field.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/orderFinish.dart';
import 'package:haat/src/provider/post/createOrderProvider.dart';
import 'package:provider/provider.dart';

class PickUpOrder extends StatefulWidget {
  @override
  _PickUpOrderState createState() => _PickUpOrderState();
}

class _PickUpOrderState extends State<PickUpOrder> {
  bool currentPlace = false;
  bool arivePlace = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      Provider.of<CreateOrderProvider>(context, listen: false).setNull();
    });
    super.initState();
  }

  final _form = GlobalKey<FormState>();
  bool autoError = false;
  bool location = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "اطلب بيك اب",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _form,
        autovalidate: autoError,
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Center(
                child: Image.network(
              'https://img.drivemag.net/media/default/0001/98/urus-pickup-truck-2687-default-large.jpeg',
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )),
            ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 20),
                  backGroundColor: Theme.of(context).primaryColor,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                       "اطلب بيك اب يشيل اغراضك كاملة",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            SizedBox(
              height: 20,
            ),
            RegisterTextField(
              label: 'اسم المكان',
              type: TextInputType.text,
              icon: Icons.location_city,
              onChange: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .placeName = v;
              },
            ),
            SizedBox(height: 20),
            DetailsTextField(
              hint: 'اكتب تفاصيل طلبك هنا',
              onChange: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .orderDetails = v;
              },
              label: 'اكتب طلبك',
              onImg: (v){
                  Provider.of<CreateOrderProvider>(context, listen: false).photo = v;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("مكان الخدمة موقعك الحالي"),
                SizedBox(
                  width: 5,
                ),
                Checkbox(
                  value: currentPlace,
                  onChanged: (v) {
                    setState(() {
                      currentPlace = !currentPlace;
                       Provider.of<CreateOrderProvider>(context, listen: false).orderLatitude = 
                       Provider.of<SharedPref>(context, listen: false).lat.toString();
                       Provider.of<CreateOrderProvider>(context, listen: false).orderLongitude  = 
                       Provider.of<SharedPref>(context, listen: false).long.toString();
                      print( Provider.of<CreateOrderProvider>(context, listen: false).orderLatitude);

                    });
                  },
                ),
              ],
            ),
            Visibility(
              visible: !currentPlace,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MapCard(
                    scaffoldKey: _scaffoldKey,
                    onChange: (v) {
                      Provider.of<CreateOrderProvider>(context, listen: false).orderLatitude = v.latitude.toString();
                      Provider.of<CreateOrderProvider>(context, listen: false).orderLongitude = v.longitude.toString();
                    },
                    onTap: () {
                      setState(() {
                        location = true;
                      });
                      Navigator.pop(context);
                    },
                    onTextChange: (v) {
                       Provider.of<CreateOrderProvider>(context, listen: false).arrivalDetails = v;
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SignInButton(
                textSize: 15,
                btnWidth: MediaQuery.of(context).size.width - 20,
                btnHeight: 50,
                onPressSignIn: () {
                  setState(() {
                    autoError = true;
                  });
                  final isValid = _form.currentState.validate();
                  if (!isValid) {
                    return;
                  }
                  _form.currentState.save();
                  if (location == false && currentPlace == false) {
                    Fluttertoast.showToast(
                        msg: "يجب تحديد موقع الاستلام",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.black,
                        textColor: Colors.white);
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FinishOrder(
                                bag: 0,
                                type: 1,
                              )));
                },
                txtColor: Colors.white,
                btnColor: Theme.of(context).primaryColor,
                buttonText: "اعتماد الطلب",
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
