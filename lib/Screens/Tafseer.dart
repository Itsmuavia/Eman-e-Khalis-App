import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
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
      "name": "Al-Fatihah (The Opening)",
      "place": "Meccah",
      "verses": "7",
      "arabic": "ٱلْفَاتِحَة",
    },
    {
      "number": "2",
      "name": "Al-Baqarah (The Cow)",
      "place": "Medinah",
      "verses": "286",
      "arabic": "ٱلْبَقَرَة",
    },
    {
      "number": "3",
      "name": "Aal-Imran (Family of Imran)",
      "place": "Medinah",
      "verses": "200",
      "arabic": "آلِ عِمْرَان",
    },
    {
      "number": "4",
      "name": "An-Nisa (The Women)",
      "place": "Medinah",
      "verses": "176",
      "arabic": "ٱلنِّسَاء",
    },
    {
      "number": "5",
      "name": "Al-Maidah (The Table Spread)",
      "place": "Medinah",
      "verses": "120",
      "arabic": "ٱلْمَائِدَة",
    },
    {
      "number": "6",
      "name": "Al-Anam (The Cattle)",
      "place": "Meccah",
      "verses": "165",
      "arabic": "ٱلْأَنْعَام",
    },
    {
      "number": "7",
      "name": "Al-Araf (The Heights)",
      "place": "Meccah",
      "verses": "206",
      "arabic": "ٱلْأَعْرَاف",
    },
    {
      "number": "8",
      "name": "Al-Anfal (The Spoils of War)",
      "place": "Medinah",
      "verses": "75",
      "arabic": "ٱلْأَنْفَال",
    },
    {
      "number": "9",
      "name": "At-Tawbah (The Repentance)",
      "place": "Medinah",
      "verses": "129",
      "arabic": "ٱلتَّوْبَة",
    },
    {
      "number": "10",
      "name": "Yunus (Jonah)",
      "place": "Meccah",
      "verses": "109",
      "arabic": "يُونُس",
    },
    {
      "number": "11",
      "name": "Hud (Hud)",
      "place": "Meccah",
      "verses": "123",
      "arabic": "هُود",
    },
    {
      "number": "12",
      "name": "Yusuf (Joseph)",
      "place": "Meccah",
      "verses": "111",
      "arabic": "يُوسُف",
    },
    {
      "number": "13",
      "name": "Ar-Rad (The Thunder)",
      "place": "Medinah",
      "verses": "43",
      "arabic": "ٱلرَّعْد",
    },
    {
      "number": "14",
      "name": "Ibrahim (Abraham)",
      "place": "Meccah",
      "verses": "52",
      "arabic": "إِبْرَاهِيم",
    },
    {
      "number": "15",
      "name": "Al-Hijr (The Rocky Tract)",
      "place": "Meccah",
      "verses": "99",
      "arabic": "ٱلْحِجْر",
    },
    {
      "number": "16",
      "name": "An-Nahl (The Bee)",
      "place": "Meccah",
      "verses": "128",
      "arabic": "ٱلنَّحْل",
    },
    {
      "number": "17",
      "name": "Al-Isra (The Night Journey)",
      "place": "Meccah",
      "verses": "111",
      "arabic": "ٱلْإِسْرَاء",
    },
    {
      "number": "18",
      "name": "Al-Kahf (The Cave)",
      "place": "Meccah",
      "verses": "110",
      "arabic": "ٱلْكَهْف",
    },
    {
      "number": "19",
      "name": "Maryam (Mary)",
      "place": "Meccah",
      "verses": "98",
      "arabic": "مَرْيَم",
    },
    {
      "number": "20",
      "name": "Ta-Ha (Ta-Ha)",
      "place": "Meccah",
      "verses": "135",
      "arabic": "طه",
    },
    {
      "number": "21",
      "name": "Al-Anbiya (The Prophets)",
      "place": "Meccah",
      "verses": "112",
      "arabic": "ٱلْأَنْبِيَاء",
    },
    {
      "number": "22",
      "name": "Al-Hajj (The Pilgrimage)",
      "place": "Medinah",
      "verses": "78",
      "arabic": "ٱلْحَجّ",
    },
    {
      "number": "23",
      "name": "Al-Mu’minun (The Believers)",
      "place": "Meccah",
      "verses": "118",
      "arabic": "ٱلْمُؤْمِنُون",
    },
    {
      "number": "24",
      "name": "An-Nur (The Light)",
      "place": "Medinah",
      "verses": "64",
      "arabic": "ٱلنُّور",
    },
    {
      "number": "25",
      "name": "Al-Furqan (The Criterion)",
      "place": "Meccah",
      "verses": "77",
      "arabic": "ٱلْفُرْقَان",
    },
    {
      "number": "26",
      "name": "Ash-Shu’ara (The Poets)",
      "place": "Meccah",
      "verses": "227",
      "arabic": "ٱلشُّعَرَاء",
    },
    {
      "number": "27",
      "name": "An-Naml (The Ants)",
      "place": "Meccah",
      "verses": "93",
      "arabic": "ٱلنَّمْل",
    },
    {
      "number": "28",
      "name": "Al-Qasas (The Stories)",
      "place": "Meccah",
      "verses": "88",
      "arabic": "ٱلْقَصَص",
    },
    {
      "number": "29",
      "name": "Al-Ankabut (The Spider)",
      "place": "Meccah",
      "verses": "69",
      "arabic": "ٱلْعَنْكَبُوت",
    },
    {
      "number": "30",
      "name": "Ar-Rum (The Romans)",
      "place": "Meccah",
      "verses": "60",
      "arabic": "ٱلرُّوم",
    },
    {
      "number": "31",
      "name": "Luqman (Luqman)",
      "place": "Meccah",
      "verses": "34",
      "arabic": "لُقْمَان",
    },
    {
      "number": "32",
      "name": "As-Sajdah (The Prostration)",
      "place": "Meccah",
      "verses": "30",
      "arabic": "ٱلسَّجْدَة",
    },
    {
      "number": "33",
      "name": "Al-Ahzab (The Confederates)",
      "place": "Medinah",
      "verses": "73",
      "arabic": "ٱلْأَحْزَاب",
    },
    {
      "number": "34",
      "name": "Saba (Sheba)",
      "place": "Meccah",
      "verses": "54",
      "arabic": "سَبَإ",
    },
    {
      "number": "35",
      "name": "Fatir (The Originator)",
      "place": "Meccah",
      "verses": "45",
      "arabic": "فَاطِر",
    },
    {
      "number": "36",
      "name": "Ya-Sin (Ya-Sin)",
      "place": "Meccah",
      "verses": "83",
      "arabic": "يس",
    },
    {
      "number": "37",
      "name": "As-Saffat (Those who set the Ranks)",
      "place": "Meccah",
      "verses": "182",
      "arabic": "ٱلصَّافَّات",
    },
    {
      "number": "38",
      "name": "Sad (Sad)",
      "place": "Meccah",
      "verses": "88",
      "arabic": "ص",
    },
    {
      "number": "39",
      "name": "Az-Zumar (The Groups)",
      "place": "Meccah",
      "verses": "75",
      "arabic": "ٱلزُّمَر",
    },
    {
      "number": "40",
      "name": "Ghafir (The Forgiver)",
      "place": "Meccah",
      "verses": "85",
      "arabic": "غَافِر",
    },
    {
      "number": "41",
      "name": "Fussilat (Explained in Detail)",
      "place": "Meccah",
      "verses": "54",
      "arabic": "فُصِّلَتْ",
    },
    {
      "number": "42",
      "name": "Ash-Shura (The Consultation)",
      "place": "Meccah",
      "verses": "53",
      "arabic": "ٱلشُّورَىٰ",
    },
    {
      "number": "43",
      "name": "Az-Zukhruf (The Gold Adornments)",
      "place": "Meccah",
      "verses": "89",
      "arabic": "ٱلزُّخْرُف",
    },
    {
      "number": "44",
      "name": "Ad-Dukhan (The Smoke)",
      "place": "Meccah",
      "verses": "59",
      "arabic": "ٱلدُّخَان",
    },
    {
      "number": "45",
      "name": "Al-Jathiyah (The Crouching)",
      "place": "Meccah",
      "verses": "37",
      "arabic": "ٱلْجَاثِيَة",
    },
    {
      "number": "46",
      "name": "Al-Ahqaf (The Wind-Curved Sandhills)",
      "place": "Meccah",
      "verses": "35",
      "arabic": "ٱلْأَحْقَاف",
    },
    {
      "number": "47",
      "name": "Muhammad (Muhammad)",
      "place": "Medinah",
      "verses": "38",
      "arabic": "مُحَمَّد",
    },
    {
      "number": "48",
      "name": "Al-Fath (The Victory)",
      "place": "Medinah",
      "verses": "29",
      "arabic": "ٱلْفَتْح",
    },
    {
      "number": "49",
      "name": "Al-Hujurat (The Rooms)",
      "place": "Medinah",
      "verses": "18",
      "arabic": "ٱلْحُجُرَات",
    },
    {
      "number": "50",
      "name": "Qaf (Qaf)",
      "place": "Meccah",
      "verses": "45",
      "arabic": "ق",
    },
    {
      "number": "51",
      "name": "Adh-Dhariyat (The Winnowing Winds)",
      "place": "Meccah",
      "verses": "60",
      "arabic": "ٱلذَّارِيَات",
    },
    {
      "number": "52",
      "name": "At-Tur (The Mount)",
      "place": "Meccah",
      "verses": "49",
      "arabic": "ٱلطُّور",
    },
    {
      "number": "53",
      "name": "An-Najm (The Star)",
      "place": "Meccah",
      "verses": "62",
      "arabic": "ٱلنَّجْم",
    },
    {
      "number": "54",
      "name": "Al-Qamar (The Moon)",
      "place": "Meccah",
      "verses": "55",
      "arabic": "ٱلْقَمَر",
    },
    {
      "number": "55",
      "name": "Ar-Rahman (The Beneficent)",
      "place": "Medinah",
      "verses": "78",
      "arabic": "ٱلرَّحْمَٰن",
    },
    {
      "number": "56",
      "name": "Al-Waqi’ah (The Inevitable)",
      "place": "Meccah",
      "verses": "96",
      "arabic": "ٱلْوَاقِعَة",
    },
    {
      "number": "57",
      "name": "Al-Hadid (The Iron)",
      "place": "Medinah",
      "verses": "29",
      "arabic": "ٱلْحَدِيد",
    },
    {
      "number": "58",
      "name": "Al-Mujadila (The Woman Who Disputes)",
      "place": "Medinah",
      "verses": "22",
      "arabic": "ٱلْمُجَادِلَة",
    },
    {
      "number": "59",
      "name": "Al-Hashr (The Exile)",
      "place": "Medinah",
      "verses": "24",
      "arabic": "ٱلْحَشْر",
    },
    {
      "number": "60",
      "name": "Al-Mumtahanah (She that is to be examined)",
      "place": "Medinah",
      "verses": "13",
      "arabic": "ٱلْمُمْتَحَنَة",
    },
    {
      "number": "61",
      "name": "As-Saff (The Ranks)",
      "place": "Medinah",
      "verses": "14",
      "arabic": "ٱلصَّف",
    },
    {
      "number": "62",
      "name": "Al-Jumu’ah (Friday)",
      "place": "Medinah",
      "verses": "11",
      "arabic": "ٱلْجُمُعَة",
    },
    {
      "number": "63",
      "name": "Al-Munafiqun (The Hypocrites)",
      "place": "Medinah",
      "verses": "11",
      "arabic": "ٱلْمُنَافِقُون",
    },
    {
      "number": "64",
      "name": "At-Taghabun (Mutual Disillusion)",
      "place": "Medinah",
      "verses": "18",
      "arabic": "ٱلتَّغَابُن",
    },
    {
      "number": "65",
      "name": "At-Talaq (Divorce)",
      "place": "Medinah",
      "verses": "12",
      "arabic": "ٱلطَّلَاق",
    },
    {
      "number": "66",
      "name": "At-Tahrim (The Prohibition)",
      "place": "Medinah",
      "verses": "12",
      "arabic": "ٱلتَّحْرِيم",
    },
    {
      "number": "67",
      "name": "Al-Mulk (The Sovereignty)",
      "place": "Meccah",
      "verses": "30",
      "arabic": "ٱلْمُلْك",
    },
    {
      "number": "68",
      "name": "Al-Qalam (The Pen)",
      "place": "Meccah",
      "verses": "52",
      "arabic": "ٱلْقَلَم",
    },
    {
      "number": "69",
      "name": "Al-Haqqah (The Inevitable)",
      "place": "Meccah",
      "verses": "52",
      "arabic": "ٱلْحَاقَّة",
    },
    {
      "number": "70",
      "name": "Al-Ma’arij (The Ascending Stairways)",
      "place": "Meccah",
      "verses": "44",
      "arabic": "ٱلْمَعَارِج",
    },
    {
      "number": "71",
      "name": "Nuh (Noah)",
      "place": "Meccah",
      "verses": "28",
      "arabic": "نُوح",
    },
    {
      "number": "72",
      "name": "Al-Jinn (The Jinn)",
      "place": "Meccah",
      "verses": "28",
      "arabic": "ٱلْجِنّ",
    },
    {
      "number": "73",
      "name": "Al-Muzzammil (The Enshrouded One)",
      "place": "Meccah",
      "verses": "20",
      "arabic": "ٱلْمُزَّمِّل",
    },
    {
      "number": "74",
      "name": "Al-Muddaththir (The Cloaked One)",
      "place": "Meccah",
      "verses": "56",
      "arabic": "ٱلْمُدَّثِّر",
    },
    {
      "number": "75",
      "name": "Al-Qiyamah (The Resurrection)",
      "place": "Meccah",
      "verses": "40",
      "arabic": "ٱلْقِيَامَة",
    },
    {
      "number": "76",
      "name": "Al-Insan (Man)",
      "place": "Medinah",
      "verses": "31",
      "arabic": "ٱلْإِنسَان",
    },
    {
      "number": "77",
      "name": "Al-Mursalat (The Emissaries)",
      "place": "Meccah",
      "verses": "50",
      "arabic": "ٱلْمُرْسَلَات",
    },
    {
      "number": "78",
      "name": "An-Naba (The Tidings)",
      "place": "Meccah",
      "verses": "40",
      "arabic": "ٱلنَّبَإ",
    },
    {
      "number": "79",
      "name": "An-Nazi’at (Those who drag forth)",
      "place": "Meccah",
      "verses": "46",
      "arabic": "ٱلنَّازِعَات",
    },
    {
      "number": "80",
      "name": "‘Abasa (He frowned)",
      "place": "Meccah",
      "verses": "42",
      "arabic": "عَبَس",
    },
    {
      "number": "81",
      "name": "At-Takwir (The Overthrowing)",
      "place": "Meccah",
      "verses": "29",
      "arabic": "ٱلتَّكْوِير",
    },
    {
      "number": "82",
      "name": "Al-Infitar (The Cleaving)",
      "place": "Meccah",
      "verses": "19",
      "arabic": "ٱلْإِنفِطَار",
    },
    {
      "number": "83",
      "name": "Al-Mutaffifin (Defrauding)",
      "place": "Meccah",
      "verses": "36",
      "arabic": "ٱلْمُطَفِّفِينَ",
    },
    {
      "number": "84",
      "name": "Al-Inshiqaq (The Splitting Open)",
      "place": "Meccah",
      "verses": "25",
      "arabic": "ٱلْإِنشِقَاق",
    },
    {
      "number": "85",
      "name": "Al-Buruj (The Mansions of the Stars)",
      "place": "Meccah",
      "verses": "22",
      "arabic": "ٱلْبُرُوج",
    },
    {
      "number": "86",
      "name": "At-Tariq (The Morning Star)",
      "place": "Meccah",
      "verses": "17",
      "arabic": "ٱلطَّارِق",
    },
    {
      "number": "87",
      "name": "Al-A’la (The Most High)",
      "place": "Meccah",
      "verses": "19",
      "arabic": "ٱلْأَعْلَى",
    },
    {
      "number": "88",
      "name": "Al-Ghashiyah (The Overwhelming)",
      "place": "Meccah",
      "verses": "26",
      "arabic": "ٱلْغَاشِيَة",
    },
    {
      "number": "89",
      "name": "Al-Fajr (The Dawn)",
      "place": "Meccah",
      "verses": "30",
      "arabic": "ٱلْفَجْر",
    },
    {
      "number": "90",
      "name": "Al-Balad (The City)",
      "place": "Meccah",
      "verses": "20",
      "arabic": "ٱلْبَلَد",
    },
    {
      "number": "91",
      "name": "Ash-Shams (The Sun)",
      "place": "Meccah",
      "verses": "15",
      "arabic": "ٱلشَّمْس",
    },
    {
      "number": "92",
      "name": "Al-Layl (The Night)",
      "place": "Meccah",
      "verses": "21",
      "arabic": "ٱلْلَّيْل",
    },
    {
      "number": "93",
      "name": "Ad-Duhaa (The Morning Hours)",
      "place": "Meccah",
      "verses": "11",
      "arabic": "ٱلضُّحَى",
    },
    {
      "number": "94",
      "name": "Ash-Sharh (The Relief)",
      "place": "Meccah",
      "verses": "8",
      "arabic": "ٱلشَّرْح",
    },
    {
      "number": "95",
      "name": "At-Tin (The Fig)",
      "place": "Meccah",
      "verses": "8",
      "arabic": "ٱلتِّين",
    },
    {
      "number": "96",
      "name": "Al-‘Alaq (The Clot)",
      "place": "Meccah",
      "verses": "19",
      "arabic": "ٱلْعَلَق",
    },
    {
      "number": "97",
      "name": "Al-Qadr (The Power)",
      "place": "Meccah",
      "verses": "5",
      "arabic": "ٱلْقَدْر",
    },
    {
      "number": "98",
      "name": "Al-Bayyina (The Clear Proof)",
      "place": "Medinah",
      "verses": "8",
      "arabic": "ٱلْبَيِّنَة",
    },
    {
      "number": "99",
      "name": "Az-Zalzalah (The Earthquake)",
      "place": "Medinah",
      "verses": "8",
      "arabic": "ٱلزَّلْزَلَة",
    },
    {
      "number": "100",
      "name": "Al-‘Adiyat (The Courser)",
      "place": "Meccah",
      "verses": "11",
      "arabic": "ٱلْعَادِيَات",
    },
    {
      "number": "101",
      "name": "Al-Qari’ah (The Calamity)",
      "place": "Meccah",
      "verses": "11",
      "arabic": "ٱلْقَارِعَة",
    },
    {
      "number": "102",
      "name": "At-Takathur (Rivalry in worldly increase)",
      "place": "Meccah",
      "verses": "8",
      "arabic": "ٱلتَّكَاثُر",
    },
    {
      "number": "103",
      "name": "Al-‘Asr (The Declining Day)",
      "place": "Meccah",
      "verses": "3",
      "arabic": "ٱلْعَصْر",
    },
    {
      "number": "104",
      "name": "Al-Humazah (The Traducer)",
      "place": "Meccah",
      "verses": "9",
      "arabic": "ٱلْهُمَزَة",
    },
    {
      "number": "105",
      "name": "Al-Fil (The Elephant)",
      "place": "Meccah",
      "verses": "5",
      "arabic": "ٱلْفِيل",
    },
    {
      "number": "106",
      "name": "Quraish (Quraish)",
      "place": "Meccah",
      "verses": "4",
      "arabic": "قُرَيْش",
    },
    {
      "number": "107",
      "name": "Al-Ma’un (Small Kindnesses)",
      "place": "Meccah",
      "verses": "7",
      "arabic": "ٱلْمَاعُون",
    },
    {
      "number": "108",
      "name": "Al-Kawthar (Abundance)",
      "place": "Meccah",
      "verses": "3",
      "arabic": "ٱلْكَوْثَر",
    },
    {
      "number": "109",
      "name": "Al-Kafirun (The Disbelievers)",
      "place": "Meccah",
      "verses": "6",
      "arabic": "ٱلْكَافِرُون",
    },
    {
      "number": "110",
      "name": "An-Nasr (Divine Support)",
      "place": "Medinah",
      "verses": "3",
      "arabic": "ٱلنَّصْر",
    },
    {
      "number": "111",
      "name": "Al-Masad (The Palm Fiber)",
      "place": "Meccah",
      "verses": "5",
      "arabic": "ٱلْمَسَد",
    },
    {
      "number": "112",
      "name": "Al-Ikhlas (Sincerity)",
      "place": "Meccah",
      "verses": "4",
      "arabic": "ٱلْإِخْلَاص",
    },
    {
      "number": "113",
      "name": "Al-Falaq (The Daybreak)",
      "place": "Meccah",
      "verses": "5",
      "arabic": "ٱلْفَلَق",
    },
    {
      "number": "114",
      "name": "An-Nas (Mankind)",
      "place": "Meccah",
      "verses": "6",
      "arabic": "ٱلنَّاس",
    },
  ];
  final List<Map<String, String>> JuzData = [
    {
      "number": "1",
      "name": "Juz 1",
      "title": "Started at AL-FATIHA verse 1",
      "arabic": "ٱلْفَاتِحَةُ",
    },
    {
      "number": "2",
      "name": "Juz 2",
      "title": "Started at AL-BAQARAH verse 142",
      "arabic": "ٱلْبَقَرَةُ",
    },
    {
      "number": "3",
      "name": "Juz 3",
      "title": "Started at AL-BAQARAH verse 253",
      "arabic": "آلِ عِمْرَانَ",
    },
    {
      "number": "4",
      "name": "Juz 4",
      "title": "Started at ALI-IMRAN verse 92",
      "arabic": "آلِ عِمْرَانَ",
    },
    {
      "number": "5",
      "name": "Juz 5",
      "title": "Started at AN-NISA verse 24",
      "arabic": "ٱلنِّسَاءُ",
    },
    {
      "number": "6",
      "name": "Juz 6",
      "title": "Started at AN-NISA verse 148",
      "arabic": "ٱلنِّسَاءُ",
    },
    {
      "number": "7",
      "name": "Juz 7",
      "title": "Started at AL-MA'IDAH verse 83",
      "arabic": "ٱلْمَائِدَةُ",
    },
    {
      "number": "8",
      "name": "Juz 8",
      "title": "Started at AL-AN'AM verse 111",
      "arabic": "ٱلْأَنْعَامُ",
    },
    {
      "number": "9",
      "name": "Juz 9",
      "title": "Started at AL-AR'AF verse 88",
      "arabic": "ٱلْأَعْرَافُ",
    },
    {
      "number": "10",
      "name": "Juz 10",
      "title": "Started at AL-ANFAL verse 41",
      "arabic": "ٱلْأَنْفَالُ",
    },
    {
      "number": "11",
      "name": "Juz 11",
      "title": "Started at AN-NI'SA verse 156",
      "arabic": "ٱلنِّسَاءُ",
    },
    {
      "number": "12",
      "name": "Juz 12",
      "title": "Started at AL-AN'AM verse 145",
      "arabic": "ٱلْأَنْعَامُ",
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

  // 🔹 Show Dialog to Jump to Surah and Verse
  void _showJumpDialog(BuildContext context) {
    String selectedSurah = surahData[0]["name"]!;
    int selectedIndex = 0;
    final TextEditingController verseController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int totalVerses =
                int.tryParse(surahData[selectedIndex]["verses"]!) ?? 1;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                children: const [
                  Icon(Icons.compare_arrows, color: Colors.blueGrey),
                  SizedBox(width: 8),
                  Text("Jump to Surah"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedSurah,
                    isExpanded: true,
                    items: surahData.map((surah) {
                      return DropdownMenuItem<String>(
                        value: surah["name"]!,
                        child: Text("${surah["number"]}. ${surah["name"]}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSurah = value!;
                        selectedIndex = surahData.indexWhere(
                          (s) => s["name"] == value,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Text("Enter the number of verse between 1-$totalVerses"),
                  TextField(
                    controller: verseController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "e.g. 1"),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                  ),
                  onPressed: () {
                    final verse = int.tryParse(verseController.text);
                    if (verse != null && verse > 0 && verse <= totalVerses) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Jumping to $selectedSurah - Verse $verse",
                          ),
                        ),
                      );
                    } else {
                      AchievementView(
                        color: Colors.red,
                        title: "Enter a Valid ayat number",
                        subTitle: "Please enter a valid ayat number",
                        icon: Icon(Icons.error, color: Colors.white),
                        typeAnimationContent:
                            AnimationTypeAchievement.fadeSlideToLeft,
                        alignment: Alignment.topCenter,
                        duration: Duration(seconds: 3),
                        isCircle: true,
                      ).show(context);
                    }
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
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

    final filteredJuz = JuzData.where((juz) {
      final number = juz["number"]!;
      final name = juz["name"]!.toLowerCase();
      final title = juz["title"]!.toLowerCase();
      final arabic = juz["arabic"]!;
      return name.contains(_searchQuery) ||
          arabic.contains(_searchQuery) ||
          number.contains(_searchQuery) ||
          title.contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 400;
            final isTablet = constraints.maxWidth > 600;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
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
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue.shade100),
                          ),
                          child: Row(
                            children: [
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
                                  style: const TextStyle(fontSize: 14),
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

                      // const SizedBox(width: 5),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.filter_alt_rounded,
                      //     size: 25,
                      //     color: Colors.blueGrey,
                      //   ),
                      //   onPressed: () => _showJumpDialog(context),
                      // ),
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filtered Surahs",
                        style: GoogleFonts.pacifico(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.blueAccent,
                          size: 28,
                        ),
                        onPressed: () => _showJumpDialog(context),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Surah List
                      filteredSurah.isEmpty
                          ? Center(
                              child: Text(
                                _searchQuery.isNotEmpty
                                    ? "Not Found"
                                    : "No Surah available",
                                style: TextStyle(
                                  color: Colors.blueGrey.shade400,
                                  fontSize: isSmallScreen ? 13 : 15,
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
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: isSmallScreen ? 11 : 13,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      surah["name"]!,
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 13 : 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      "${surah["place"]} | ${surah["verses"]}",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 11 : 12,
                                        color: Colors.blueGrey.shade400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Wrap(
                                      spacing: isSmallScreen ? 4 : 6,
                                      children: [
                                        Text(
                                          surah["arabic"]!,
                                          style: GoogleFonts.lateef(
                                            fontSize: isSmallScreen ? 17 : 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade900,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          // icons tight ho jayenge
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.download,
                                                color: Colors.blue.shade700,
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.play_circle,
                                                color: Colors.green.shade700,
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.open_in_new,
                                                color: Colors.amber.shade700,
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                      filteredJuz.isEmpty
                          ? const Center(child: Text("No Juz found"))
                          : ListView.builder(
                              itemCount: filteredJuz.length,
                              itemBuilder: (context, index) {
                                final juz = filteredJuz[index];
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
                                      backgroundColor: Colors.blue.shade700,
                                      child: Text(
                                        juz["number"]!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(juz["name"]!),
                                    subtitle: Text(
                                      juz["title"]!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Wrap(
                                      spacing: 6,
                                      children: [
                                        Text(
                                          juz["arabic"]!,
                                          style: GoogleFonts.lateef(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade900,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.bookmark_outline,
                                            color: Colors.red.shade400,
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.open_in_new,
                                            color: Colors.amber.shade700,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                      // 🔸 Bookmarks Tab
                      const Center(child: Text("Bookmarks will appear here")),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
