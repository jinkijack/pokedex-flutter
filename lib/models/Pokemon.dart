import 'package:flutter/foundation.dart';

class Pokemon {
  final int id;
  final String name;
  final int height;
  final List<PokeStats> stats;
  final List<PokeType> types;
  final PokeSprite sprites;
  final int weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.stats,
    required this.types,
    required this.sprites,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      stats: (json['stats'] as List).map((e) => PokeStats.fromJson(e)).toList(),
      types: (json['types'] as List).map((e) => PokeType.fromJson(e)).toList(),
      sprites: PokeSprite.fromJson(json['sprites']),
      weight: json['weight'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'stats': stats.map((e) => e.toJson()).toList(),
      'types': types.map((e) => e.toJson()).toList(),
      'sprites': sprites.toJson(),
      'weight': weight,
    };
  }
}

class PokeStats {
  final int baseStat;
  final PokeStatDetails stat;

  PokeStats({required this.baseStat, required this.stat});

  factory PokeStats.fromJson(Map<String, dynamic> json) {
    return PokeStats(
      baseStat: json['base_stat'],
      stat: PokeStatDetails.fromJson(json['stat']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'stat': stat.toJson(),
    };
  }
}

class PokeType {
  final int slot;
  final PokeTypeDetails type;

  PokeType({required this.slot, required this.type});

  factory PokeType.fromJson(Map<String, dynamic> json) {
    return PokeType(
      slot: json['slot'],
      type: PokeTypeDetails.fromJson(json['type']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type.toJson(),
    };
  }
}

class PokeSprite {
  final String frontDefault;

  PokeSprite({required this.frontDefault});

  factory PokeSprite.fromJson(Map<String, dynamic> json) {
    return PokeSprite(
      frontDefault: json['front_default'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
    };
  }
}

class PokeStatDetails {
  final String name;

  PokeStatDetails({required this.name});

  factory PokeStatDetails.fromJson(Map<String, dynamic> json) {
    return PokeStatDetails(
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class PokeTypeDetails {
  final String name;

  PokeTypeDetails({required this.name});

  factory PokeTypeDetails.fromJson(Map<String, dynamic> json) {
    return PokeTypeDetails(
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
