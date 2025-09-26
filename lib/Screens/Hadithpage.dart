import 'package:emane_khalis_app/Screens/Ibadat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'Fastingpage.dart';
import 'Hajjumrahpage.dart';
import 'Loginpage.dart';
import 'Prayerpage.dart';
import 'QnA.dart';

class Hadithpage extends StatefulWidget {
  const Hadithpage({super.key});

  @override
  State<Hadithpage> createState() => _HadithpageState();
}

class _HadithpageState extends State<Hadithpage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> ibadatItems = [
    {
      "titleEn": "Al-Bukhari",
      "titleur": "صحيح البخاري",
      "icon": FontAwesomeIcons.book,
    },
    {
      "titleEn": "Al-Muslim",
      "titleur": "صحيح مسلم",
      "icon": FontAwesomeIcons.bookAtlas,
    },
    {
      "titleEn": "Al-Tirmizi",
      "titleur": "جامع ترمذي",
      "icon": FontAwesomeIcons.bookQuran,
    },
    {
      "titleEn": "Abu Dawood",
      "titleur": "سنن أبو داود",
      "icon": FontAwesomeIcons.bookOpen,
    },
    {
      "titleEn": "Al-Nasai",
      "titleur": "سنن النسائي",
      "icon": MdiIcons.bookOpenBlankVariant,
    },
    {
      "titleEn": "Ibn e Majah",
      "titleur": "سنن ابن ماجہ",
      "icon": MdiIcons.bookOpenPageVariant,
    },
  ];

  List<Map<String, dynamic>> _filterList() {
    if (_searchQuery.isEmpty) return ibadatItems;
    return ibadatItems.where((item) {
      return item["titleEn"]!.toLowerCase().contains(_searchQuery) ||
          item["titleur"]!.contains(_searchQuery);
    }).toList();
  }

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
    final filteredItems = _filterList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Bar
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
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
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
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'حديث',
                              style: GoogleFonts.amiri(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Hadith',
                          style: GoogleFonts.scheherazadeNew(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      child: Icon(
                        FontAwesomeIcons.listCheck,
                        size: 25,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search Hadith...",
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
                        child: const Icon(
                          Icons.clear,
                          size: 18,
                          color: Colors.blueGrey,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 55,
                            color: Colors.blue.shade200,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isNotEmpty
                                ? "No hadith found for '$_searchQuery'"
                                : "No hadith available",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey.shade800,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Responsive
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return GestureDetector(
                          onTap: () {
                            Widget nextPage;
                            switch (item["titleEn"]) {
                              case "Al-Bukhari":
                                nextPage = Prayerpage();
                                break;
                              case "Al-Muslim":
                                nextPage = Fastingpage();
                                break;
                              case "Al-Tirmizi":
                                nextPage = HajjUmrahPage();
                                break;
                              case "Abu Dawood":
                                nextPage = Qna();
                                break;
                              case "Al Nasai":
                                nextPage = LoginPage();
                                break;
                                case "Ibn e Majah":
                                nextPage = Ibadat();
                                break;
                              default:
                                nextPage = const Scaffold(
                                  body: Center(child: Text("Page not found")),
                                );
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => nextPage,
                              ),
                            );
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF01102A), Color(0xFF187CE3)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(color: Colors.amber, width: 2),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/islamic_corner.png",
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.10,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    item['icon'] as IconData,
                                    size: 40,
                                    color: Colors.amberAccent,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    item["titleEn"],
                                    style: GoogleFonts.scheherazadeNew(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item["titleur"],
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.amiri(
                                      fontSize: 24,
                                      color: Colors.amberAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
