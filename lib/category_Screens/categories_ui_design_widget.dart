// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/objectsScreens/objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';

class CategoriesUiDesignWidget extends StatefulWidget {
  Categories? model;
  BuildContext? context;
  CategoriesUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<CategoriesUiDesignWidget> createState() =>
      _CategoriesUiDesignWidgetState();
}

class _CategoriesUiDesignWidgetState extends State<CategoriesUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ObjectsScreen(
                      model: widget.model,
                    )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.categoryName.toString(),
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                    IconButton(
                        onPressed: (() {}),
                        icon: Icon(
                          Icons.delete_sweep,
                          color: Colors.pinkAccent,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
