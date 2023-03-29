// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_centres/eventsScreens/events_screen.dart';
import 'package:skiome_centres/models/objects.dart';
import 'package:skiome_centres/models/schools.dart';
import 'package:skiome_centres/objectsScreens/objects_details_screen.dart';
import 'package:skiome_centres/objectsScreens/objects_screen.dart';
import 'package:skiome_centres/models/categories.dart';
import 'package:skiome_centres/schoolsScreens/school_details.dart';
import 'package:skiome_centres/schoolsScreens/school_screen.dart';

class EventsCardWidget extends StatefulWidget {
  @override
  State<EventsCardWidget> createState() => _EventsCardWidgetState();
}

class _EventsCardWidgetState extends State<EventsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => EventsScreen()));
      },
      child: Card(
        elevation: 15,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Events",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Image.asset(
                  "images/splash.png",
                  height: 130,
                  fit: BoxFit.cover,
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
