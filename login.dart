var userinfo = [
  {'email': 'x@gmail.com', 'password': '1234', 'roll': 'admin'},
  {'email': 'y@gmail.com', 'password': '1235', 'roll': 'customer'},
  {'email': 'z@gmail.com', 'password': '1236', 'roll': 'customer'}
];

class signin {
  String? email;
  String? password;
  bool login = false;
  var roll = false;
  signin(email, password) {
    this.email = email;
    this.password = password;
    for (var i = 0; i < userinfo.length; i++) {
      if (email == userinfo[i]['email'] &&
          password == userinfo[i]['password']) {
        if (userinfo[i]['roll'] == 'admin') {
          roll = true;
        }
        login = true;
        print('Login');
      }
    }
  }
}

class signup {
  String? email;
  String? password;
  bool signupcount = false;
  signup(email, password) {
    this.email = email;
    this.password = password;
    for (var i = 0; i < userinfo.length; i++) {
      if (email == userinfo[i]['email']) {
        print('EMAIL ALREADY EXISTS\nplease try with another email');
        return;
      }
    }
    userinfo.add({'email': email, 'password': password, 'roll': 'customer'});
    print('ACCOUNT CREATED SUCCESSFULLY');
    signupcount = true;
  }
}
