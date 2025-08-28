import 'package:carousel_slider/carousel_slider.dart';
import 'package:emane_khalis_app/generated/assets.dart';
import 'package:flutter/material.dart';

class Tafseer extends StatefulWidget {
  const Tafseer({super.key});

  @override
  State<Tafseer> createState() => _TafseerState();
}

class _TafseerState extends State<Tafseer> {
  bool showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> images = [
    'assets/images/allahooakbar.png',
    'assets/images/applogo.png',
    'assets/images/imgkhanakabah.png',
    'assets/images/splashlogo.png',
    'assets/images/splashlogo.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E8B57), Color(0xFF006400)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'ایمان خالص',
                      style: TextStyle(
                        fontFamily: "SourceSans3-BoldItalic",
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              showSearch = !showSearch;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.star, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: showSearch ? 55 : 0,
            curve: Curves.easeInOut,
            child: showSearch
                ? Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon:
                  const Icon(Icons.search, color: Colors.green),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
                : null,
          ),
          SizedBox(height: 10,),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: images.map((imgUrl) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade100, Colors.green.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imgUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const Expanded(
            child: Center(
              child: Text(
                "Tafseer Content",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }
}
