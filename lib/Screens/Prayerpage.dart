import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Prayerpage extends StatefulWidget {
  const Prayerpage({super.key});

  @override
  State<Prayerpage> createState() => _PrayerpageState();
}

class _PrayerpageState extends State<Prayerpage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> prayerList = [
    {
      "number": "1",
      "title": "تکبیر تحریمہ",
      "subtitle": "نماز کی ابتدا",
      "english": "Takbeer Tahreema",
    },
    {
      "number": "2",
      "title": "تکبیر تحریمہ کے بعد کی دعائیں",
      "subtitle": "کھڑے ہونے کی حالت",
      "english": "Prayers after Takbeer",
    },
    {
      "number": "3",
      "title": "رُکوع کی دعائیں",
      "subtitle": "جھکنے کی حالت",
      "english": "Ruku Prayers",
    },
    {
      "number": "4",
      "title": "رُکوع سے اٹھنے کی دعائیں",
      "subtitle": "رُکوع اور سجدے کے بیج میں",
      "english": "Prayers after Ruku",
    },
    {
      "number": "5",
      "title": "سجدے کی دعائیں",
      "subtitle": "سجدے کی حالت",
      "english": "Sajda Prayers",
    },
    {
      "number": "6",
      "title": "دو سجدے کے درمیان کی دعائیں",
      "subtitle": "سجدے اور بیٹھنے کے درمیان کی دعائیں",
      "english": "Prayers between Sajdas",
    },
    {
      "number": "7",
      "title": "تشہد اور درودُ وسلام",
      "subtitle": "سلام کے بعد کی دعائیں",
      "english": "Tashahhud and Salutations",
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
    final filteredPrayers = prayerList.where((prayer) {
      final number = prayer["number"] ?? '';
      final title = (prayer["title"] ?? '').toLowerCase();
      final subtitle = (prayer["subtitle"] ?? '').toLowerCase();
      final english = (prayer["english"] ?? '').toLowerCase();

      return title.contains(_searchQuery) ||
          subtitle.contains(_searchQuery) ||
          english.contains(_searchQuery) ||
          number.contains(_searchQuery);
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient:LinearGradient(
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
                  // Branding Left
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
                              'صَلاۃ',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Prayer',
                              style: GoogleFonts.scheherazadeNew(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Search Box
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
                                hintText: 'Search ......',
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
            Expanded(
            child: filteredPrayers.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off,
                      size: 55, color: Colors.green.shade200),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isNotEmpty
                        ? "No prayers found for '$_searchQuery'"
                        : "No prayers available",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: filteredPrayers.length,
              itemBuilder: (context, index) {
                return _buildPrayerCard(filteredPrayers[index]);
              },
            ),
          ),
        ],
      ),
    ),
    );
  }


  Widget _buildPrayerCard(Map<String, dynamic> prayer) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 4,
        shadowColor: Colors.green.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  child: Icon(Icons.arrow_back_ios,
                      size: 25, color: Colors.blueGrey.shade900),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        prayer["title"] ?? '',
                        style: GoogleFonts.lateef(
                          fontSize: 27,
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        prayer["english"] ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey.shade700,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        prayer["subtitle"] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade300,
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          prayer["number"] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
