import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cantwait28/models/item_model.dart';
import 'package:cantwait28/repositories/items_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._itemRepository) : super(const HomeState());

  final ItemsRepository _itemRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemRepository.getItemsStream().listen(
      (items) {
        emit(HomeState(items: items));
      },
    )..onError(
        (error) {
          emit(const HomeState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemRepository.delete(id: documentID);
    } catch (error) {
      emit(
        const HomeState(removingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
