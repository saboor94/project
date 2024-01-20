import 'dart:io';
import 'order.dart';
import 'product.dart';
import 'login.dart';

void main() {
  print('      "WELCOME"\n   "TO SUPER MART"');
  List<Product> products = [
    new Product('chicken 1kg', 660, 60),
    new Product('tomato 1kg', 120, 30),
    new Product('meat 1kg', 2000, 10),
    new Product('onion 1kg', 220, 10),
    new Product('mint', 20, 15),
    new Product('egg 1dozen', 400, 10),
    new Product('milk 1liter', 250, 50),
    new Product('bread', 120, 30),
    new Product('ketchup 250gm', 240, 20),
    new Product('butter 250gm', 295, 15),
    new Product('lays yellow', 30, 20),
    new Product('coke 500ml', 100, 40),
    new Product('coke 1.5liter', 660, 60)
  ];
  for (var item in products) {
    item.printproductnameandprice();
  }
  print('WANT TO SERACH BY NAME\notherwise leave it blank');
  var serach = stdin.readLineSync()!.toLowerCase();
  if (serach != '') {
    for (var item in products) {
      item.printalphabetserach(serach);
    }
  }
  print('WANT TO SERACH BY PRICE\notherwise leave it blank');
  var serachprice = stdin.readLineSync()!.toLowerCase();
  if (serachprice != '') {
    int price = int.parse(serachprice);
    for (var item in products) {
      item.printpriceserach(price);
    }
  }
  print('TO ORDER PLEASE SIGN IN');
  var email;
  var password;
  var attempts = 1;
  print(
      'WANT TO SIGN UP OR SIGN IN\nwrite "sign up" or "sign in"\n to perform action');
  var output = stdin.readLineSync()!.toLowerCase();
  if (output == 'sign up') {
    print('You Have 3 Attempts For Sign up');
    for (var i = 0; i < 3; i++) {
      print('ATTEMPT # $attempts');
      print('ENTER EMAIL FOR SIGN UP');
      email = stdin.readLineSync()!.toLowerCase();
      print('ENTER PASSWORD FOR SIGN UP');
      password = stdin.readLineSync()!.toLowerCase();
      signup user = signup(email, password);
      if (user.signupcount == true) {
        output = 'sign in';
        break;
      }
      attempts++;
    }
  }
  var login = false;
  bool admin = false;
  if (output == 'sign in') {
    print('You Have 3 Attempts For Sign in');
    print('SIGN IN');
    for (var i = 0; i < 3; i++) {
      print('ENTER EMAIL');
      email = stdin.readLineSync()!.toLowerCase();
      print('ENTER PASSWORD');
      password = stdin.readLineSync()!.toLowerCase();
      signin user = signin(email, password);
      if (user.login == true) {
        if (user.roll == true) {
          admin = true;
        }
        login = true;
        break;
      } else {
        print('try again');
      }
    }
  }
  if (admin == true) {
    print('ADMIN ACCOUNT');
    for (var item in products) {
      item.printproductlistforadmin();
    }
    print(
        'WANT TO "ADD","UPDATE LIST" OR "REMOVE"\nTo Add Write "Add"\nTo Update Write"Update"\nTo Remove Write "Remove"');
    var adminwant = stdin.readLineSync()!.toLowerCase();

    if (adminwant == 'update') {
      var update;
      do {
        print('PRODUCT NAME TO UPDATE');
        update = stdin.readLineSync()!.toLowerCase();
        if (update == '') break;
        Product? newupdates = checkingorderinproducts(update, products);
        if (newupdates != null) {
          print(
              'if you dont want to change "name" leave it blank\nfor price and stock leave it with "0"\n"NEW NAME"');
          String newname = stdin.readLineSync()!.toLowerCase();
          if (newname != '') newupdates.changename(newname);
          print('NEW PRICE');
          int newprice = int.parse(stdin.readLineSync()!);
          if (newprice > 0) newupdates.changeprice(newprice);
          print('NEW STOCK');
          int newstock = int.parse(stdin.readLineSync()!);
          if (newstock > 0) newupdates.changestock(newstock);
        } else {
          print('No product found or please check the spelling');
        }
      } while (update != '');
    }
    if (adminwant == 'add') {
      print('ADD PRODUCT');
      var newproductname;
      while (newproductname != '') {
        print('Product Name');
        newproductname = stdin.readLineSync()!.toLowerCase();
        if (newproductname == '') break;
        print('Product Price');
        var newproductprice = int.parse(stdin.readLineSync()!);
        print('Product Stock');
        var newproductstock = int.parse(stdin.readLineSync()!);
        products
            .add(new Product(newproductname, newproductprice, newproductstock));
      }
    }
    if (adminwant == 'remove') {
      var removingproducts;
      while (removingproducts != '') {
        print(
            'Product Name To Remove\nleave product name to remove "blank" when your done');
        removingproducts = stdin.readLineSync()!.toLowerCase();
        if (removingproducts == '') break;
        Product? removeproduct =
            checkingorderinproducts(removingproducts, products);
        products.remove(removeproduct);
        if (removeproduct == null) print('no product found or check spelling');
      }
    }
    for (var item in products) {
      item.printproductlistforadmin();
    }
    return;
  }
  List<Order> orders = [];
  Order? order = new Order('', 0);
  num totalbill = 0;
  if (login == true) {
    print(
        '        "YOUR ORDER"\nleave product name blank when ur done with your order');
    do {
      order = addingproduct();
      if (order != null) {
        Product? productordered =
            checkingorderinproducts(order.orderproduct, products);
        if (productordered == null) {
          print('Kindly check the spelling OR Product is not Available');
        } else if (productordered.productstock! <=
            order.orderquantity!.toInt()) {
          print(
              '${productordered.productname} Is Only ${productordered.productstock} Pack in Stock');
        }
        orders.add(order);
      }
    } while (order != null);
    print(
        'Want To Confirm Your Order Write "confirm"\nWant To Edit Quantity Write "edit"\nWant To Remove Product Write "remove"');
    var finalwant = '';
    var costumerwant = stdin.readLineSync()!.toLowerCase();
    if (costumerwant == "confirm") {
      finalwant = 'confirm';
    } else {
      if (costumerwant == 'edit') {
        var editproductname;
        do {
          print('Product Name To Edit');
          editproductname = stdin.readLineSync()!.toLowerCase();
          if (editproductname != '') {
            Order? changing = changingquantity(editproductname, orders);
            if (changing != null) {
              print('Edit quantity\nQuantity:');
              int? neweditquantity = int.parse(stdin.readLineSync()!);
              Product? recheck =
                  checkingorderinproducts(editproductname, products);
              if (neweditquantity <= recheck!.productstock!) {
                changing.changingoldquantity(neweditquantity);
              } else {
                print('Only ${recheck.productstock} Packs Are In Stock');
              }
            } else {
              print('Please Check Spelling');
            }
          }
        } while (editproductname != '');
      } else if (costumerwant == 'remove') {
        var removeproductname;
        do {
          print('Name Of Product To Remove');
          removeproductname = stdin.readLineSync()!;
          if (removeproductname == '') break;
          Order? changing = changingquantity(removeproductname, orders);
          if (changing != null) {
            orders.remove(changing);
          } else {
            print('your cart is empty or check spelling');
          }
        } while (removeproductname != '');
      }
      print('WANT TO CONFIRM YOUR ORDER');
      finalwant = stdin.readLineSync()!;
    }
    if (finalwant == 'confirm') {
      for (var billing in orders) {
        Product? finalbilling =
            checkingorderinproducts(billing.orderproduct, products);
        billing.productbill =
            (finalbilling!.productprice! * billing.orderquantity!);
        billing.productpriceperpack = finalbilling.productprice;
        finalbilling.minussaledquantity(billing.orderquantity);
        totalbill += billing.productbill!;
        billing.printorder();
      }
    }
    print('TOTAL BILL:$totalbill');
  }
}

Order? addingproduct() {
  print('PRODUCT TO ORDER');
  var productname = stdin.readLineSync()!.toLowerCase();
  if (productname == '') {
    return null;
  }
  print('PRODUCT QUANTITY');
  int productquantity = int.parse(stdin.readLineSync()!);
  return new Order(productname, productquantity);
}

//ordered item ko product ki list may dekh rhay hain
Product? checkingorderinproducts(String? orderedproduct, List<Product> items) {
  for (var i = 0; i < items.length; i++) {
    if (orderedproduct == items[i].productname) {
      return items[i];
    }
  }
  return null;
}

Order? changingquantity(var productnametoeditquantity, List<Order> ordered) {
  for (var i = 0; i < ordered.length; i++) {
    if (productnametoeditquantity == ordered[i].orderproduct) {
      return ordered[i];
    }
  }
  return null;
}