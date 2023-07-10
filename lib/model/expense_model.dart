import 'package:flutter/services.dart';

class ExpenseModel
{
  int? id,amount;
  String? category,status,description,paymentType;

  Uint8List? img;

  ExpenseModel(
      {this.id,
      this.amount,
      this.category,
      this.status,
      this.description,
      this.paymentType,
      this.img});
}