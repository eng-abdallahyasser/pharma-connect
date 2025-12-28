class Item {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final List<String>? units;

  Item({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.units,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    String displayName = '';

    // The API might return 'localizedName' or 'name' as a Map {en: "...", ar: "..."}
    final nameSource = json['localizedName'] ?? json['name'];

    if (nameSource is Map) {
      // Prioritize English, fall back to Arabic, or empty
      displayName = nameSource['en'] ?? nameSource['ar'] ?? '';
    } else if (nameSource is String) {
      displayName = nameSource;
    }

    List<String>? parsedUnits;
    if (json['units'] != null && json['units'] is List) {
      parsedUnits = List<String>.from(json['units'].map((e) => e.toString()));
    }

    return Item(
      id: json['id'] as String? ?? '',
      name: displayName,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      units: parsedUnits,
    );
  }
}

class SelectedItem {
  final Item item;
  int quantity;

  SelectedItem({required this.item, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {'id': item.id, 'quantity': quantity};
  }
}
