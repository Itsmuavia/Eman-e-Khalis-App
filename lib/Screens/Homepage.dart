import 'package:carousel_slider/carousel_slider.dart';
import 'package:emane_khalis_app/Screens/Videodetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  bool showSearch = false;
  String _searchQuery = '';
  int selectedTab = 0;

  final List<String> images = [
    'assets/images/allahooakbar.png',
    'assets/images/applogo.png',
    'assets/images/imgkhanakabah.png',
    'assets/images/splashlogo.png',
  ];

  final List<Map<String, String>> videos = [
    {
      'title':
          'Surah Aal-e-Imran Ayat 92-101 with Quran Recitation & Translation',
      'writer': 'Fawad Shah',
      'duration': '6:53 minutes',
      'thumbnail': 'assets/images/thumbnail1.png',
      'url': 'assets/videos/Surah Aal-e-Imran.mp4',
    },
    {
      'title': 'Surah Tawbah Rukoo#2 with Quran Recitation and Tafseer in Urdu',
      'writer': 'Furqan ul huda',
      'duration': '16:47 minutes',
      'thumbnail': 'assets/images/thumbnail2.png',
      'url': 'assets/videos/Surah At-Tawbah.mp4',
    },
  ];

  final List<Map<String, String>> articles = [
    {
      'title': 'Importance of Salah',
      'author': 'Imam Ahmed',
      'thumbnail': 'assets/images/thumbnail1.png',
      'description': 'This article explains the importance of Salah in Islam.',
    },
    {
      'title': 'Benefits of Fasting',
      'author': 'Maulana Rashid',
      'thumbnail': 'assets/images/thumbnail2.png',
      'description': 'Learn the physical and spiritual benefits of fasting.',
    },
  ];

  final List<Map<String, String>> ebooks = [
    {
      'title': 'Quran Tafseer (Urdu)',
      'author': 'Scholar A',
      'thumbnail': 'assets/images/thumbnail1.png',
      'description': 'Comprehensive Tafseer of the Holy Quran in Urdu.',
    },
    {
      'title': 'Hadith Collection Vol 1',
      'author': 'Scholar B',
      'thumbnail': 'assets/images/thumbnail2.png',
      'description': 'Authentic collection of Hadith with commentary.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredVideos = videos
        .where(
          (v) =>
              v["title"]!.toLowerCase().contains(_searchQuery) ||
              v["writer"]!.toLowerCase().contains(_searchQuery),
        )
        .toList();

    final filteredArticles = articles
        .where(
          (a) =>
              a["title"]!.toLowerCase().contains(_searchQuery) ||
              a["author"]!.toLowerCase().contains(_searchQuery),
        )
        .toList();

    final filteredEbooks = ebooks
        .where(
          (e) =>
              e["title"]!.toLowerCase().contains(_searchQuery) ||
              e["author"]!.toLowerCase().contains(_searchQuery),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F3),
      appBar: AppBar(
        centerTitle: true,
        iconTheme:IconThemeData(color: Colors.grey),
        backgroundColor: const Color(0xFF006A4E),
        title: Text(
          'اِيمَانٌ خَالِصٌ',
          style: GoogleFonts.scheherazadeNew(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl, // Arabic ke liye zaroori
        ),
        actions: [
          Tooltip(
            message: "search",
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  showSearch = !showSearch;
                });
              },
            ),
          ),
          Tooltip(
            message: "comment",
            child: IconButton(
              icon: const Icon(Icons.message, color: Colors.blueGrey),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: "logout",
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: showSearch ? 55 : 0,
              curve: Curves.easeInOut,
              child: showSearch
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search ...",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),

            CarouselSlider(
              options: CarouselOptions(
                height: 170,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.75,
                autoPlayCurve: Curves.easeInOut,
              ),
              items: images.map((imgUrl) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade200.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(imgUrl, fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent,
                              ],
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

            const SizedBox(height: 15),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabButton("Videos", 0),
                  _buildTabButton("Articles", 1),
                  _buildTabButton("E-Books", 2),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: getTabContent(
                filteredVideos,
                filteredArticles,
                filteredEbooks,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTab == index
              ? Colors.green.shade800
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green.shade800, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedTab == index ? Colors.white : Colors.green.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getTabContent(
    List<Map<String, String>> filteredVideos,
    List<Map<String, String>> filteredArticles,
    List<Map<String, String>> filteredEbooks,
  ) {
    if (selectedTab == 0) {
      if (filteredVideos.isEmpty) {
        return const Center(child: Text("No videos found"));
      }
      return Column(
        children: filteredVideos.map((video) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  video['thumbnail']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(video['title']!),
              subtitle: Text("${video['writer']} • ${video['duration']}"),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Videodetails(video: video),
                    ),
                  );
                },
                child: const Icon(
                  Icons.play_circle_fill,
                  color: Colors.green,
                  size: 30,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Videodetails(video: video),
                  ),
                );
              },
            ),
          );
        }).toList(),
      );
    } else if (selectedTab == 1) {
      return Column(
        children: filteredArticles.map((article) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  article['thumbnail']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(article['title']!),
              subtitle: Text("By ${article['author']}"),
              trailing: const Icon(Icons.open_in_new, color: Colors.green),
              onTap: () {},
            ),
          );
        }).toList(),
      );
    } else {
      return Column(
        children: filteredEbooks.map((ebook) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  ebook['thumbnail']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(ebook['title']!),
              subtitle: Text("By ${ebook['author']}"),
              trailing: const Icon(Icons.open_in_new, color: Colors.green),
              onTap: () {},
            ),
          );
        }).toList(),
      );
    }
  }
}
