// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/objectsScreens/upload_objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/text_delegate_header_widget.dart';

class ObjectsScreen extends StatefulWidget {
  Categories? model;
  ObjectsScreen({
    this.model,
  });
  @override
  State<ObjectsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ObjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: "Skiome Centres".text.bold.xl3.make(),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => UploadObjectsScreens(
                              model: widget.model,
                            ))));
              },
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextDelegateHeaderWidget(
            title: widget.model!.categoryName.toString() + " Objects",
          )),
        ],
      ),
    );
  }
}
