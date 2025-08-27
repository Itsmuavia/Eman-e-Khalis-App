import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Tafseer extends StatefulWidget {
  const Tafseer({super.key});

  @override
  State<Tafseer> createState() => _TafseerState();
}

class _TafseerState extends State<Tafseer> with SingleTickerProviderStateMixin {
  bool showSearch = false;
  final TextEditingController _searchController = TextEditingController();


  final List<String> images = [
    'assets/images/allahooakbar.png',
    'assets/images/mosque-black.png',
    'assets/images/applogo.png',
    'assets/images/splashlogo.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ایمان خالص',
          style: TextStyle(
            fontFamily: "SourceSans3-BoldItalic",
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white70,
        elevation: 4,
        shadowColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blueGrey),
            tooltip: "Search",
            onPressed: () {
              setState(() {
                showSearch = !showSearch; // toggle with animation
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.star, color: Colors.green),
            tooltip: "Reviews",
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: "Logout",
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: showSearch ? 60 : 0,
            curve: Curves.easeInOut,
            child: showSearch
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.01),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )
                : null,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.60,
            ),
            items: images.map((imgUrl) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imgUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
          ),

          const Expanded(
            child: Center(child: Text("Tafseer Content")),
          ),

        ],
      ),
    );
  }
}
