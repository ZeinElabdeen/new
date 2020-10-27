import 'package:flutter/material.dart';
import 'package:haat/src/provider/get/orderStateProvider.dart';
import 'package:provider/provider.dart';

class OrderState extends StatefulWidget {
  @override
  _OrderStateState createState() => _OrderStateState();
}

class _OrderStateState extends State<OrderState> {
   List<StepModel> _steps = [
    StepModel(
        name: "تم إنشاء طلبك",
        icon: Image.asset(
          'assets/images/choices.png', width: 25, height: 25, color: Colors.white,)),
    StepModel(
        name: "وصلتك عروض الاسعار",
        time: "منذ ساعتين",
        icon: Image.asset('assets/images/choices.png',
            width: 25, height: 25, color: Colors.white)),
    StepModel(
        name: "تم الموافة على عرض سعر",
        time: "منذ ساعة ونصف",
        icon: Image.asset('assets/images/offer.png',
            width: 25, height: 25, color: Colors.white)),
    StepModel(
        name: "تم البدأ في تجهيز طلبك",
        time: "منذ ساعة",
        icon: Image.asset('assets/images/box_open.png',
            width: 25, height: 25, color: Colors.white)),
    // StepModel(
    //   name: "تم تجهيز طلبك",
    //   time: "منذ 45 دقيقة",
    //   icon: Image.asset('assets/images/box_close.png',
    //       width: 25, height: 25, color: Colors.white),
    // ),
    // StepModel(
    //     name: "تم شحن طلبك",
    //     time: "منذ 25 دقيقة",
    //     icon: Image.asset('assets/images/rating.png',
    //         width: 25, height: 25, color: Colors.white)),
    StepModel(
      name: "وصلك الطلب",
      time: "الآن",
      icon: Image.asset('assets/images/package.png',
          width: 25, height: 25, color: Colors.white),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع الطلب",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)
        ),
      ),
       body: ListView.builder(
          itemCount: Provider.of<OrderStateProcider>(context,listen: true).orderState == 1 ? 4 : _steps.length,
          itemBuilder: (context, index) {
            return _stepCard(
                index: index,
                length: _steps.length,
                model: _steps[index]
            );
          },
        ),
    );
  }

  Widget _stepCard({StepModel model, int length, int index}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // model.time != null
                    //     ? Text(model.time,
                    //     style: TextStyle(color: Colors.grey, fontSize: 12),
                    //     textAlign: TextAlign.left)
                    //     : Container(),
                    Text(
                      model.name,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            children: <Widget>[
              Material(
                shape: CircleBorder(),
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: model.icon,
                ),
              ),
              SizedBox(height: 5),
              Visibility(
                visible: (index + 1) != length ? true : false,
                child: Container(
                  width: 2,
                  color: Colors.grey,
                  height: 40,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}


class StepModel {
  final String name;
  final String time;
  final Widget icon;

  const StepModel({this.name, this.time, this.icon});
}