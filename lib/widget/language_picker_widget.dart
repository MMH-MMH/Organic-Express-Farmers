import 'package:flutter/material.dart';
import 'package:organic/l10n/l10n.dart';
import 'package:organic/provider/locale_provider.dart';
import 'package:provider/provider.dart';

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: locale,
          icon: Icon(Icons.arrow_downward),
          items: L10n.all.map(
            (locale) {
              final flag = L10n.getFlag(locale.languageCode);

              return DropdownMenuItem(
                child: Container(
                  child: Text(
                    flag,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                value: locale,
                onTap: () {
                  final provider =
                      Provider.of<LocaleProvider>(context, listen: false);

                  provider.setLocale(locale);
                },
              );
            },
          ).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
