import 'package:flutter/material.dart';
import 'package:masrof/modules/Wallet/wallet_controller.dart';
import 'package:masrof/utilites/extensions.dart';
import 'package:masrof/widgets/tables/expense_table.dart';
import 'package:state_extended/state_extended.dart';

class WalletScreen extends StatefulWidget {
  static const String routerName = 'WalletScreen';
  const WalletScreen({super.key});

  @override
  StateX<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends StateX<WalletScreen> {
  
  _WalletScreenState() : super(controller: WalletController()) {
    con = WalletController();
  }
  late WalletController con;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseTable(
          onEditExpense: (model) => con.onAddUpdateExpense(model),
          expensesList: con.tableList,
          context: context,
        ).expand,
      ],
    );
  }
}
