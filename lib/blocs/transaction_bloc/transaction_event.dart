part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent extends Equatable{
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransaction extends TransactionEvent{
  final List<TransactionObj> transactions;

  const LoadTransaction({this.transactions = const []});

  @override
  List<Object> get props => [transactions];
}

class InitTransaction extends TransactionEvent{
  final String uid;
  const InitTransaction({required this.uid});
}