import 'package:conecta2peju/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateCard extends StatefulWidget {
  const CreateCard(
      {Key? key,
      @required this.appBarColor,
      @required this.secondaryColor,
      @required this.idCategory})
      : super(key: key);

  final Color? appBarColor;
  final Color? secondaryColor;
  final int? idCategory;
  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Card',
          style: Theme.of(context).textTheme.headline3,
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Theme.of(context).colorScheme.onSurface,
            size: 30,
          ),
          onPressed: () => popPage(context),
        ),
        elevation: 0.0,
        backgroundColor: widget.appBarColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                  fillColor: widget.appBarColor,
                  filled: true,
                  labelText: 'Write somenthing...',
                  labelStyle: Theme.of(context).textTheme.bodyText2),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              maxLength: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200),
            child: SizedBox(
              width: 180,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(widget.secondaryColor!),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: widget.secondaryColor!))),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {},
                child: const Text("POST",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
