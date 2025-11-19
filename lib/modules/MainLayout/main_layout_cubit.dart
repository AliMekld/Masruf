import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilities/shared_pref.dart';
import '../../widgets/Dialogs/expenses_dialog_detail_widget.dart';
import '../../widgets/Dialogs/income_dialog_detail_widget.dart';
import '../../widgets/DialogsHelper/dialog_widget.dart';
import '../Categories/Controller/categories_bloc.dart';
import '../Categories/Model/DataSource/categories_local_data_source.dart';
import '../Categories/View/Widgets/categoty_dialog_detail_widget.dart';
import '../Expenses/expenses_controller.dart';
import '../Income/income_controller.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit()
      : super(MainLayoutState(
            currentIndex: 0, isExpanded: SharedPref.getIsSideBarExpanded()));

  void onToggleExpanded(bool value) {
    emit(state.copyWith(isExpanded: value));
    SharedPref.setIsSideBarExpanded(value: state.isExpanded ?? false);
  }

  void onChangeSelected(int value) => emit(state.copyWith(currentIndex: value));

  bool isCurrent(int index) => state.currentIndex == index;
  bool get isCreateButtonVisible =>
      state.currentIndex == 1 ||
      state.currentIndex == 2 ||
      state.currentIndex == 3;

  bool get isExpanded => state.isExpanded ?? false;

  void onAddBasedOnScreen(BuildContext context) {
    int currentIndex = state.currentIndex ?? 0;

    if (state.currentIndex == 1) {
      DialogHelper.customDialog(
          child: ExpensesDialogDetailWidget(
        onEditExpense: (model) =>
            ExpensesController().onAddUpdateExpense(model),
      )).showDialog(context);
      return;
    }
    if (currentIndex == 2) {
      DialogHelper.customDialog(
          child: BlocProvider.value(
        value: CategoriesBloc(
            CategoriesLocalDataSource() /*CategoriesRepositoryImp(isConnected: context.read<NetworkCheckerNotifier>().isConnected)*/),
        child: CategoryDialogDetailWidget(
          id: null,
          onInsertUpdateCategory: (model) {
            if (model != null) {
              context.read<CategoriesBloc>().add(InsertCategoryEvent(model));
            }
          },
        ),
      )).showDialog(context);
      return;
    }
    if (currentIndex == 3) {
      DialogHelper.customDialog(
          child: IncomeDialogDetailWidget(
        onEditIcome: (model) => IncomeController().onAddUpdateIncom(model),
      )).showDialog(context);
      return;
    }
  }
}

class MainLayoutState extends Equatable {
  final int? currentIndex;
  final bool? isExpanded;

  const MainLayoutState({this.currentIndex, this.isExpanded});
  MainLayoutState copyWith({
    int? currentIndex,
    bool? isExpanded,
  }) {
    return MainLayoutState(
      currentIndex: currentIndex ?? this.currentIndex,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        isExpanded,
      ];
}
