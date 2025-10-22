import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';

part 'pokemon_detail_model.g.dart';

@JsonSerializable()
class PokemonDetailModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<PokemonTypeModel> types;
  final List<PokemonStatModel> stats;
  final PokemonSpritesModel sprites;

  PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    required this.sprites,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailModelToJson(this);

  Pokemon toEntity() {
    return Pokemon(
      id: id,
      name: name,
      imageUrl: sprites.other?.officialArtwork?.frontDefault ??
          sprites.frontDefault ??
          '',
      types: types.map((e) => e.type.name).toList(),
      height: height,
      weight: weight,
      stats: {
        for (var stat in stats) stat.stat.name: stat.baseStat,
      },
    );
  }
}

@JsonSerializable()
class PokemonTypeModel {
  final int slot;
  final TypeInfoModel type;

  PokemonTypeModel({
    required this.slot,
    required this.type,
  });

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeModelToJson(this);
}

@JsonSerializable()
class TypeInfoModel {
  final String name;
  final String url;

  TypeInfoModel({
    required this.name,
    required this.url,
  });

  factory TypeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TypeInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeInfoModelToJson(this);
}

@JsonSerializable()
class PokemonStatModel {
  @JsonKey(name: 'base_stat')
  final int baseStat;
  final int effort;
  final StatInfoModel stat;

  PokemonStatModel({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatModelToJson(this);
}

@JsonSerializable()
class StatInfoModel {
  final String name;
  final String url;

  StatInfoModel({
    required this.name,
    required this.url,
  });

  factory StatInfoModel.fromJson(Map<String, dynamic> json) =>
      _$StatInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatInfoModelToJson(this);
}

@JsonSerializable()
class PokemonSpritesModel {
  @JsonKey(name: 'front_default')
  final String? frontDefault;
  final OtherSpritesModel? other;

  PokemonSpritesModel({
    this.frontDefault,
    this.other,
  });

  factory PokemonSpritesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpritesModelToJson(this);
}

@JsonSerializable()
class OtherSpritesModel {
  @JsonKey(name: 'official-artwork')
  final OfficialArtworkModel? officialArtwork;

  OtherSpritesModel({
    this.officialArtwork,
  });

  factory OtherSpritesModel.fromJson(Map<String, dynamic> json) =>
      _$OtherSpritesModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtherSpritesModelToJson(this);
}

@JsonSerializable()
class OfficialArtworkModel {
  @JsonKey(name: 'front_default')
  final String? frontDefault;

  OfficialArtworkModel({
    this.frontDefault,
  });

  factory OfficialArtworkModel.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkModelToJson(this);
}
