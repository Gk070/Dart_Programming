void main(){
  try{
    var order1 = order(2, 'Biriyani', 'N', 180, false);
    print(order1.displayCombo());
    var placeOrderClosure = order1.placeOrder();
    placeOrderClosure();
  }
  catch(e){
    print('Error : ${e}');
  }
}

class order{
  int quantity;
  String itemName;
  String itemType;
  double itemPrice;
  bool customization;

  order(this.quantity, this.itemName, this.itemType, this.itemPrice, this.customization) {
    if (itemType != 'V' && itemType != 'N') {
      throw Exception("InvalidOption");
    }
    if (quantity <= 0) {
      throw Exception("InvalidQuantity");
    }
    if (itemPrice <=0){
      throw Exception("InvalidPrice");
    }
  }

  String displayCombo() {
    return '''
    Todays special combos
    ------------------------------------
    1. Veg Thali Combo (₹300): Includes Paneer Curry, Dal, Rice, and Roti.
    2. Non-Veg Thali Combo (₹350): Includes Chicken Curry, Dal, Rice, and Roti.
    3. Family Combo (₹1200): Includes 4 Veg Curries, 4 Rotis, Rice, and Dessert.
    4. Snack Combo (₹200): Includes Samosa, Pakora, and Tea.
    5. Special Combo (₹500): Includes Veg or Non-Veg Curry, Biryani, and Dessert.
    ''';
  }

  Function placeOrder(){
    return(){
      print("Order Placed Successfully");
      print("Total Price is : ${itemPrice * quantity}");
    };
  }
}
