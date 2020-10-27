import 'package:flutter/material.dart';
import 'package:haat/src/MainWidgets/date_card.dart';
import 'package:haat/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/provider/auth/signUpProvider.dart';
import 'package:haat/src/provider/get/CarTypeProvider.dart';
import 'package:haat/src/provider/get/IdentityTypeProvider.dart';
import 'package:haat/src/provider/get/NationalitiesProvider.dart';
import 'package:haat/src/provider/get/RegionsProvider.dart';
import 'package:haat/src/provider/get/citiesProvider.dart';
import 'package:provider/provider.dart';

class DriverDaitels extends StatefulWidget {
  @override
  _DriverDaitelsState createState() => _DriverDaitelsState();
}

class _DriverDaitelsState extends State<DriverDaitels>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool city = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterTextField(
          icon: Icons.label,
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).idNumber = v;
          },
          label: 'رقم الهوية',
          type: TextInputType.text,
        ),
        SizedBox(height: 20),
        RegisterTextField(
          icon: Icons.label,
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).job = v;
          },
          label: 'الوظيفة',
          type: TextInputType.text,
        ),
        SizedBox(
          height: 20,
        ),
        RegisterTextField(
          icon: Icons.label,
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).bank = v;
          },
          label: 'البنك',
          type: TextInputType.text,
        ),
        SizedBox(height: 20),
        RegisterTextField(
          icon: Icons.label,
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).bankAccount = v;
          },
          label: 'الحساب البنكي',
          type: TextInputType.text,
        ),
        DateCard(onDate: (v) {
          Provider.of<SignUpProvider>(context, listen: false).barithDay = v;
        }),
        LabeledBottomSheet(
          label: '-- إختر المنطقة --',
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).regionId =
                v.id.toString();
            Provider.of<CitiesProvider>(context, listen: false).getCities(v.id.toString());
            setState(() {
              city = true;
            });
          },
          data: Provider.of<RegionsProvider>(context, listen: true).bottomSheet,
        ),
        LabeledBottomSheet(
          label: '-- إختر المدينة --',
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).cityId =
                v.id.toString();
          },
          ontap: city,
          data: Provider.of<CitiesProvider>(context, listen: true).cotiesSheet,
        ),
        LabeledBottomSheet(
          label: '-- إختر الجنسية --',
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).nationalityId =
                v.id.toString();
          },
          data: Provider.of<NationalitiesProvider>(context, listen: true)
              .bottomSheet,
        ),
        LabeledBottomSheet(
          label: '-- إختر نوع السيارة --',
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).carTypeId =
                v.id.toString();
          },
          data: Provider.of<CarTypeProvider>(context, listen: true).bottomSheet,
        ),
        LabeledBottomSheet(
          label: '-- إختر نوع الهوية --',
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).identityTypeId =
                v.id.toString();
          },
          data: Provider.of<IdentituTypeProvider>(context, listen: true)
              .bottomSheet,
        ),
        LabeledBottomSheet(
          label: '-- إختر التوصيل  --',
          onChange: (v) {
            Provider.of<SignUpProvider>(context, listen: false).deliveryType =
                v.id.toString();
          },
          data: [
            BottomSheetModel(
              id: 0,
              name: "سيارو عادية",
              realID: "0",
            ),
            BottomSheetModel(
              id: 1,
              name: "سيارو بيك اب",
              realID: "1",
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
