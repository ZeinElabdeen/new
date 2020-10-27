import 'package:flutter/material.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/date_card.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/provider/changeData/editDrivarDataProvider.dart';
import 'package:haat/src/provider/get/CarTypeProvider.dart';
import 'package:haat/src/provider/get/IdentityTypeProvider.dart';
import 'package:haat/src/provider/get/NationalitiesProvider.dart';
import 'package:haat/src/provider/get/citiesProvider.dart';
import 'package:provider/provider.dart';

class EditDriverDoc extends StatefulWidget {
  @override
  _EditDriverDocState createState() => _EditDriverDocState();
}

class _EditDriverDocState extends State<EditDriverDoc> {
  bool city = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterTextField(
          icon: Icons.label,
          onChange: (v) {
            Provider.of<EditDriverDataProvider>(context, listen: false)
                .idNumber = v;
          },
          label: 'رقم الهوية',
          type: TextInputType.text,
          init: Provider.of<SharedPref>(context, listen: false)
              .idNumber
              .toString(),
        ),
        SizedBox(height: 20),
        RegisterTextField(
          icon: Icons.label,
          onChange: (v) {
            Provider.of<EditDriverDataProvider>(context, listen: false).job = v;
          },
          label: 'الوظيفة',
          type: TextInputType.text,
          init: Provider.of<SharedPref>(context, listen: false).job,
        ),
        SizedBox(height: 20),
        DateCard(
          start: Provider.of<SharedPref>(context, listen: false).barithDay.substring(0,10),
          onDate: (v) {
          Provider.of<EditDriverDataProvider>(context, listen: false).barithDay = v;
        }),
        LabeledBottomSheet(
          label: Provider.of<SharedPref>(context, listen: false).city,
          onChange: (v) {
            Provider.of<EditDriverDataProvider>(context, listen: false).cityId =
                v.id.toString();
          },
          data: Provider.of<CitiesProvider>(context, listen: true).cotiesSheet,
        ),
        LabeledBottomSheet(
          label: Provider.of<SharedPref>(context, listen: false).nationality,
          onChange: (v) {
            Provider.of<EditDriverDataProvider>(context, listen: false)
                .nationalityId = v.id.toString();
          },
          data: Provider.of<NationalitiesProvider>(context, listen: true)
              .bottomSheet,
        ),
        LabeledBottomSheet(
          label: Provider.of<SharedPref>(context, listen: false).carType,
          onChange: (v) {
            Provider.of<EditDriverDataProvider>(context, listen: false)
                .carTypeId = v.id.toString();
          },
          data: Provider.of<CarTypeProvider>(context, listen: true).bottomSheet,
        ),
        LabeledBottomSheet(
          label: Provider.of<SharedPref>(context, listen: false).nationality,
          onChange: (v) {
            Provider.of<EditDriverDataProvider>(context, listen: false)
                .identityTypeId = v.id.toString();
          },
          data: Provider.of<IdentituTypeProvider>(context, listen: true)
              .bottomSheet,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
