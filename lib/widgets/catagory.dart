import 'package:flutter/material.dart';
import 'package:btl_flutter_nhom6/screens/recipe_data.dart';
import 'square_card.dart';

class Catagory extends StatefulWidget {
  const Catagory({super.key});

  @override
  State<Catagory> createState() => _CatagoryState();
}

class _CatagoryState extends State<Catagory> {
  final List<String> _categories = ['All', 'Entrées', 'Desserts', 'Drinks'];
  String _selectedCategory = 'All';
  final Map<String, IconData> categoryIcons = {
    'All': Icons.menu_book,
    'Entrées': Icons.dinner_dining,
    'Desserts': Icons.cake,
    'Drinks': Icons.emoji_food_beverage,
  };

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> filteredCategory = _selectedCategory == 'All'
        ? recipeList
        : recipeList.where((item) {
      return item['category'].contains(_selectedCategory);
    }).toList();

    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () {
              setState(() {
              _selectedCategory = category;
              });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pinkAccent : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                child: Row(
                  children: [
                    Icon(
                      categoryIcons[category],
                      color: isSelected ? Colors.white : Colors.black,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );},
          ),
        ),
        const SizedBox(height: 10),

        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: filteredCategory.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1, // tạo card vuông
          ),
          itemBuilder: (context, index) {
            final item = filteredCategory[index];
            return SquareRecipeCard(item: item);
          },
        ),
      ],
    );
  }
}
