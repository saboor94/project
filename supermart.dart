import 'dart:io';

void main() {
  print('   WELCOME\nTO SUPER MART');
  List items = [
    {'item': 'chicken', 'price': 80, 'available': 12},
    {'item': 'tomato', 'price': 100, 'available': 75},
    {'item': 'meat', 'price': 1150, 'available': 60},
    {'item': 'egg', 'price': 400, 'available': 70},
    {'item': 'milk', 'price': 200, 'available': 40},
    {'item': 'bread', 'price': 120, 'available': 100},
    {'item': 'ketchup', 'price': 240, 'available': 30},
    {'item': 'butter', 'price': 275, 'available': 30},
    {'item': 'lays yellow', 'price': 30, 'available': 50},
    {'item': 'coke 500ml', 'price': 100, 'available': 20},
    {'item': 'coke 1.5l', 'price': 180, 'available': 10},
    {'item': 'onion', 'price': 200, 'available': 30},
    {'item': 'mint', 'price': 20, 'available': 20},
  ];
  print('SERACH BY ALPHABET');
  var alphabet = stdin.readLineSync()!;
  if (alphabet == '') {
    for (var i = 0; i < items.length; i++) {
      var it = items[i]['item'];
      var p = items[i]['price'];
      print('$it price per pack $p');
    }
  } else {
    for (var i = 0; i < items.length; i++) {
      var it = items[i]['item'];
      var p = items[i]['price'];
      if (it[0] == alphabet) print('$it price per pack $p');
    }
  }

  print('YOUR ORDER');

  var order = [
    {stdin.readLineSync()!: int.parse(stdin.readLineSync()!)},
  ];
  // print(order[0].containsKey(items[0]['item']));
  num bill = 0;
  for (var i = 0; i < order.length; i++) {
    var o = order[i];
    print('ORDER NO:$i');
    for (var j = 0; j < items.length; j++) {
      var it = items[j]['item'];
      var av = items[j]['available'];
      var p = items[j]['price'];
      if (o.containsKey(it)) {
        if (o[it]! <= av) {
          items[j]['available'] = av - o[it];
          num bill1 = o[it]! * p;
          bill += bill1;
          print('$it:${o[it]}\n${o[it]}*$p\nTotal :$bill1');
        } else if (o[it]! > av) {
          print('$it is out of stock');
        }
      }
    }

    print('Total bill:$bill');
    bill = 0;
  }
}
