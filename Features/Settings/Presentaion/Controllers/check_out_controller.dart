import '../../domain/Entities/cart_entity.dart';

class CheckOutController{
  List<String> productIds(List<CartItem> items){
    List<String> id=[];
    for(CartItem item in items) {
      id.add(item.id);
    }
    return id;
  }
}