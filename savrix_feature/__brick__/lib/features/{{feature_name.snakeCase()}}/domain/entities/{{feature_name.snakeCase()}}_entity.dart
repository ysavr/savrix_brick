class {{feature_name.pascalCase()}}Entity {
  final String name;
  final String image;
  final int weight;

  {{feature_name.pascalCase()}}Entity({
    required this.name,
    required this.image,
    required this.weight,
  });
}