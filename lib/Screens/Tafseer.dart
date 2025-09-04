import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tafseer extends StatefulWidget {
  const Tafseer({super.key});

  @override
  State<Tafseer> createState() => _TafseerState();
}

class _TafseerState extends State<Tafseer> {
  final TextEditingController _searchController = TextEditingController();
  bool showSearch = false;
  String _searchQuery = '';
  int selectedTab = 0;

  final List<Map<String, String>> surahData = [
    {
      "number": "1",
      "name": "Al-Faṯihah",
      "place": "Meccah",
      "verses": "7 Verses",
      "arabic": "ٱلْفَاتِحَةُ",
    },
    {
      "number": "2",
      "name": "Al-Baqara",
      "place": "Medinah",
      "verses": "286 Verses",
      "arabic": "ٱلْبَقَرَةُ",
    },
    {
      "number": "3",
      "name": "Āl ʿImrān",
      "place": "Medinah",
      "verses": "200 Verses",
      "arabic": "آلِ عِمْرَانَ", // Diacritized
    },
    {
      "number": "4",
      "name": "An-Nisāʾ",
      "place": "Medinah",
      "verses": "176 Verses",
      "arabic": "ٱلنِّسَاءُ", // Diacritized
    },
    {
      "number": "5",
      "name": "Al-Mā’idah",
      "place": "Medinah",
      "verses": "120 Verses",
      "arabic": "ٱلْمَائِدَةُ", // Diacritized
    },
    {
      "number": "6",
      "name": "Al-Anʿām",
      "place": "Meccah",
      "verses": "165 Verses",
      "arabic": "ٱلْأَنْعَامُ", // Diacritized
    },
    {
      "number": "7",
      "name": "Al-Aʿrāf",
      "place": "Meccah",
      "verses": "206 Verses",
      "arabic": "ٱلْأَعْرَافُ", // Diacritized
    },
    {
      "number": "8",
      "name": "Al-Anfāl",
      "place": "Medinah",
      "verses": "75 Verses",
      "arabic": "ٱلْأَنْفَالُ", // Diacritized
    },
    {
      "number": "9",
      "name": "At-Tawbah",
      "place": "Medinah",
      "verses": "129 Verses",
      "arabic": "ٱلتَّوْبَةُ", // Diacritized
    },
    {
      "number": "10",
      "name": "Yūnus",
      "place": "Meccah",
      "verses": "109 Verses",
      "arabic": "يُونُسُ", // Diacritized
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSurah = surahData.where((surah) {
      final number = surah["number"]!;
      final name = surah["name"]!.toLowerCase();
      final arabic = surah["arabic"]!;
      return name.contains(_searchQuery) ||
          arabic.contains(_searchQuery) ||
          number.contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          'تَفْسِيرٌ',
          style: GoogleFonts.scheherazadeNew(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
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
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(height: 10),
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
                _buildTabButton("Surah", 0),
                _buildTabButton("Juz", 1),
                _buildTabButton("Bookmarks", 2),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: getTabContent(filteredSurah)),
        ],
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

  Widget getTabContent(List<Map<String, String>> filteredSurah) {
    if (selectedTab == 0) {
      return ListView.builder(
        itemCount: filteredSurah.length,
        itemBuilder: (context, index) {
          final surah = filteredSurah[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade900,
                child: Text(
                  surah["number"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                surah["name"]!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${surah["place"]} | ${surah["verses"]}",
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    surah["arabic"]!,
                    style: GoogleFonts.lateef(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.download, color: Colors.green.shade800),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${surah["name"]} Downloaded!")),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (selectedTab == 1) {
      return const Center(child: Text("Juz Content Coming Soon"));
    } else {
      return const Center(child: Text("Bookmarks will appear here"));
    }
  }
}
