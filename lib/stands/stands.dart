import 'package:flutter/material.dart';

class Stand {
  String itemName;
  double itemPrice;
  String itemImage;
  String itemLocation;
  double itemRating;

  Stand.items({this.itemName, this.itemPrice, this.itemImage,this.itemLocation, this.itemRating});
}

List<Stand> standItems = [
  Stand.items(
      itemName: "1",
      itemPrice: 2500.00,
      itemImage: "http://www.libchen.com/cdn/20/2011/322/large-printable-numbers-1-10_172146.jpg",
      itemLocation: "floor center",
      itemRating: 0.0),
  Stand.items(
      itemName: "2",
      itemPrice: 2499.00,
      itemImage: "http://www.libchen.com/cdn/20/2011/322/large-printable-numbers-black-2_172126.jpg",
      itemRating: 0.0,
      itemLocation: "By the entryway"),
  Stand.items(
      itemName: "3",
      itemPrice: 2500.00,
      itemImage: "http://www.printable-alphabets.com/wp-content/uploads/2012/10/number-solid-3.jpg",
      itemLocation: "By the entryway",
      itemRating: 0.0),
  Stand.items(
      itemName: "4",
      itemPrice: 2499.00,
      itemImage: "http://www.printable-alphabets.com/wp-content/uploads/2012/10/number-solid-4-204x204.jpg",
      itemLocation: "Floor center",
      itemRating: 0.0),
  Stand.items(
      itemName: "5",
      itemPrice: 2500.00,
      itemImage: "http://www.printable-alphabets.com/wp-content/uploads/2012/10/number-solid-5-204x204.jpg",
      itemLocation: "Floor back",
      itemRating: 0.0),
  Stand.items(
      itemName: "6",
      itemPrice: 2499.00,
      itemImage: "http://www.printable-alphabets.com/wp-content/uploads/2012/10/number-solid-6-204x204.jpg",
      itemLocation: "By the entryway",
      itemRating: 0.0),

];