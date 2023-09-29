part of 'transaction_bloc.dart';

abstract class TransactionState {}
class TransactionLoading extends TransactionState {

}

class TransactionLoaded extends TransactionState{
  List<TransactionObj> transactions;
  TransactionLoaded({this.transactions = const []});
}
