import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);
  // rest of the class

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
      body: RecipeGrid(),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("recipes").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No recipes found.'),
          );
        }

        List<QueryDocumentSnapshot> recipeList = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: recipeList.length,
          itemBuilder: (context, index) {
            return RecipeCard(recipeList[index]);
          },
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final QueryDocumentSnapshot recipe;

  RecipeCard(this.recipe);

  @override
  Widget build(BuildContext context) {
    0.0; // Assuming rating is a double field in your Firestore document

    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navigate to a new screen to display the detailed recipe
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetails(recipe),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image using the Image.asset widget
            Image.asset(
              'recipe.png', // Adjust the image path as needed
              height: 150, // Adjust the height as needed
              width: double.infinity, // Make the image take the full width
              fit: BoxFit.cover, // Adjust the BoxFit property as needed
            ),
            SizedBox(height: 8.0), // Add some spacing below the image

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe["name"],
                    style: TextStyle(
                      fontSize: 20.0, // Increase the font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change the font color
                    ),
                  ),
                  SizedBox(
                      height: 4.0), // Add some spacing below the recipe name

                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 4.0),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0), // Add some spacing below the recipe details
          ],
        ),
      ),
    );
  }
}

class RecipeDetails extends StatelessWidget {
  final QueryDocumentSnapshot recipe;

  RecipeDetails(this.recipe);

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
        child: SingleChildScrollView(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add an image above the recipe name
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the radius as needed
                    child: Image.asset(
                      'recipe2.jpg', // Adjust the image path as needed
                      height: 250,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    recipe["name"],
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      // You can change the font family
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16.0),

                  // ...

                  // ...

                  Divider(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "INGREDIENTS",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      recipe["ingredients"],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontFamily: 'Nunito',
                        letterSpacing: 0.3,
                        height: 1.0,
                      ),
                    ),
                  ),

                  Divider(),

                  SizedBox(height: 16.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "RECIPE",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      recipe["steps"],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: 0.3,
                        fontFamily: 'Nunito',
                        height: 1.0,
                      ),
                    ),
                  ),

// ...

// ...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
