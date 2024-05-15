class Usermodel {
  const Usermodel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.phonenumber,
    required this.token,
    required this.amount,
     this.accountnumber,
     this.bankname,
    required this.image 
  });
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String phonenumber;
  final String token;
  final String amount;
  final String? bankname;
  final String? accountnumber;
  final String? image;
}
