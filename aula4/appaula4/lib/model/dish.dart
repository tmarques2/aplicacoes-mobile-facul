// Criando a classe dish

class Dish {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imagePath;
  final String category;

  // Cria o construtor

  Dish(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imagePath,
      this.category = ''});

  // Metodo para tratar chave e valor

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'category': category
    };
  }

  // Função para fazer a conversão de chave e valor

  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price'],
        imagePath: map['imagePath'],
        category: map['category'] ?? '');
  }

  // Função para converter para String
  @override
  String toString() {
    return 'Dish(id:$id,name:$name,description:$description,price:$price, imagePath:$imagePath, category:$category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dish && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
