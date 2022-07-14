import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  final String name;
  final String pay;
  final String description;
  final String img;
  final String id;
  final String subtitle;
  final String item;
  final String type;
  final String img1;
  final String img2;
  final String img3;

  Product({
    this.name,
    this.pay,
    this.description,
    this.img,
    this.id,
    this.subtitle,
    this.item,

    this.type,
    this.img1,
    this.img2,
    this.img3
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      name: doc['name'],
      id: doc['id'],
      description: doc['description'],
      img: doc['img'],
      pay: doc['pay'],
      subtitle: doc['subtitle'],
      item: doc['item'],
      type: doc['type'],

      img1: doc['img1'],

      img2: doc['img2'],

      img3: doc['img3']


    );
  }
}


