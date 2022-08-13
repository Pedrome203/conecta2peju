import 'package:conecta2peju/domain/models/card_category.dart';
import 'package:flutter/material.dart';

class CardCategorySteggered extends StatelessWidget {
  const CardCategorySteggered(
      {Key? key,
      @required this.itemBuilder,
      @required this.itemCount,
      @required this.spacing,
      @required this.aspectRatio})
      : super(key: key);

  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final double? spacing;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio!;
      final height = constraints.maxHeight + itemHeight;
      return OverflowBox(
        maxWidth: width,
        minWidth: width,
        maxHeight: height,
        minHeight: height,
        child: GridView.builder(
          padding: EdgeInsets.only(top: itemHeight * 0.75, bottom: itemHeight),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio!,
            crossAxisSpacing: spacing!,
            mainAxisSpacing: spacing!,
          ),
          itemBuilder: (context, index) {
            return itemBuilder!(context, index);
          },
          itemCount: itemCount!,
        ),
      );
    });
  }
}

class ItemCategory extends StatelessWidget {
  const ItemCategory({Key? key, @required this.item}) : super(key: key);
  final CategoryCard? item;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: item!.color,
      child: Column(
        children: <Widget>[
          Expanded(
            child: item!.icon!,
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              Text(item!.name!),
            ],
          ))
        ],
      ),
    );
  }
}
