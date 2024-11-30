import 'package:flutter/material.dart';
import 'package:masrof/modules/Wallet/wallet_controller.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/tables/expense_table.dart';

class WalletScreen extends StatefulWidget {
  static const String routerName = 'WalletScreen';
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseTable(
          expensesList: WalletController().tableList,
          context: context,
        ).expand,
      ],
    );
  }
}
