import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List demoSelectFeeds = [
  SelectFeedsModel(
    img: Icons.whatshot_sharp,
    name: "Popular",
  ),
  SelectFeedsModel(
    img: Icons.follow_the_signs_outlined,
    name: "Travel",
  ),
  SelectFeedsModel(
    img: Icons.brush,
    name: "Art",
  ),
  SelectFeedsModel(
    img: Icons.flatware,
    name: "Food",
  ),
  SelectFeedsModel(
    img: Icons.more_vert,
    name: "More",
  ),
  /*SelectFeedsModel(
    img: Icons.more_vert,
    name: "More",
  ),
  SelectFeedsModel(
    img: Icons.more_vert,
    name: "More",
  ),*/
];

class SelectFeedsModel {
  IconData img;
  String name;

  SelectFeedsModel({required this.img, required this.name});
}
