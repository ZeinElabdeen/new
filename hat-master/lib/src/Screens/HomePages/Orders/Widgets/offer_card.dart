import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haat/src/MainWidgets/custom_btn.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/OrderBLoCs/offers_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/price_offers_model.dart';

class OfferCard extends StatefulWidget {
  final Offer offer;

  const OfferCard({Key key, this.offer}) : super(key: key);

  @override
  _OfferCardState createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                         Container(
                  height: 60,
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.offer.driverPhoto ?? "",
                      errorWidget: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/images/avatar.jpeg',
                              fit: BoxFit.cover)),
                      fadeInDuration: Duration(seconds: 2),
                      placeholder: (context, url) => ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/images/avatar.jpeg',
                              fit: BoxFit.cover)),
                      imageBuilder: (context, provider) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                              image: provider,
                              fit: BoxFit.cover,
                            ));
                      },
                    ),
                  ),
                ),
                      // CircleAvatar(
                      //     radius: 20,
                      //     backgroundImage: NetworkImage(widget.offer.driverPhoto)),
                      SizedBox(width: 10),
                      Text(
                        widget.offer.driver,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: RatingBar(
                        initialRating: widget.offer.driverRate.toDouble() ,
                        itemSize: 15.0,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate:null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(height: 1, color: Colors.grey),
              SizedBox(height: 5),
              widget.offer.offerDetails != null
                  ? Text(widget.offer.offerDetails,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center)
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('السعر:'),
                      SizedBox(width: 6),
                      Text(widget.offer.price.toString(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      Text('ريال',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  Container(
                    height: 35,
                    child: CustomBtn(
                      color: Theme.of(context).primaryColor,
                      onTap: () {
                        offersBloc.updateOfferID(widget.offer.id);
                        offersBloc.add(AcceptOffer());
                      },
                      text: 'قبول',
                      txtColor: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
