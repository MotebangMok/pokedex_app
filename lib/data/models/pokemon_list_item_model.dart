
import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex_app/domain/entities/pokemon_list_item.dart';

part 'pokemon_list_item_model.g.dart';

@JsonSerializable()
class PokemonListItemModel {
  final String name;
  final String url;

  PokemonListItemModel({
    required this.name,
    required this.url,
  });

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListItemModelToJson(this);

  PokemonListItem toEntity() {
    return PokemonListItem(
      name: name,
      url: url,
    );
  }
}
