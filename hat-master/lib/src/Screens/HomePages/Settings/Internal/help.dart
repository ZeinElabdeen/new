
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haat/src/Helpers/sharedPref_helper.dart';
import 'package:haat/src/MainWidgets/custom_alert.dart';
import 'package:haat/src/MainWidgets/custom_app_bar.dart';
import 'package:haat/src/MainWidgets/details_text_field_no_img%20copy.dart';
import 'package:haat/src/MainWidgets/loader_btn.dart';
import 'package:haat/src/MainWidgets/register_text_field.dart';
import 'package:haat/src/Screens/DriverHome/mainPageDriver.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/AuthBLoCs/help_bloc.dart';
import 'package:provider/provider.dart';

import '../../main_page.dart';

class HelpCenter extends StatefulWidget {
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          iconData: Icons.arrow_back_ios,
          label: 'مركز المساعدة',
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<HelpBloc, AppState>(
        bloc: helpBloc,
        listener: (_, state) {
          if (state is Done) {
            CustomAlert().toast(context: context, title: 'تم إرسال رسالتك للإدارة');
           Provider.of<SharedPref>(context,listen: false).type == 1 ?
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => MainPage(
                  index: 2,
                ))):   
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainPageDriver(index: 1,)));
          }
        },
        child: BlocBuilder<HelpBloc, AppState>(
          bloc: helpBloc,
          builder: (_, state) {
            return ListView(
              children: [
                SizedBox(height: 50,),
                RegisterTextField(
                  label: 'عنوان الرسالة',
                  type: TextInputType.text,
                  errorText: state is TitleError ? 'عنوان الرسالة مطلوب' : null,
                  onChange: helpBloc.updateTitle,
                  icon: Icons.label,
                ),
                SizedBox(height: 20),
                DetailsTextFieldNoImg(
                  onChange: helpBloc.updateContent,
                  label: 'مُحتوى الرسالة',
                  errorText:
                      state is ContentError ? 'محتوى الرسالة مطلوب' : null,
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: LoaderButton(
                    onTap: () => helpBloc.add(Click()),
                    load: state is Loading ? true : false,
                    text: 'إرسال',
                    color: Theme.of(context).primaryColor,
                    txtColor: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
