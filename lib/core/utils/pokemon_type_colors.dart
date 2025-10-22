

import 'package:flutter/material.dart';

class PokemonTypeColors {
  static Color getColor(String type){
    switch(type){
      case "normal":
        return Colors.grey;
      case "fire":
        return Colors.orange;
      case "water":
        return Colors.blue;
      case "electric":
        return Colors.yellow;
      case "ice":
        return Colors.cyan;
      case "fighting":
        return Colors.red;
      case "poison":
        return Colors.purple;
      case "ground":
        return Colors.brown;
      case "flying":
        return Colors.blueGrey;
      case "psychic":
        return Colors.pink;
      case "bug":
        return Colors.lightGreen;
      case "rock":
        return Colors.brown.shade400;
      case "ghost":
        return Colors.deepPurple;
      case "dark":
        return Colors.black87;
      case "dragon":
        return Colors.deepPurple.shade800;
      case "steel":
        return Colors.blueGrey;
      case "fairy":
        return Colors.pink.shade200;
      default:
        return Colors.grey;
    }
    }
    PokemonTypeColors._();
  }
