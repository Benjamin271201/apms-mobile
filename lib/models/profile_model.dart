class Profile {
  String id, phoneNumber, fullName, accountBalance;

  Profile.toJson(Map<String, dynamic> json)
      : id = json["id"],
        phoneNumber = json["phoneNumber"],
        fullName = json["fullName"],
        accountBalance = json["accountBalance"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "accountBalance": accountBalance
      };
}
