import 'package:conecta2peju/ui/common/card_category_steggered_widget.dart';
import 'package:conecta2peju/ui/home/dictionary/category_card_cubit.dart';

import 'package:conecta2peju/ui/home/dictionary/category_selected_view.dart';
import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryCardsView extends StatelessWidget {
  const DictionaryCardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCardCubit()..init(),
      child: BlocBuilder<CategoryCardCubit, List<CategoryCardState>>(
          builder: (context, snapshot) {
        return CardCategorySteggered(
          itemCount: snapshot.length,
          spacing: 20,
          aspectRatio: 0.8,
          itemBuilder: ((context, index) {
            final item = snapshot[index].categoryCard;
            return Card(
              child: GestureDetector(
                onTap: () async {
                  await pushToPage(
                      context,
                      CategorySelected(
                        appBarText: item!.name,
                        appBarColor: item.color,
                        idCategory: item.id,
                        secondaryColor: item.secondary,
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(color: item!.color),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: item.icon!,
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Text(
                                item.name!,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
        );

        /*ListView.builder(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            itemCount: snapshot.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                width: 100,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Text(snapshot[index].categoryCard!.name!),
              );
            });*/
      }),
    );
  }
}
