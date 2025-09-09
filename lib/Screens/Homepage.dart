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
      'title': 'Surah Aal-e-Imran Ayat 92-101',
      'writer': 'Fawad Shah',
      'duration': '6:53 min',
      'thumbnail': 'assets/images/thumbnail1.png',
      'url': 'assets/videos/Surah Aal-e-Imran.mp4',
    },
    {
      'title': 'Surah Tawbah Rukoo#2',
      'writer': 'Furqan ul Huda',
      'duration': '16:47 min',
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
    double width = MediaQuery.of(context).size.width;

    final filteredVideos = videos.where((v) =>
    v["title"]!.toLowerCase().contains(_searchQuery) ||
        v["writer"]!.toLowerCase().contains(_searchQuery)).toList();

    final filteredArticles = articles.where((a) =>
    a["title"]!.toLowerCase().contains(_searchQuery) ||
        a["author"]!.toLowerCase().contains(_searchQuery)).toList();

    final filteredEbooks = ebooks.where((e) =>
    e["title"]!.toLowerCase().contains(_searchQuery) ||
        e["author"]!.toLowerCase().contains(_searchQuery)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F4),
      body: SafeArea(
        child: Column(
          children: [
            // Islamic Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   "assets/images/applogo.png",
                      //   width: 50,
                      //   height: 40,
                      // ),
                      const SizedBox(width: 10),
                      Text(
                        'اِيمَانٌ خَالِصٌ',
                        style: GoogleFonts.scheherazadeNew(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message:"search",
                        child: _buildIconButton(Icons.search, Colors.green.shade100, () {
                          setState(() {
                            showSearch = !showSearch;
                          });
                        }),
                      ),
                      const SizedBox(width: 8),
                      Tooltip(
                        message:"comment",
                          child: _buildIconButton(Icons.message, Colors.blue.shade100, () {})),
                      const SizedBox(width: 8),
                      Tooltip(
                          message: "logout",
                          child: _buildIconButton(Icons.logout, Colors.red.shade100, () {})),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
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
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon:
                    const Icon(Icons.search, color: Colors.green),
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

            // Slider
            CarouselSlider(
              options: CarouselOptions(
                height: width * 0.4,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: images.map((imgUrl) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(imgUrl, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.2),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(6),
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
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildTabContent(
                    filteredVideos, filteredArticles, filteredEbooks),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color bgColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black87, size: 22),
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
          color: selectedTab == index ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green, width: 1),
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

  Widget _buildTabContent(
      List<Map<String, String>> filteredVideos,
      List<Map<String, String>> filteredArticles,
      List<Map<String, String>> filteredEbooks) {
    if (selectedTab == 0) {
      return Column(
        children: filteredVideos.map((video) {
          return _buildCard(
            thumbnail: video['thumbnail']!,
            title: video['title']!,
            subtitle: "${video['writer']} • ${video['duration']}",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Videodetails(video: video),
                ),
              );
            },
          );
        }).toList(),
      );
    } else if (selectedTab == 1) {
      return Column(
        children: filteredArticles.map((article) {
          return _buildCard(
            thumbnail: article['thumbnail']!,
            title: article['title']!,
            subtitle: "By ${article['author']}",
            description: article['description'],
            onTap: () {},
          );
        }).toList(),
      );
    } else {
      return Column(
        children: filteredEbooks.map((ebook) {
          return _buildCard(
            thumbnail: ebook['thumbnail']!,
            title: ebook['title']!,
            subtitle: "By ${ebook['author']}",
            description: ebook['description'],
            onTap: () {},
          );
        }).toList(),
      );
    }
  }

  Widget _buildCard({
    required String thumbnail,
    required String title,
    required String subtitle,
    String? description,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            thumbnail,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: description != null
            ? Text("$subtitle\n$description",
            style: const TextStyle(fontSize: 12))
            : Text(subtitle),
        trailing: const Icon(Icons.open_in_new, color: Colors.green),
        onTap: onTap,
      ),
    );
  }
}
