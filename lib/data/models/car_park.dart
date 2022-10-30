class CarPark {
  String id, name, address, phoneNumber;
  int availableSlotsCount, provinceId, reservationFee, parkingFeePerHour;
  bool status;

  CarPark.fromJson(Map json) : 
    id = json["id"],
    name = json["name"],
    address = json["address"],
    phoneNumber = json["phoneNumber"],
    availableSlotsCount = json["availableSlotsCount"] as int,
    provinceId = json["provinceId"] as int,
    reservationFee = json["reservationFee"] as int,
    parkingFeePerHour = json["parkingFeePerHour"] as int,
    status = json["status"] as bool;

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "availableSlotsCount": availableSlotsCount,
      "provinceId": provinceId,
      "status": status,
      "reservationFee": reservationFee,
      "parkingFeePerHour": parkingFeePerHour
    };
}