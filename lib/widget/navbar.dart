import 'package:flutter/material.dart';
import 'package:organic/methods/isauthenticated.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isAuth;
  Icon log;
  String nextRoute;

  @override
  void initState() {
    super.initState();

    isAuth = Methods().isAuthenticated();
    log = isAuth ? Icon(Icons.logout) : Icon(Icons.login);
    nextRoute = isAuth ? "/localization_page" : "/register_page";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                fit: BoxFit.none,
                image: NetworkImage(
                  'https://static.thenounproject.com/png/3237155-200.png',
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(
              AppLocalizations.of(context).chooseADifferentLanguage,
            ),
            onTap: () =>
                {Navigator.of(context).pushNamed('/localization_page')},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(AppLocalizations.of(context).profile),
            onTap: () => {Navigator.of(context).pushNamed('/profile_page')},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text(AppLocalizations.of(context).myOrders),
            onTap: () => {Navigator.of(context).pushNamed('/my_orders')},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).settings),
            leading: Icon(Icons.settings),
            onTap: () =>
                {Navigator.of(context).pushNamed('/localization_page')},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context).logout),
            onTap: () => {
              Methods().logout(context),
              Navigator.of(context).pushNamed('/localization_page'),
            },
          ),
        ],
      ),
    );
  }
}
