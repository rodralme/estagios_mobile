import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Area {
  static const Map<String, Map<String, dynamic>> areaConfig = {
    'ADM': {
      'icon': FontAwesomeIcons.clipboard,
      'color': Colors.red,
    },
    'AU': {
      'icon': FontAwesomeIcons.landmark,
      'color': Colors.blue,
    },
    'DIR': {
      'icon': FontAwesomeIcons.balanceScale,
      'color': Colors.red,
    },
    'EF': {
      'icon': FontAwesomeIcons.dumbbell,
      'color': Colors.green,
    },
    'ECI': {
      'icon': FontAwesomeIcons.building,
      'color': Colors.blue,
    },
    'PED': {
      'icon': FontAwesomeIcons.child,
      'color': Colors.purpleAccent,
    },
    'TI': {
      'icon': FontAwesomeIcons.laptop,
      'color': Colors.blue,
    },
  };
}