import 'dart:ffi';

import 'package:flutter/material.dart';

class Building{
  late String name;
  late String address;

Building(String name, String address){

this.name= name;
this.address=address;

  }

}

Building building = Building('C12' ,'Grenzstraße 3, 24149 Kiel' );

