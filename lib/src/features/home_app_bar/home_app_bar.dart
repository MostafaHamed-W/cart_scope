import 'package:cart_scope/src/app.dart';
import 'package:cart_scope/src/constants/breakpoints.dart';
import 'package:cart_scope/src/features/account/account_screen.dart';
import 'package:cart_scope/src/features/orders_list/orders_list_screen.dart';
import 'package:cart_scope/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:cart_scope/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/models/app_user.dart';
import 'package:cart_scope/src/localization/languages.dart';
import 'package:cart_scope/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/action_text_button.dart';
import 'package:cart_scope/src/features/home_app_bar/more_menu_button.dart';
import 'package:cart_scope/src/features/home_app_bar/shopping_cart_icon.dart';
import 'package:cart_scope/src/localization/language_constants';
import 'package:cart_scope/src/localization/language_constants';
import 'package:go_router/go_router.dart';

/// Custom [AppBar] widget that is reused by the [ProductsListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: get user from auth repository
    const user = AppUser(uid: '123', email: 'test@test.com');
    // * This widget is responsive.
    // * On large screen sizes, it shows all the actions in the app bar.
    // * On small screen sizes, it shows only the shopping cart icon and a
    // * [MoreMenuButton].
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: Text(tr(context).myShop),
        actions: const [
          DropDownLanguageButton(),
          ShoppingCartIcon(),
          CalendarPicker(),
          MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: Text('My Shop'.hardcoded),
        actions: [
          const ShoppingCartIcon(),
          if (user != null) ...[
            ActionTextButton(
              key: MoreMenuButton.ordersKey,
              text: 'Orders'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.orders.name),
            ),
            ActionTextButton(
              key: MoreMenuButton.accountKey,
              text: 'Account'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.account.name),
            ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.signIn.name),
            ),
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class CalendarPicker extends StatelessWidget {
  const CalendarPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(DateTime.now().year + 20),
          );
        },
        icon: const Icon(Icons.calendar_month));
  }
}

class DropDownLanguageButton extends StatelessWidget {
  const DropDownLanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Language value = Language.languageList().first;
    return DropdownButton<Language>(
      padding: EdgeInsets.zero,
      underline: const SizedBox(),
      icon: const Icon(
        Icons.language,
        color: Colors.white,
      ),
      items: Language.languageList()
          .map(
            (language) => DropdownMenuItem<Language>(
              value: language,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    language.flag,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(language.name)
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (language) async {
        if (language != null) {
          Locale locale = await setLocale(language.languageCode);
          if (context.mounted) {
            CartScope.setLocale(context, locale);
          }
        }
      },
    );
  }
}
