// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/objectsScreens/objects_details_screen.dart';
import 'package:skiome_centres/objectsScreens/objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';

class ObjectsUiDesignWidget extends StatefulWidget {
  Objects? model;
  BuildContext? context;
  ObjectsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<ObjectsUiDesignWidget> createState() => _ObjectsUiDesignWidgetState();
}

class _ObjectsUiDesignWidgetState extends State<ObjectsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ObjectsDetailsScreen(
                      model: widget.model,
                    )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 190,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.model!.objectName.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 4,
                ),
                // Text(
                //   widget.model!.longDescription.toString(),
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 14,
                //     letterSpacing: 3,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
