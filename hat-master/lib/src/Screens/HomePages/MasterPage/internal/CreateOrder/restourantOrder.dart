import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:haat/src/MainWidgets/buttonSignIn.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/details_text_field.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/Widgets/photoGallary.dart';
import 'package:haat/src/Screens/HomePages/MasterPage/Widgets/restourantCard.dart';
import 'package:haat/src/Screens/HomePages/Orders/internal/orderFinish.dart';
import 'package:haat/src/provider/get/restourantProvider.dart';
import 'package:haat/src/provider/post/createOrderProvider.dart';
import 'package:provider/provider.dart';

class RestourantOrder extends StatefulWidget {
  final int index;

  const RestourantOrder({Key key, this.index}) : super(key: key);
  @override
  _RestourantOrderState createState() => _RestourantOrderState();
}

class _RestourantOrderState extends State<RestourantOrder> {
  bool hidenMenu = true;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 150), () {
      Provider.of<CreateOrderProvider>(context, listen: false).setNull();
      Provider.of<CreateOrderProvider>(context, listen: false).placeName =
          Provider.of<RestourantsProvider>(context, listen: false)
              .restourants[widget.index]
              .name;
      Provider.of<CreateOrderProvider>(context, listen: false).orderLatitude =
          Provider.of<RestourantsProvider>(context, listen: false)
              .restourants[widget.index]
              .latitude;
      Provider.of<CreateOrderProvider>(context, listen: false).orderLongitude =
          Provider.of<RestourantsProvider>(context, listen: false)
              .restourants[widget.index]
              .longitude;
      Provider.of<CreateOrderProvider>(context, listen: false).providerId =
          Provider.of<RestourantsProvider>(context, listen: false)
              .restourants[widget.index]
              .id
              .toString();
    });
    super.initState();
  }

  final _form = GlobalKey<FormState>();
  bool autoError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "طلب جديد",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Form(
        autovalidate: autoError,
        key: _form,
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            RestourantCard(
              // onTap: () {},
              title: Provider.of<RestourantsProvider>(context, listen: false)
                  .restourants[widget.index]
                  .name,
              photo: Provider.of<RestourantsProvider>(context, listen: false)
                  .restourants[widget.index]
                  .photo,
              distant: Provider.of<RestourantsProvider>(context, listen: false)
                  .restourants[widget.index]
                  .distance
                  .toString()
                  .substring(0, 3),
              department:
                  Provider.of<RestourantsProvider>(context, listen: false)
                      .restourants[widget.index]
                      .department,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        hidenMenu = !hidenMenu;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(hidenMenu == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                        Text(
                          "القائمة",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: hidenMenu,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemCount: Provider.of<RestourantsProvider>(context,
                                  listen: true)
                              .restourants[widget.index]
                              .photos
                              .length,
                          itemBuilder: (c, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PhotoGallary(
                                                  images: Provider.of<
                                                              RestourantsProvider>(
                                                          context,
                                                          listen: true)
                                                      .restourants[widget.index]
                                                      .photos,
                                                )));
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: Provider.of<RestourantsProvider>(
                                                    context,
                                                    listen: true)
                                                .restourants[widget.index]
                                                .photos
                                                .length ==
                                            0
                                        ? ""
                                        : Provider.of<RestourantsProvider>(
                                                context,
                                                listen: true)
                                            .restourants[widget.index]
                                            .photos[index]
                                            .photo,
                                    placeholder: (context, url) => new Center(
                                      child: SpinKitThreeBounce(
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        new Image.asset(
                                      'assets/images/error.gif',
                                      fit: BoxFit.contain,
                                    ),
                                    fit: BoxFit.contain,
                                  )),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            DetailsTextField(
              hint: 'اكتب تفاصيل طلبك هنا',
              onChange: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false)
                    .orderDetails = v;
              },
              label: 'اكتب طلبك',
              onImg: (v) {
                Provider.of<CreateOrderProvider>(context, listen: false).photo =
                    v;
              },
            ),
            SizedBox(
              height: 30,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FinishOrder(
                                bag: 0,
                                type: 2,
                              )));
                },
                txtColor: Colors.white,
                btnColor: Theme.of(context).primaryColor,
                buttonText: "اعتماد الطلب",
              ),
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
                  Provider.of<CreateOrderProvider>(context, listen: false)
                      .cart = 1.toString();
                  Provider.of<CreateOrderProvider>(context, listen: false)
                      .createOrder(
                          Provider.of<SharedPref>(context, listen: false).token,
                          2,
                          context);
                },
                txtColor: Colors.black,
                btnColor: Colors.grey[400],
                buttonText: "اضافة للسلة",
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
