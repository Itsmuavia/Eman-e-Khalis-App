import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tafseer extends StatefulWidget {
  const Tafseer({super.key});

  @override
  State<Tafseer> createState() => _TafseerState();
}

class _TafseerState extends State<Tafseer> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late TabController _tabController;

  final List<Map<String, String>> surahData = [
    {
      "number": "1",
      "name": "Al-Fatihah",
      "place": "Meccah",
      "verses": "7 Verses",
      "arabic": "ٱلْفَاتِحَةُ",
    },
    {
      "number": "2",
      "name": "Al-Baqarah",
      "place": "Medinah",
      "verses": "286 Verses",
      "arabic": "ٱلْبَقَرَةُ",
    },
    {
      "number": "3",
      "name": "Āl ʿImrān",
      "place": "Medinah",
      "verses": "200 Verses",
      "arabic": "آلِ عِمْرَانَ",
    },
    {
      "number": "4",
      "name": "An-Nisāʾ",
      "place": "Medinah",
      "verses": "176 Verses",
      "arabic": "ٱلنِّسَاءُ",
    },
    {
      "number": "5",
      "name": "Al-Mā’idah",
      "place": "Medinah",
      "verses": "120 Verses",
      "arabic": "ٱلْمَائِدَةُ",
    },
    {
      "number": "6",
      "name": "Al-Mā’idah",
      "place": "Medinah",
      "verses": "120 Verses",
      "arabic": "ٱلْمَائِدَةُ",
    },
    {
      "number": "7",
      "name": "Al-Mā’idah",
      "place": "Medinah",
      "verses": "120 Verses",
      "arabic": "ٱلْمَائِدَةُ",
    },
    {
      "number": "8",
      "name": "Al-Mā’idah",
      "place": "Medinah",
      "verses": "120 Verses",
      "arabic": "ٱلْمَائِدَةُ",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      backgroundColor: const Color(0xFFF4F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Header with Search
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade400,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'تَفْسِير',
                              style: GoogleFonts.scheherazadeNew(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Quran Tafseer",
                          style: GoogleFonts.scheherazadeNew(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 6),
                          const Icon(Icons.search, color: Colors.blueGrey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Search Surah...',
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.search,
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                FocusScope.of(context).unfocus();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.clear,
                                  size: 18,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Tabs
            TabBar(
              controller: _tabController,
              labelColor: Colors.blue.shade800,
              unselectedLabelColor: Colors.blueGrey,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 3, color: Colors.amber),
              ),
              tabs: const [
                Tab(icon: Icon(Icons.menu_book), text: "Surah"),
                Tab(icon: Icon(Icons.layers), text: "Juz"),
                Tab(icon: Icon(Icons.bookmark), text: "Bookmarks"),
              ],
            ),

            // 🔹 Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // SURAH TAB
                  filteredSurah.isEmpty
                      ? Center(
                          child: Text(
                            _searchQuery.isNotEmpty
                                ? "Not Found"
                                : "No Surah available",
                            style: TextStyle(
                              color: Colors.blueGrey.shade400,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredSurah.length,
                          itemBuilder: (context, index) {
                            final surah = filteredSurah[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade800,
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
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey.shade400,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      surah["arabic"]!,
                                      style: GoogleFonts.lateef(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: Tooltip(
                                        message: "Download",
                                        child: Icon(
                                          Icons.download,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "${surah["name"]} Downloaded!",
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Tooltip(
                                        message: "Play audio",
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                      onPressed: () {

                                      },
                                    ),
                                    IconButton(
                                      icon: Tooltip(
                                        message: "Tafseer",
                                        child: Icon(
                                          Icons.open_in_new,
                                          color: Colors.amber.shade700,
                                        ),
                                      ),
                                      onPressed: () {
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                  const Center(
                    child: Text(
                      "Juz Content Coming Soon",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ),

                  const Center(
                    child: Text(
                      "Bookmarks will appear here",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
