import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:organic/l10n/l10n.dart';
import 'package:organic/page/localization_app_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:organic/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:organic/page/register_page.dart';
import 'package:organic/page/register_detail_page.dart';
import 'package:organic/page/login_page.dart';
import 'package:organic/page/profile_page.dart';
import 'package:organic/page/request_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Localization';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: true,
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
            home: LocalizationAppPage(),
            routes: <String, WidgetBuilder>{
              "/register_page": (BuildContext context) => new RegisterPage(),
              "/register_detail_page": (BuildContext context) =>
                  new RegisterDetailPage(),
              "/login_page": (BuildContext context) => new LoginPage(),
              "/profile_page": (BuildContext context) => new ProfilePage(),
              "/request_page": (BuildContext context) => new RequestPage(),
            },
          );
        },
      );
}
