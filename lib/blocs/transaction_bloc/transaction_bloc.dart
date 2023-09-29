import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotmii/database.dart';
import '../../components/constants.dart';
import '../../main.dart';
import '../../models/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionLoading()) {
    on<LoadTransaction>(_loadTransaction);
    on<InitTransaction>(_initTransactions);
  }
  _loadTransaction(LoadTransaction event,Emitter<TransactionState> emit)async{

  }

  _initTransactions(InitTransaction event,Emitter<TransactionState> emit) async{
    List<TransactionObj> transList = [];
    try {
      emit(TransactionLoading());
      final transactions = jsonDecode(await Database(url: url).send({
        "req" : "transaction",
        "uid" : event.uid
      }));
      transactions!.forEach((transaction) {
        transList.add(TransactionObj.convert(transaction));
      });
      emit(TransactionLoaded(transactions: transList));
    } catch (error) {
      print(error);
    }
  }

}
