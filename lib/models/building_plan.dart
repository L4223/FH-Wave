import 'dart:ffi';

import 'package:flutter/material.dart';

class Building{
  late String name;
  late String address;

Building({required this.name, required this.address});

}
  List<Building> buildingList = [
    Building(name: 'C12', address:'Grenzstraße 3, 24149 Kiel'),
    Building(name: 'C13', address:'Fachhochschule Kiel Informatik und Elektrotechnik'),
    Building(name: 'C33', address:'Heikendorfer Weg 37, 24149 Kiel'),
    Building(name: 'C34', address:'Heikendorfer Weg 35, 24149 Kiel'),
    Building(name: 'C14', address:'Grenzstrasse 17, 24149 Kiel'),
    Building(name: 'C15', address:'Grenzstraße 14, 24149 Kiel'),
    Building(name: 'C11', address:'Hochspannungs- und Blitzlabor der FH Kiel, 24149 Kiel'),
    Building(name: 'C32', address:'Moorblöcken 1a , 24149 Kiel'),
    Building(name: 'C06', address:'Schwentinestrasse 7, 24149 Kiel'),
    Building(name: 'C20', address:'Schwentinestrasse 24, 24149 Kiel'),
    Building(name: 'C22', address:'Luisenstrasse 25, 24149 Kiel'),
    Building(name: 'C21', address:'Eichenbergskamp 8, 24149 Kiel'),
    Building(name: 'C22', address:'Luisenstrasse 25, 24149 Kiel'),
    Building(name: 'C08', address:'Luisenstrasse , 24149 Kiel'),
    Building(name: 'C02', address:'Sokratesplatz 6, 24149 Kiel'),
    Building(name: 'C01', address:'Sokratesplatz 1, 24149 Kiel'),
    Building(name: 'C19', address:'Sokratesplatz 4, 24149 Kiel'),
    Building(name: 'C03', address:'Sokratesplatz 1, 24149 Kiel'),
    Building(name: 'C05', address:'Schwentinestrasse 13, 24149 Kiel'),
    Building(name: 'C31', address:'Luisenstrasse 25, 24149 Kiel'), //ergänzen
    Building(name: 'C04', address:'Luisenstrasse 25, 24149 Kiel'), //ergänzen
    Building(name: 'C18', address:'Zulassungsstelle FH Kiel, 24149 Kiel'),


];




