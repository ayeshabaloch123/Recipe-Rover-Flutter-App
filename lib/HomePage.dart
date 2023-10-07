import 'package:flutter/material.dart';
import 'package:recipe_rover/RecipeCard.dart';
import 'HomeScreen.dart'; // Import your HomeScreen

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              height: 80,
              width: 100,
            ),
            const SizedBox(width: 10),
            const Text("Recipe Rover"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to our RecipeRover App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images.jpg',
              height: 470,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),

            // Explore Recipes Button
            Container(
              width: double.infinity, // Adjust the width as needed
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to RecipeScreen when Explore Recipes is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Explore Our Recipes'),
              ),
            ),
            SizedBox(height: 20.0),

            // Add Recipe Button
            Container(
              width: double.infinity, // Adjust the width as needed
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to HomeScreen when Add Your Recipe is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Add Your Recipe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
