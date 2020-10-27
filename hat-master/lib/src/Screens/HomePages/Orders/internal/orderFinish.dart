import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haat/src/MainWidgets/customBtn.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/details_text_field.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/MainWidgets/location_text_field.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/provider/post/createOrderProvider.dart';
import 'package:haat/src/provider/post/postCartProvider.dart';
import 'package:provider/provider.dart';
import '../../../../MainWidgets/mapCard.dart';
import '../../../../Helpers/sharedPref_helper.dart';
import '../../../../provider/get/MyAddressProvider.dart';

class FinishOrder extends StatefulWidget {
  final int bag;
  final int type;

  const FinishOrder({Key key, this.bag, @required this.type}) : super(key: key);
  @override
  _FinishOrderState createState() => _FinishOrderState();
}

class _FinishOrderState extends State<FinishOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Provider.of<CreateOrderProvider>(context, listen: false).cart =
        0.toString();
    Provider.of<MyAddressProvider>(context, listen: false)
        .getPlaces(Provider.of<SharedPref>(context, listen: false).token);
    super.initState();
  }

  bool location = false;
  bool chosesMyLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              " تاكيد الطلب",
              style: TextStyle(color: Colors.white),
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
      body: ListView(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Directionality(
          //       textDirection: TextDirection.rtl,
          //       child: Text(
          //         "اسم المكان",
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       )),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 8.0, left: 8),
          //   child: Directionality(
          //       textDirection: TextDirection.rtl,
          //       child: Text(
          //         "مطعم",
          //       )),
          // ),
          SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Directionality(
          //       textDirection: TextDirection.rtl,
          //       child: Text(
          //         "تفاصيل الطلب",
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       )),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Directionality(
          //     textDirection: TextDirection.rtl,
          //     child: Text("تفاصيل الطلب تفاصيل يتم استبدالها"
          //         "تفاصيل الطلب تفاصيل يتم استبدالها"
          //         "تفاصيل الطلب تفاصيل يتم استبدالها"
          //         "تفاصيل الطلب تفاصيل يتم استبدالها"
          //         "تفاصيل الطلب تفاصيل يتم استبدالها"),
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          LocationTextField(
            onChange: (v) {
              Provider.of<PostCartProvider>(context, listen: false)
                  .arrivalDetails = v;
              Provider.of<CreateOrderProvider>(context, listen: false)
                  .arrivalDetails = v;
            },
          ),
          Visibility(
            visible: widget.bag == 1,
            child: DetailsTextField(
              hint: 'اكتب تفاصيل طلبك هنا',
              onChange: (v) {
                Provider.of<PostCartProvider>(context, listen: false)
                    .orderDetails = v;
              },
              label: 'اكتب طلبك',
              onImg: (v) {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: Provider.of<MyAddressProvider>(context, listen: true)
                    .placesSheet
                    .length >
                0,
            child: LabeledBottomSheet(
              label: '-- عناويني --',
              onChange: (v) {
                setState(() {
                  chosesMyLocation = true;
                  location = true;
                });

                Provider.of<PostCartProvider>(context, listen: false).latitude =
                    v.lat.toString();
                Provider.of<PostCartProvider>(context, listen: false)
                    .longitude = v.long.toString();
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .latitude = v.lat.toString();
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .longitude = v.long.toString();
              },
              data: Provider.of<MyAddressProvider>(context, listen: true)
                  .placesSheet,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !chosesMyLocation,
            child: MapCard(
              scaffoldKey: _scaffoldKey,
              onTap: () {
                setState(() {
                  location = true;
                });
                Navigator.pop(context);
              },
              withAppBar: true,
              onChange: (v) {
                Provider.of<PostCartProvider>(context, listen: false).latitude =
                    v.latitude.toString();
                Provider.of<PostCartProvider>(context, listen: false)
                    .longitude = v.longitude.toString();
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .latitude = v.latitude.toString();
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .longitude = v.longitude.toString();
              },
              onTextChange: (v) {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RegisterTextField(
            label: 'كود الخصم',
            type: TextInputType.text,
            icon: Icons.money_off,
            onChange: (v) {
              Provider.of<PostCartProvider>(context, listen: false).code = v;
              Provider.of<CreateOrderProvider>(context, listen: false).code = v;
            },
            hint: 'قم باضافة كود الخصم ...',
          ),
          SizedBox(
            height: 20,
          ),
          LabeledBottomSheet(
            label: '--  اختر طريقة الدفع --',
            onChange: (v) {
              Provider.of<CreateOrderProvider>(context, listen: false).paid =
                  v.id.toString();
              Provider.of<PostCartProvider>(context, listen: false).paid =
                  v.id.toString();
              print(v.id.toString());
            },
            data: [
              BottomSheetModel(
                id: 0,
                name: "كاش",
                realID: "0",
              ),
              BottomSheetModel(
                id: 1,
                name: "محفظة",
                realID: "1",
              ),
              BottomSheetModel(
                id: 2,
                name: "اونلاين",
                realID: "2",
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomBtn(
              color: Theme.of(context).primaryColor,
              onTap: () {
                if (location == false) {
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
                if (Provider.of<CreateOrderProvider>(context, listen: false).paid == null) {
                       Fluttertoast.showToast(
                      msg: "يجب اختيار طريقة الدفع",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.black,
                      textColor: Colors.white);
                  return;
                }
                
                if (widget.bag == 1) {
                  Provider.of<PostCartProvider>(context, listen: false)
                      .postCart(
                          Provider.of<SharedPref>(context, listen: false).token,
                          context);
                } else
                  Provider.of<CreateOrderProvider>(context, listen: false)
                      .createOrder(
                          Provider.of<SharedPref>(context, listen: false).token,
                          widget.type,
                          context);
              },
              text: 'تأكيد الطلب',
              txtColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
