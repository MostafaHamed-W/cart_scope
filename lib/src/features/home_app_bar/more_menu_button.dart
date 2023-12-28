import 'package:cart_scope/src/features/account/account_screen.dart';
import 'package:cart_scope/src/features/orders_list/orders_list_screen.dart';
import 'package:cart_scope/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:cart_scope/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/models/app_user.dart';

enum PopupMenuOption {
  signIn,
  orders,
  account,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({super.key, this.user});
  final AppUser? user;

  // * Keys for testing using find.byKey()
  static const signInKey = Key('menuSignIn');
  static const ordersKey = Key('menuOrders');
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return user != null
            ? <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: ordersKey,
                  value: PopupMenuOption.orders,
                  child: Text('Orders'.hardcoded),
                ),
                PopupMenuItem(
                  key: accountKey,
                  value: PopupMenuOption.account,
                  child: Text('Account'.hardcoded),
                ),
              ]
            : <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: signInKey,
                  value: PopupMenuOption.signIn,
                  child: Text('Sign In'.hardcoded),
                ),
              ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.signIn:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                ),
              ),
            );
            break;
          case PopupMenuOption.orders:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const OrdersListScreen(),
              ),
            );
            break;
          case PopupMenuOption.account:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const AccountScreen(),
              ),
            );
            break;
        }
      },
    );
  }
}
