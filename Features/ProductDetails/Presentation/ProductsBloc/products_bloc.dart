import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Entities/product.dart';
import '../../Domain/ProductRepository/product_repository.dart';

//States
class ProductsState{}
class InitialState extends ProductsState{}
class FailureState extends ProductsState{
  final String message;
  FailureState({required this.message});
}
class LoadingState extends ProductsState{}
class SuccessState extends ProductsState{
  final String message;

  SuccessState({required this.message});
}
class RetrievedState extends ProductsState{
  final List<Product> products;
  RetrievedState({required this.products});
}
//Events
class ProductsEvents{}
class AddProductsEvent extends ProductsEvents{
  final Product product;
  final List<File> images;
  AddProductsEvent( {required this.images,required this.product});
}
class UpdateProducts extends ProductsEvents{
  final String id;
  final String? off;
  final String? title;
  final String? brand;
  final String? price;
  final int? likes;
  final String? category;
  List<String>? imageUrl;
  final String? description;
  final List<String>? sizes;
  final List<String>? colors;

  UpdateProducts(this.id,{ this.off, this.title, this.brand, this.price, this.likes, this.category, this.description, this.sizes, this.colors});
}
class RetrieveFeatured extends ProductsEvents{
}
class RetrieveBranded extends ProductsEvents{
  final String brand;

  RetrieveBranded({required this.brand});
}
class RetrieveCategorized extends ProductsEvents{
  final String category;

  RetrieveCategorized({required this.category});
}
class DeleteProductsEvent extends ProductsEvents
{
  final String id;

  DeleteProductsEvent({required this.id});
}
class ProductsBloc extends Bloc<ProductsEvents,ProductsState>
{
  final ProductRepository rep;
  ProductsBloc(this.rep):super(InitialState())
  {
    on<ProductsEvents>((event,emit)=>emit(LoadingState()));

    on<AddProductsEvent>(_add);
    on<DeleteProductsEvent>(_delete);
    on<RetrieveFeatured>(_retrieveFeatured);
  }

  Future<void> _add(AddProductsEvent event,Emitter<ProductsState> emit)
  async {
    
    final res=await rep.uploadProduct(event.product,event.images);
    res.fold((l) => emit(SuccessState(message: l)), (r) => emit(FailureState(message: r)));
  }
  Future<void> _delete(DeleteProductsEvent event,Emitter<ProductsState> emit)
  async {
    final res=await rep.deleteProduct(event.id);
    res.fold((l) => emit(SuccessState(message: l)), (r) => emit(FailureState(message: r)));
  }
  Future<void> _retrieveFeatured(RetrieveFeatured event,Emitter<ProductsState> emit)
  async {
    final res=await rep.retrieveFeatured();
    res.fold((l) => emit(SuccessState(message: l)), (r) => emit(RetrievedState(products: r)));
  }
}