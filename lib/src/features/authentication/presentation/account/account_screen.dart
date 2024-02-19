import 'package:cart_scope/src/common_widgets/alert_dialogs.dart';
import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/action_text_button.dart';
import 'package:cart_scope/src/common_widgets/responsive_center.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(accountScreenControllerProvider, (previousState, state) {
      if (state.hasError) {
        showExceptionAlertDialog(
          context: context,
          title: 'Error'.hardcoded,
          exception: state.error,
        );
      }
    });

    final state = ref.watch(accountScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: state.isLoading ? const CircularProgressIndicator() : Text('Account'.hardcoded),
        actions: [
          state.isLoading
              ? const SizedBox()
              : ActionTextButton(
                  text: 'Logout'.hardcoded,
                  onPressed: () async {
                    // get the navigator before the async gap
                    final navigator = Navigator.of(context);
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are you sure?'.hardcoded,
                      cancelActionText: 'Cancel'.hardcoded,
                      defaultActionText: 'Logout'.hardcoded,
                    );
                    if (logout == true) {
                      final success =
                          await ref.read(accountScreenControllerProvider.notifier).signOut();
                      if (success) () => navigator.pop();
                    }
                  },
                ),
        ],
      ),
      body: const ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: UserDataTable(),
      ),
    );
  }
}

/// Simple user data table showing the uid and email
class UserDataTable extends StatelessWidget {
  const UserDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle2!;
    // TODO: get user from auth repository
    const user = AppUser(uid: '123', email: 'test@test.com');
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Field'.hardcoded,
            style: style,
          ),
        ),
        DataColumn(
          label: Text(
            'Value'.hardcoded,
            style: style,
          ),
        ),
      ],
      rows: [
        _makeDataRow(
          'uid'.hardcoded,
          user.uid,
          style,
        ),
        _makeDataRow(
          'email'.hardcoded,
          user.email ?? '',
          style,
        ),
      ],
    );
  }

  DataRow _makeDataRow(String name, String value, TextStyle style) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            name,
            style: style,
          ),
        ),
        DataCell(
          Text(
            value,
            style: style,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
