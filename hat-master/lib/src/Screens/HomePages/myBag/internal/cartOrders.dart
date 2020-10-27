import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/customCard.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/provider/get/cartsProvider.dart';
import 'package:haat/src/provider/get/deleteBagOrderProvider.dart';
import 'package:provider/provider.dart';

import 'editCart.dart';

class CartOrders extends StatefulWidget {
  @override
  _CartOrdersState createState() => _CartOrdersState();
}

class _CartOrdersState extends State<CartOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.7,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              Provider.of<CartsProvider>(context, listen: true).carts.length,
          itemBuilder: (c, index) {
            final String item =
                Provider.of<CartsProvider>(context, listen: true)
                    .carts[index]
                    .id
                    .toString();
            return Dismissible(
              key: ValueKey(item),
              background: Container(
                color: Theme.of(context).errorColor,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(right: 20),
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
              ),

              secondaryBackground: Container(
                color: Colors.green,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
              ),

              // ignore: missing_return
              confirmDismiss: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  onSave("حذف هذا الطلب من السلة", () {
                    Navigator.of(context).pop(false);
                    Provider.of<DeleteBagOrderProvider>(context, listen: false)
                        .deleteOrder(
                            Provider.of<SharedPref>(context, listen: false).token,
                            Provider.of<CartsProvider>(context, listen: false)
                            .carts[index].id.toString(),context).then((v) {
                      if (v == true)
                        Provider.of<CartsProvider>(context, listen: false).getCarsType(Provider.of<SharedPref>(context, listen: false).token);
                    });
                  });
                } else {
                  onSave("تعديل الطلب", () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_)=> EditCartOrder(
                        index: index,
                      )
                    ));
                  });
                }
              },

              child: CustomCard(
                details: Provider.of<CartsProvider>(context, listen: true)
                    .carts[index]
                    .orderDetails,
                lable: Provider.of<CartsProvider>(context, listen: true)
                    .carts[index]
                    .placeName,
                photo: Provider.of<CartsProvider>(context, listen: true)
                    .carts[index]
                    .photo,
              ),
            );
          }),
    );
  }

  onSave(String title, Function onAccept) {
    return showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(title),
          content: Text('هل انت متاكد ؟'),
          actions: <Widget>[
            FlatButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('نعم'),
              onPressed: onAccept,
            ),
          ],
        ),
      ),
    );
  }
}
