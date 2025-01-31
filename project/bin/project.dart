// For i/o operations
import 'dart:io';

class Item{
  static int _serialcounter = 101;
  int serial;
  String name;
  String type;
  double price;
  int quantity;
  String slot;

  // For assigning values to variables
  Item(this.name, this.type, this.price, this.quantity, this.slot)
    :serial = _serialcounter++;
}

class Customer{
  String contactNumber;
  String name;
  List<Map<String, dynamic>> orderHistory = []; // dynamic is used to store multiple values

  Customer(this.contactNumber, this.name);
}

class RestaurantManager{
  String? userName;
  String? password;
  List<Item> itemList =[];
  Map<String, Customer> customerDetails = {};

  // To check whether Manager has signed in before or not
  void start(){
    if(userName == null || password == null){
      _signUp();
    }
    else{
      _login();
    }
  }

  // To signup ( "_" is used to make it private)
  void _signUp(){
    stdout.write("Enter Username : "); //stdout is used for user experience you can also use print statement
    userName = stdin.readLineSync(); //for inputing username from user

    stdout.write("Enter Password: ");
    password = stdin.readLineSync();

    print("\nSign Up Successfull \n\nPlease Login");

    _login();
  }

  // To login
  void _login(){
    while (true){
      stdout.write("Enter Username : ");
      String? user = stdin.readLineSync();

      stdout.write("Enter Password: ");
      String? pass = stdin.readLineSync();

      if(user == userName && pass == password){
        print("Login Successfull");
        _option();
        break;
      }
      else if(user == userName && pass != password){
        print("Entered Password is wrong! \nPlease Try Again!");
      }
      else {
        return _signUp();
      }
    }
  }

  // Manager options
  void _option(){
    while (true){
      print("\n Menu contains!");
      print("-----------------");
      print("1. Manage Stocks");
      print("2. Take Order");
      print("3. Manage Customer");
      print("4. Logout");

      stdout.write("Enter Option No: ");
      int? option = int.tryParse(stdin.readLineSync() ?? ""); // For inputing a integer

      switch(option){
        case 1:
          _manageStocks();
          break;
        case 2:
          _takeOrder();
          break;
        case 3:
          _manageCustomer();
          break;
        case 4:
          print("Loging Out....");
          print("Logout Successfull");
          return;
        default:
          print("Invalid Option!\nTry again?");
      }
    }
  }

  //For Managing Stocks
  void _manageStocks(){
    print("Stock Management");
    print("----------------");
    print("1. Add Items");
    print("2. Remove Items");

    stdout.write("Enter Option No: ");
    int? choice = int.tryParse(stdin.readLineSync() ?? "");

    switch(choice){
      case 1:
        stdout.write("Enter name of the item : ");
        String name = stdin.readLineSync()!; // "!" indicates the value will never be null

        stdout.write("Enter type of the item(Veg, Non-Veg) : ");
        String type = stdin.readLineSync()!.toLowerCase();
        while(type != 'veg' && type != 'non-veg'){
          print("Invalid input! Please enter(veg, non-veg)");
          String type = stdin.readLineSync()!.toLowerCase();
        }

        stdout.write("Enter price of the item : ");
        double price = double.parse(stdin.readLineSync()!); // for inputing a variable of type double

        stdout.write("Enter quantity of the item : ");
        int quantity = int.tryParse(stdin.readLineSync() ?? "") ?? 0; //for setting the quantity value as 0 in case if null is passed

        stdout.write("Enter slot of the item(Breakfast, Lunch, Dinner) : ");
        String slot = stdin.readLineSync()!.toLowerCase();
        while(slot != 'breakfast' && slot != 'lunch' && slot != 'dinner'){
          print("Invalid input! Please enter(Breakfast, Lunch, Dinner) : ");
          String slot = stdin.readLineSync()!.toLowerCase();
        }

        itemList.add(Item(name, type, price, quantity, slot));
        print("Item added Successfully ");
      case 2:
        stdout.write("Enter Serial Number of Item to be removed : ");
        int? id = int.tryParse(stdin.readLineSync() ?? "");
        itemList.removeWhere((item) => item.serial == id);// To remove item
        print("Item removed successfully");
    }
  }

  void _takeOrder(){
    stdout.write("Enter Customer Contact No: ");
    String contactNumber = stdin.readLineSync()!;

    if(!(customerDetails.containsKey(contactNumber))){
      stdout.write("Enter Customer Name : ");
      String name = stdin.readLineSync()!;
      customerDetails[contactNumber] = Customer(contactNumber, name);
    }
    else{
      var customer = customerDetails[contactNumber]!;
      print("Welcome Back (Mr, Mrs) ${customer}");
      if(customer.orderHistory.isNotEmpty) {
        print("Last order : ${customer.orderHistory.last}");
        print("Want to reorder the item?(Yes/ No) : ");
        String opt = stdin.readLineSync()!.toLowerCase();
        if(opt == "yes"){
          var lastOrder = customer.orderHistory.last;
          for(var orderItems in lastOrder["items"]){
            Item selectedItem = itemList.firstWhere((item) => item.name == orderItems["name"]);
            if(selectedItem.quantity >= orderItems["quantity"]){
              selectedItem.quantity -= (orderItems["quantity"] as num?)?.toInt() ?? 0;
              print("Final Amount : ${lastOrder["total"]}");
            }
            else {
              print("Not enough quantity available!..");
            }
          }
        }
      }
    }

    stdout.write("Enter Slot(Breakfast, Lunch, Dinner) : ");
    String slot = stdin.readLineSync()!;

    List<Item> availableItems = itemList.where((item) => item.slot == slot).toList();
    if(availableItems.isEmpty){
      print("No items are available for this slot");
      return;
    }

    List<Map<String, dynamic>> cart = [];
    print("Available items are : ");
    for(var item in availableItems){
      print("${item.serial} : ${item.name} - Rs.${item.price} , ${item.quantity}Nos");
    }

    while(true){
      stdout.write("Enter Serial Number of item to be purchased(or type 'done' to finish) : ");
      String input = stdin.readLineSync()!.toLowerCase();

      if(input == "done"){
        break;
      }

      int serial = int.parse(input);
      Item? selectedItems = itemList.firstWhere((item) => item.serial == serial, orElse: () => Item("", "", 0.0, 0, ""));
      if(selectedItems.name == ""){
        print("Invalid Serial No! Try Again");
        continue;
      }

      stdout.write("Enter the quantity of ${selectedItems.name} to be purchased : ");
      int quantity = int.parse(stdin.readLineSync()!);

      if(quantity > selectedItems.quantity){
        print("Not enough quantity available!..");
        continue;
      }

      cart.add({"name": selectedItems.name, "price": selectedItems.price, "quantity": selectedItems.quantity});
      selectedItems.quantity -= quantity;

      double total = cart.fold(0, (sum, item) => sum + (item["price"] * item["quantity"])); // to find the total value
      double discount;
      if(total > 1000){
        discount = total * 0.05;
      }
      else if(total > 500){
        discount = total * 0.025;
      }
      else{
        discount = 0;
      }
      double gst = (total - discount) * 0.05;
      double finalAmount = total - discount + gst;

      print("Bill for items is ");
      print("Total : ${total}");
      print("Discount : ${discount}");
      print("GST : ${gst}");
      print("Final Amount : ${finalAmount}");

      customerDetails[contactNumber]!.orderHistory.add({"items": cart, "total": finalAmount});
      print("Order Placed Successfully");
    }
  }

  // To manage customer details
  void _manageCustomer(){
    print("Manager Customer");
    print("----------------");
    stdout.write("Enter Customer Contact No: ");
    String contactNumber = stdin.readLineSync()!;

    if(customerDetails.containsKey(contactNumber)){
      print("Customer found ${customerDetails[contactNumber]!.name}");
      print("Options Available are :");
      print("1. Change the name");
      print("2. Change the contact number");
      print("3. Delete a customer");

      stdout.write("Enter Option No : ");
      int opt = int.parse(stdin.readLineSync()!);

      switch(opt) {
        case 1:
          stdout.write("Enter the new name : ");
          customerDetails[contactNumber]!.name = stdin.readLineSync()!;
          break;
          case 2:
            stdout.write("Enter the new contact number : ");
            String newContact = stdin.readLineSync()!;
            customerDetails[newContact] = customerDetails.remove(contactNumber)!;
            break;
          case 3:
            customerDetails.remove(contactNumber)!;
            print("Customer Deleted Successfully");
            break;
          default:
            print("Invalid Option");
            break;
      }
    }
  }
}

void main(){
  print("\nWELCOME TO RESTAURANT MANAGEMENT SYSTEM!");
  print("----------------------------------------\n");
  RestaurantManager manager = RestaurantManager();
  manager.start();
  print("Thank You!....");
}