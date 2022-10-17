import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

messageError(BuildContext context, String msg) {
  Color colorHeader = Color.fromARGB(255, 195, 26, 11);
  Color colorBody = Theme.of(context).colorScheme.background;
  AlertDialog alert = AlertDialog(
    scrollable: true,
    contentPadding: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: const EdgeInsets.all(0.0),
    title: Container(
        padding: const EdgeInsets.all(20.0),
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorHeader,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Container(
            height: 50.0,
            width: 50.0,
            child: Icon(
              Icons.error,
              size: 50.0,
              color: colorHeader,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white))),
    content: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorBody, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text('Error', style: Theme.of(context).textTheme.headline5),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              msg,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          ],
        )),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

messageOK(BuildContext context, String msg) {
  final widthScreen = MediaQuery.of(context).size.width;

  Color colorHeader = Color.fromARGB(255, 115, 187, 21);
  Color colorBody = Theme.of(context).colorScheme.background;
  AlertDialog alert = AlertDialog(
    scrollable: true,
    contentPadding: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: const EdgeInsets.all(0.0),
    title: Container(
        padding: const EdgeInsets.all(20.0),
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorHeader,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Container(
            height: 50.0,
            width: 50.0,
            child: Icon(
              Icons.done,
              size: 50.0,
              color: colorHeader,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white))),
    content: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorBody, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text(
              'Ok',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              msg,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          ],
        )),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

messageTranslate(BuildContext context, String msg) {
  final widthScreen = MediaQuery.of(context).size.width;

  Color colorHeader = Theme.of(context).colorScheme.primary;
  Color colorBody = Theme.of(context).colorScheme.background;
  AlertDialog alert = AlertDialog(
    scrollable: true,
    contentPadding: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: const EdgeInsets.all(0.0),
    title: Container(
        padding: const EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorHeader,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Container(
            height: 40.0,
            width: 40.0,
            child: Icon(
              CupertinoIcons.book,
              size: 40.0,
              color: colorHeader,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white))),
    content: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorBody, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text(
              'Traducción:',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              msg,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          ],
        )),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

messageInfo(BuildContext context, String msg) {
  final widthScreen = MediaQuery.of(context).size.width;

  Color colorHeader = const Color(0xFFC5D3FF);
  Color colorBody = Theme.of(context).colorScheme.background;
  AlertDialog alert = AlertDialog(
    scrollable: true,
    contentPadding: const EdgeInsets.all(0.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: const EdgeInsets.all(0.0),
    title: Container(
        padding: const EdgeInsets.all(20.0),
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorHeader,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Container(
            height: 50.0,
            width: 50.0,
            child: Icon(
              Icons.info,
              size: 50.0,
              color: colorHeader,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white))),
    content: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorBody, borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text(
              'Info',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              msg,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          ],
        )),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
