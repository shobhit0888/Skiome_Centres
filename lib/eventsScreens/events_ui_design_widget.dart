// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/eventsScreens/events_details._screen.dart';
import 'package:skiome_centres/models/events.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:skiome_centres/objectsScreens/objects_details_screen.dart';
import 'package:skiome_centres/objectsScreens/objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:skiome_centres/schoolsScreens/school_details.dart';

class EventsUiDesignWidget extends StatefulWidget {
  Events? model;
  BuildContext? context;
  EventsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<EventsUiDesignWidget> createState() => _SchoolsUiDesignWidgetState();
}

class _SchoolsUiDesignWidgetState extends State<EventsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => EventsDetailsScreen(
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
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.model!.eventName.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
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
                Text(
                  widget.model!.time.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.model!.venue.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
