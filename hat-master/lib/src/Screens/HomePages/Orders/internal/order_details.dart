import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/app_loader.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/MainWidgets/details_card.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/OrderBLoCs/offers_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/OrderBLoCs/orders_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/all_orders_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/price_offers_model.dart';
import 'package:haat/src/Screens/HomePages/Chat/chat_room.dart';
import 'package:haat/src/Screens/HomePages/Orders/Widgets/offer_card.dart';
import 'package:haat/src/Screens/HomePages/Orders/Widgets/order_cancel_btn.dart';
import 'package:haat/src/provider/get/orderStateProvider.dart';
import 'package:haat/src/provider/post/finishOrderProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main_page.dart';
import 'orderState.dart';
import 'rating.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  final int state;

  const OrderDetails({Key key, this.order, this.state}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    offersBloc.updateKey(_globalKey);
    offersBloc.updateOrderID(widget.order.id);
    if (widget.state == 0) {
      offersBloc.add(Click());
    }
    Provider.of<OrderStateProcider>(context, listen: false).getOrderState(
        Provider.of<SharedPref>(context, listen: false).token,widget.order.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      floatingActionButton: widget.order.status == 1
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.chat, color: Colors.white),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChatRoom(
                            phone: widget.order.driverPhone,
                            uniqueId: widget.order.id,
                            secondUserID: widget.order.driverId,
                          ))))
          : null,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          onTap: () => Navigator.pop(context),
          label: 'تفاصيل الطلب',
          iconData: Icons.arrow_back_ios,
        ),
      ),
      body: ListView(
        children: <Widget>[
          DetailsCard(
            label: 'اسم المكان',
            content: widget.order.placeName ?? "",
          ),
          DetailsCard(
            label: 'تفاصيل الطلب',
            content: widget.order.orderDetails,
          ),
          widget.state == 0
              ? Container()
              : Column(
                  children: [
                    DetailsCard(
                      label: 'السائق',
                      content: widget.order.driver,
                    ),
                    DetailsCard(
                      label: 'سعر التوصيل',
                      content: widget.order.price == null ? "0" :widget.order.price.toString(),
                    ),
                    DetailsCard(
                      label: 'سعر الطلب',
                      content: widget.order.orderPrice == null  ? 'لم يحدد بعد' : widget.order.orderPrice.toString(),
                    ),
                  ],
                ),
          widget.state != 0
              ? Container()
              : ChatBubble(
                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 20),
                  backGroundColor: Colors.red,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "سيتم حذف طلبك تلقائيا ان لم يتم تقديم عرض من السائقين خلال 24 ساعه",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
          widget.state == 0
              ? BlocListener<OffersBloc, AppState>(
                  bloc: offersBloc,
                  listener: (_, state) {
                    if (state is Accepted) {
                      CustomAlert()
                          .toast(context: context, title: 'تم قبول العرض');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MainPage(index: 0)));
                    }
                    if (state is OrderCancelled) {
                      CustomAlert().toast(context: context, title: 'تم إنهاء الطلب');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => MainPage()));
                    }
                  },
                  child: BlocBuilder<OffersBloc, AppState>(
                    bloc: offersBloc,
                    builder: (_, state) {
                      if (state is Done) {
                        PriceOffersModel _res = state.model;
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            OrderCancelBtn(context: context),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: _res.data.length,
                              itemBuilder: (_, index) {
                                return OfferCard(offer: _res.data[index]);
                              },
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          OrderCancelBtn(context: context),
                          AppLoader(title: 'في إنتظار عروض السائقين'),
                        ],
                      );
                    },
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomBtn(
                          color: Theme.of(context).primaryColor,
                          txtColor: Colors.white,
                          text: 'تتبع الطلب',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => OrderState()));
                          }),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomBtn(
                        color: Theme.of(context).primaryColor,
                        txtColor: Colors.white,
                        text: 'إتصال بالسائق',
                        onTap: () =>
                            launch("tel://${widget.order.driverPhone}"),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlocListener<OrdersBloc, AppState>(
                      bloc: ordersBloc,
                      listener: (_, state) {
                        if (state is OrderFinished) {
                          CustomAlert().toast(
                              context: context,
                              title: 'تم إنهاء الطلب من فضلك قم بتقييم السائق');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Rating(
                                        orderID: widget.order.id,
                                        driverID: widget.order.driverId,
                                      )));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomBtn(
                          color: Theme.of(context).primaryColor,
                          txtColor: Colors.white,
                          text: 'إنهاء الطلب',
                          onTap: () {
                            Provider.of<FinishOrderProvider>(context,listen: false).finishOrder(
                              widget.order.driverId, 
                              Provider.of<SharedPref>(context,listen: false).token, 
                              widget.order.id, 
                              context);
                            // ordersBloc.updateOrderID(widget.order.id);
                            // ordersBloc.add(Finish());
                          },
                        ),
                      ),
                    ),
                    BlocListener<OffersBloc, AppState>(
                      bloc: offersBloc,
                      listener: (_, state) {
                        if (state is OrderCancelled) {
                          CustomAlert()
                              .toast(context: context, title: 'تم إنهاء الطلب');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => MainPage()));
                        }
                      },
                      child: OrderCancelBtn(context: context),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
