import 'dart:async';

import 'package:ecommerce_app/Features/Navigation/Domain/Repository/navigation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Entities/product.dart';
import '../../Domain/Entities/wished.dart';

class WishesEvent{}
class WishesState{}
class InitialState extends WishesState{}
//Events
class WishesExtracted extends WishesEvent{

}
class DeleteWish extends WishesEvent{
  final String id;

  DeleteWish({required this.id});
}
class MakeWish extends WishesEvent{
  final Wished wish;

  MakeWish({required this.wish});
}
class GetWishedProducts extends WishesEvent{

}
class GetItemsCount extends WishesEvent{

}


//States
class SuccessState extends WishesState{
  final String message;

  SuccessState({required this.message});

}
class ItemsCountAchieved extends WishesState{
  final int count;

  ItemsCountAchieved({required this.count});

}
class WishLoadingState extends WishesState{}
class FailureState extends WishesState{
  final String message;

  FailureState({required this.message});
}
class WishedProductsExtractedState extends WishesState{
  final List<Product> products;

  WishedProductsExtractedState({required this.products});
}
class WishesExtractedState extends WishesState{
  final List<Wished> wishes;

  WishesExtractedState({required this.wishes});
}
class WishBloc extends Bloc<WishesEvent,WishesState>{
  final NavigationRepository _rep;
  WishBloc( this._rep):super(InitialState()){
    on<MakeWish>(_makeWish);
    on<DeleteWish>(_unWish);
    on<WishesExtracted>(_getWishes);
    on<GetWishedProducts>(_getWishedProducts);
    on<GetItemsCount>(_getItemsCount);
  }
  Future<void> _makeWish(MakeWish event, Emitter<WishesState> emit) async {
    final res=await _rep.wishItem(event.wish);
    res.fold((l) => emit(FailureState(message: l)), (r) => emit(SuccessState(message: r)));
  }

  Future<FutureOr<void>> _unWish(DeleteWish event, Emitter<WishesState> emit) async {
    final res=await _rep.unWishItem(event.id);
    res.fold((l) => emit(FailureState(message: l)), (r) => emit(SuccessState(message: r)));
  }

  Future<FutureOr<void>> _getWishes(WishesExtracted event, Emitter<WishesState> emit) async {
    emit(WishLoadingState());
    final res=await _rep.getWished();
    res.fold((l) => emit(FailureState(message: l)), (r) => emit(WishesExtractedState(wishes: r)));
  }
  Future<FutureOr<void>> _getWishedProducts(GetWishedProducts event, Emitter<WishesState> emit) async {
    emit(WishLoadingState());
    final res=await _rep.getWishedProducts();
    res.fold((l) => emit(FailureState(message: l)), (r) => emit(WishedProductsExtractedState(products: r)));
  }

  Future<FutureOr<void>> _getItemsCount(GetItemsCount event, Emitter<WishesState> emit) async {
    final res=await _rep.getTotalCartItems();
    res.fold((l) => null, (r) => emit(ItemsCountAchieved(count: r)));
  }
}