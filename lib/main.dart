import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:organic/l10n/l10n.dart';
import 'package:organic/methods/isauthenticated.dart';
import 'package:organic/page/ecommerce/customer_profile.dart';
import 'package:organic/page/ecommerce/home.dart';
import 'package:organic/page/help_desk_page.dart';
import 'package:organic/page/leaderboard.dart';
import 'package:organic/page/localization_app_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:organic/page/logged_in_home_page.dart';
import 'package:organic/page/my_orders.dart';
import 'package:organic/page/otp-verification.dart';
import 'package:organic/page/request_items.dart';
import 'package:organic/page/resources.dart';
import 'package:organic/page/user_type_page.dart';
import 'package:organic/page/your_rewards.dart';
import 'package:organic/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:organic/page/register_page.dart';
import 'package:organic/page/register_detail_page.dart';
import 'package:organic/page/profile_page.dart';
import 'package:organic/page/farmers_home.dart';
import 'package:localstorage/localstorage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Organic Express';
  final LocalStorage storage = new LocalStorage('organic');

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: Methods().isAuthenticated()
                ? RequestPage()
                : LocalizationAppPage(),
            routes: <String, WidgetBuilder>{
              "/register_page": (BuildContext context) => new RegisterPage(),
              "/register_detail_page": (BuildContext context) =>
                  new RegisterDetailPage(),
              "/profile_page": (BuildContext context) => new ProfilePage(),
              "/request_page": (BuildContext context) => new LoggedInHome(),
              "/otp_verification_page": (BuildContext context) =>
                  new OtpVerificationPage(),
              "/localization_page": (BuildContext context) =>
                  new LocalizationAppPage(),
              "/user_type_page": (BuildContext context) => new UserType(),
              "/help_desk": (BuildContext context) => new HelpDesk(),
              "/resources": (BuildContext context) => new Resources(),
              "/your_rewards": (BuildContext context) => new YourRewards(),
              "/leaderboard": (BuildContext context) => new Leaderboard(),
              "/shop_home": (BuildContext context) => new ShopHome(),
              "/customer_profile": (BuildContext context) =>
                  new CustomerProfile(),
              "/request_items": (BuildContext context) => new RequestItems(),
              "/my_orders": (BuildContext context) => new MyOrders(),
            },
          );
        },
      );
}
