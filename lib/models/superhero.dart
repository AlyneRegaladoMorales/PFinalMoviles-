class SuperHero{
  final String id;
  final String name;
  final String? gender;
  final String? intelligence;
  final String? image;
  
  SuperHero({required this.id, required this.name, required this.gender, required this.intelligence, required this.image});
  
  factory SuperHero.fromMap(Map<String, dynamic> map) {
        print("Mapping SuperHero from map: $map");

    return SuperHero(
      id: map['id'] as String,
      name: map['name'] as String,
      gender: map['appearance']?['gender'] as String?,
      intelligence: map['powerstats']?['intelligence'] as String?,
      image: map['image']?['url'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender ?? 'Unknown',
      'intelligence': intelligence ?? 'Unknown',
      'image': image?? 'Unknown',
    };
  }
}