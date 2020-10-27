import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Helpers/map_helper.dart';
import 'Helpers/sharedPref_helper.dart';
import 'Intro/splash_screen.dart';
import 'provider/aboutUsProvider.dart';
import 'provider/auth/UserSignProvider.dart';
import 'provider/auth/confirmResetCodeProvider.dart';
import 'provider/auth/forgetPasswordProvider.dart';
import 'provider/auth/logOutProvider.dart';
import 'provider/auth/loginProvider.dart';
import 'provider/auth/phoneVerificationProvider.dart';
import 'provider/auth/registerMobileProvider.dart';
import 'provider/auth/resendCode.dart';
import 'provider/auth/resetPasswordProvider.dart';
import 'provider/auth/signUpProvider.dart';
import 'provider/changeData/changePasswordProvider.dart';
import 'provider/changeData/changePhoneCodeProvider.dart';
import 'provider/changeData/changePhoneProvider.dart';
import 'provider/changeData/editAcountProvider.dart';
import 'provider/changeData/editDrivarDataProvider.dart';
import 'provider/get/CarTypeProvider.dart';
import 'provider/get/IdentityTypeProvider.dart';
import 'provider/get/MyAddressProvider.dart';
import 'provider/get/NationalitiesProvider.dart';
import 'provider/get/RegionsProvider.dart';
import 'provider/get/cartsProvider.dart';
import 'provider/get/citiesProvider.dart';
import 'provider/get/clearBagProvider.dart';
import 'provider/get/deleteBagOrderProvider.dart';
import 'provider/get/deletePlaceProvider.dart';
import 'provider/get/departmentsProvider.dart';
import 'provider/get/getUserDataProvider.dart';
import 'provider/get/orderStateProvider.dart';
import 'provider/get/restourantProvider.dart';
import 'provider/get/setting.dart';
import 'provider/getMapImageProvider.dart';
import 'provider/post/avibalatyProvider.dart';
import 'provider/post/createOrderProvider.dart';
import 'provider/post/createPlaceProvider.dart';
import 'provider/post/editCarDataProvider.dart';
import 'provider/post/editOrderCartProvider.dart';
import 'provider/post/finishOrderProvider.dart';
import 'provider/post/postCartProvider.dart';
import 'provider/post/subscribeProvider.dart';
import 'provider/termsProvider.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;

  const MyApp({Key key, this.navigator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SharedPref()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterMobileProvider()),
        ChangeNotifierProvider(create: (_) => PhoneVerificationProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => SignUpUserProvider()),
        ChangeNotifierProvider(create: (_) => ResendCodeProvider()),
        ChangeNotifierProvider(create: (_) => CarTypeProvider()),
        ChangeNotifierProvider(create: (_) => DepartMentProvider()),
        ChangeNotifierProvider(create: (_) => IdentituTypeProvider()),
        ChangeNotifierProvider(create: (_) => NationalitiesProvider()),
        ChangeNotifierProvider(create: (_) => RegionsProvider()),
        ChangeNotifierProvider(create: (_) => CitiesProvider()),
        ChangeNotifierProvider(create: (_) => RestourantsProvider()),
        ChangeNotifierProvider(create: (_) => CreateOrderProvider()),
        ChangeNotifierProvider(create: (_) => CartsProvider()),
        ChangeNotifierProvider(create: (_) => ClearBagProvider()),
        ChangeNotifierProvider(create: (_) => DeleteBagOrderProvider()),
        ChangeNotifierProvider(create: (_) => MyAddressProvider()),
        ChangeNotifierProvider(create: (_) => PostCartProvider()),
        ChangeNotifierProvider(create: (_) => CreatePlaceProvider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ConfirmResetCodeProvider()),
        ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => AboutUsProvider()),
        ChangeNotifierProvider(create: (_) => TermsProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (_) => EditUserDataProvider()),
        ChangeNotifierProvider(create: (_) => ChangeMobileProvider()),
        ChangeNotifierProvider(create: (_) => ChangePhoneCodeProvider()),
        ChangeNotifierProvider(create: (_) => MapHelper()),
        ChangeNotifierProvider(create: (_) => GetMapImage()),
        ChangeNotifierProvider(create: (_) => EditDriverDataProvider()),
        ChangeNotifierProvider(create: (_) => DeletePlaceProvider()),
        ChangeNotifierProvider(create: (_) => EditCartOrderProvider()),
        ChangeNotifierProvider(create: (_) => OrderStateProcider()),
        ChangeNotifierProvider(create: (_) => EditCarDataProvider()),
        ChangeNotifierProvider(create: (_) => GetUserDataProvider()),
        ChangeNotifierProvider(create: (_) => AvailabilityProvider()),
        ChangeNotifierProvider(create: (_) => SubscribeProvider()),
        ChangeNotifierProvider(create: (_) => FinishOrderProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => LogOutProvider()),

      ],
      child: MaterialApp(
        navigatorKey: navigator,
        debugShowCheckedModeBanner: false,
        title: "هات",
        theme: ThemeData(
            accentColor: Color.fromRGBO(249, 22, 43, 1.0),
            primaryColor: Color.fromRGBO(246, 144, 47, 1.0),
            fontFamily: "cairo"),
        home: Splash(
          navigator: navigator,
        ),
      ),
    );
  }
}
