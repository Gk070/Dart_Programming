import 'package:args/args.dart';

void main()
{
  var quantity_ModelX = 5;
  if(quantity_ModelX < 1){
    print("Model X out of stock!!");
  }

  var price_ModelX = 100000;

  var quantity_ModelY = 5;
  if(quantity_ModelY < 1){
    print("Model Y out of stock!!");
  }

  var price_ModelY = 200000;

  var customerAccountNo = 110023;
  bool isValidAccountNumber(int customerAccountNo) {
    var accountNoStr = customerAccountNo.toString();
    return accountNoStr.length == 6 && accountNoStr.startsWith('10');
  }
  if(!isValidAccountNumber(customerAccountNo)){
    print("Invalid Account Number!!");
  }
  var customerAccountBalance = 300000;

  var model = 'Model-X';

  if(model != 'Model-X' && model != 'Model-Y'){
    print("Invalid Model!!");
  }

  var shippingDistance = 100;
  int shippingCost;

  int calculateShippingCost(int shippingDistance){
    int first25Kms = 25;
    int addFare = 35;

    if(shippingDistance <= 50){
      shippingCost = first25Kms;
    }
    else{
      shippingCost = first25Kms + (shippingDistance - 50) * addFare;
    }
    return shippingCost;
  }
  shippingCost = calculateShippingCost(shippingDistance);

  if(model == 'Model-X'){
    var totalPrice = price_ModelX + 0.24 * price_ModelX + shippingCost;
  }
  else if(model == 'Model-Y')
  {
    var totalPrice = price_ModelY + 0.24 * price_ModelY + shippingCost;
  }
}