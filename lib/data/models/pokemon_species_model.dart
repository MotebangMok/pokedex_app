import 'package:json_annotation/json_annotation.dart';

part 'pokemon_species_model.g.dart';

@JsonSerializable()
class PokemonSpeciesModel {
  @JsonKey(name: 'flavor_text_entries')
  final List<FlavorTextModel> flavorTextEntries;

  PokemonSpeciesModel({required this.flavorTextEntries});

  factory PokemonSpeciesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpeciesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpeciesModelToJson(this);

  String getEnglishDescription() {
    try {
      final englishEntry = flavorTextEntries.firstWhere(
        (entry) => entry.language.name == 'en',
      );
      return englishEntry.flavorText
          .replaceAll('\n', ' ')
          .replaceAll('\f', ' ');
    } catch (e) {
      return 'No description available.';
    }
  }
}

@JsonSerializable()
class FlavorTextModel {
  @JsonKey(name: 'flavor_text')
  final String flavorText;
  final LanguageModel language;

  FlavorTextModel({
    required this.flavorText,
    required this.language,
  });

  factory FlavorTextModel.fromJson(Map<String, dynamic> json) =>
      _$FlavorTextModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlavorTextModelToJson(this);
}

@JsonSerializable()
class LanguageModel {
  final String name;
  final String url;

  LanguageModel({
    required this.name,
    required this.url,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);
}
