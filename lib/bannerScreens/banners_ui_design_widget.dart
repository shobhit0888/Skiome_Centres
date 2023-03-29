// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/eventsScreens/events_details._screen.dart';
import 'package:skiome_centres/models/banners.dart';
import 'package:skiome_centres/models/events.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:skiome_centres/objectsScreens/objects_details_screen.dart';
import 'package:skiome_centres/objectsScreens/objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:skiome_centres/schoolsScreens/school_details.dart';

class BannersUiDesignWidget extends StatefulWidget {
  Banners? model;
  BuildContext? context;
  BannersUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<BannersUiDesignWidget> createState() => _SchoolsUiDesignWidgetState();
}

class _SchoolsUiDesignWidgetState extends State<BannersUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Image.network(
                widget.model!.photoUrl.toString(),
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
