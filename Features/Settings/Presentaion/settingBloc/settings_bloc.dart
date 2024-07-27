
import 'dart:async';
import 'dart:io';

import 'package:ecommerce_app/Core/Entities/user.dart';
import 'package:ecommerce_app/Features/Settings/domain/Repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/Entities/address.dart';
import '../../domain/Entities/cart_entity.dart';
import '../../domain/Entities/order_entity.dart';

//States
class SettingState {}

class InitialState extends SettingState {}

class LoadingState extends SettingState {}

class SignedOut extends SettingState {}
//Cart State
class CartItemExtracted extends SettingState {
  final List<CartItem> items;

  CartItemExtracted({required this.items});
}
class CartItemDeletedState extends SettingState{
  final String message;

  CartItemDeletedState({required this.message});
}
//orders State
class OrdersExtracted extends SettingState {
  final List<Orders> orders;

  OrdersExtracted({required this.orders});
}

class SuccessState extends SettingState {
  //AddressStates
  final String message;

  SuccessState({required this.message});
}
class AddedToCartState extends SettingState {
  //AddressStates
  final String message;

  AddedToCartState({required this.message});
}

class AddressAchieved extends SettingState {
  final List<Address> addresses;

  AddressAchieved({required this.addresses});
}
//Profile State
class ProfileRetrieved extends SettingState {
  final UserModel profile;


  ProfileRetrieved({required this.profile});
}

class FailedState extends SettingState {
  final String message;

  FailedState({required this.message});
}

//SettingsEvents
class SettingsEvent {}

class SignOutEvent extends SettingsEvent {}

class GetCartItemsEvent extends SettingsEvent {} //CartEvents

class DeleteCartItems extends SettingsEvent {
  final String code;
  final bool all;
  DeleteCartItems( {required this.all,required this.code});
}

class AddToCartEvent extends SettingsEvent {
  final CartItem item;

  AddToCartEvent({required this.item});
}

class MakeOrdersEvent extends SettingsEvent {
  //Orders Events
  final Orders item;

  MakeOrdersEvent({required this.item});
}

class GetOrdersEvent extends SettingsEvent {}

class NewAddressEvent extends SettingsEvent {
  final Address address;

  NewAddressEvent({required this.address});
} //AddressEvents

class DeleteAddressEvent extends SettingsEvent {
  final String addressId;

  DeleteAddressEvent({required this.addressId});
}

class GetAddressEvent extends SettingsEvent {
  final bool? first;

  GetAddressEvent({this.first});
}
class GetProfileDataEvent extends SettingsEvent {

}
class AddProfilePicture extends SettingsEvent{
  final File image;

  AddProfilePicture({required this.image});
}

class SettingsBloc extends Bloc<SettingsEvent, SettingState> {
  final SettingsRepository _rep;
  SettingsBloc(this._rep) : super(InitialState()) {
    on<SignOutEvent>(_signOut);
    on<SettingsEvent>((event, emitter) => emitter(LoadingState()));
    //Cart
    on<AddToCartEvent>(_addToCart);
    on<GetCartItemsEvent>(_getCartItems);
    on<DeleteCartItems>(_deleteCartItems);
    //order
    on<MakeOrdersEvent>(_makeOrder);
    on<GetOrdersEvent>(_getOrders);
    //Address
    on<NewAddressEvent>(_addAddress);
    on<DeleteAddressEvent>(_deleteAddress);
    on<GetAddressEvent>(_getAddresses);

    //Profile
    on<GetProfileDataEvent>(_getProfile);
    on<AddProfilePicture>(_addProfile);
  }
  Future<void> _signOut(SignOutEvent event, Emitter emit) async {
    final res = await _rep.signOut();
    res.fold((l) => emit(FailedState(message: l)), (r) => emit(SignedOut()));
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter emit) async {
    final res = await _rep.addCartItems(event.item);
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(AddedToCartState(message: r)));
  }

  Future<void> _getCartItems(GetCartItemsEvent event, Emitter emit) async {
    final res = await _rep.getCartItems();
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(CartItemExtracted(items: r)));
  }

  Future<void> _deleteCartItems(DeleteCartItems event, Emitter emit) async {
    final res = await _rep.deleteCartItems(event.code,event.all);
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(CartItemDeletedState(message: r)));
  }

  Future<void> _makeOrder(MakeOrdersEvent event, Emitter emit) async {
    final res = await _rep.makeOrder(event.item);
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(SuccessState(message: r)));
  }

  Future<void> _getOrders(GetOrdersEvent event, Emitter emit) async {
    final res = await _rep.getOrders();
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(OrdersExtracted(orders: r)));
  }

  Future<void> _addAddress(NewAddressEvent event, Emitter emit) async {
    final res = await _rep.addAddress(event.address);
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(SuccessState(message: r)));
  }

  Future<void> _deleteAddress(DeleteAddressEvent event, Emitter emit) async {
    final res = await _rep.deleteAddress(event.addressId);
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(SuccessState(message: r)));
  }

  Future<void> _getAddresses(GetAddressEvent event, Emitter emit) async {
    final res = await _rep.getAddresses(event.first);
    res.fold((l) => emit(FailedState(message: l)),
        (r) => emit(AddressAchieved(addresses: r)));
  }

  Future<FutureOr<void>> _getProfile(GetProfileDataEvent event, Emitter<SettingState> emit) async {
    final res = await _rep.getUserData();
    res.fold((l) => emit(FailedState(message: l)),
            (r) => emit(ProfileRetrieved(profile: r)));
  }

  Future<FutureOr<void>> _addProfile(AddProfilePicture event, Emitter<SettingState> emit) async {
    final res = await _rep.uploadProfilePicture(event.image);
    res.fold((l) => emit(FailedState(message: l)),
            (r) => emit(SuccessState(message: r)));
  }
}
