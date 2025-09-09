import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class Videodetails extends StatefulWidget {
  final Map<String, String> video;

  const Videodetails({super.key, required this.video});

  @override
  State<Videodetails> createState() => _VideodetailsState();
}

class _VideodetailsState extends State<Videodetails> {
  late VideoPlayerController _controller;
  bool isFullscreen = false;
  final List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video['url']!)
      ..addListener(() {
        if (mounted && _controller.value.isInitialized) {
          setState(() {});
        }
      })
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.play();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFullscreen() {
    setState(() => isFullscreen = !isFullscreen);
  }

  void _skipForward() {
    if (!_controller.value.isInitialized) return;
    final newPos = _controller.value.position + const Duration(seconds: 10);
    _controller.seekTo(newPos < _controller.value.duration
        ? newPos
        : _controller.value.duration);
  }

  void _skipBackward() {
    if (!_controller.value.isInitialized) return;
    final newPos = _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(newPos > Duration.zero ? newPos : Duration.zero);
  }

  void _showCommentPopup() {
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: const Text("Add Comment"),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: "Write your comment here...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (commentController.text
                    .trim()
                    .isEmpty) return;
                setState(() {
                  comments.add({
                    'user': 'Guest',
                    'text': commentController.text.trim(),
                    'time': DateTime.now(),
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60);
    final s = duration.inSeconds.remainder(60);
    return [if (h > 0) twoDigits(h), twoDigits(m), twoDigits(s)].join(":");
  }

  String timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inSeconds < 60) return "${diff.inSeconds}s ago";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";
    return DateFormat('dd MMM yyyy').format(time);
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green.shade50,
            child: Icon(icon, color: Colors.green.shade800),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isFullscreen
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'اِيمَانٌ خَالِصٌ',
          style: GoogleFonts.scheherazadeNew(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.isInitialized
                ? _controller.value.aspectRatio
                : 16 / 9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _controller.value.isInitialized
                    ? ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  child: VideoPlayer(_controller),
                )
                    : const Center(child: CircularProgressIndicator()),
                if (_controller.value.isInitialized)
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                if (_controller.value.isInitialized)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Column(
                      children: [
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          colors: VideoProgressColors(
                            playedColor: Colors.green.shade700,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.replay_10,
                                  color: Colors.white),
                              onPressed: _skipBackward,
                            ),
                            IconButton(
                              icon: const Icon(Icons.forward_10,
                                  color: Colors.white),
                              onPressed: _skipForward,
                            ),
                            Text(
                              "${_formatDuration(_controller.value
                                  .position)} / ${_formatDuration(
                                  _controller.value.duration)}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: Icon(
                                isFullscreen
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                                color: Colors.white,
                              ),
                              onPressed: _toggleFullscreen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (!isFullscreen)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video['title']!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "By: ${widget.video['writer']} • ${widget
                          .video['duration']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _actionButton(
                            Icons.thumb_up_alt_outlined, "Like", () {}),
                        _actionButton(
                            Icons.thumb_down_alt_outlined, "Dislike", () {}),
                        _actionButton(
                            Icons.message, "Comment", _showCommentPopup),
                        _actionButton(Icons.download, "Download", () {}),
                        _actionButton(Icons.share, "Share", () {}),
                      ],
                    ),
                    const Divider(height: 30),
                    const Text(
                      "Comments",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final c = comments[index];
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const CircleAvatar(
                                child: Icon(Icons.person)),
                            title: Text(c['user']),
                            subtitle:
                            Text("${c['text']} • ${timeAgo(c['time'])}"),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 30),
                    // const Text(
                    //   "Related Videos",
                    //   style: TextStyle(
                    //       fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(height: 10),
                    // SizedBox(
                    //   height: 160,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 5,
                    //     itemBuilder: (context, index) =>
                    //         Container(
                    //           width: 200,
                    //           margin: const EdgeInsets.symmetric(horizontal: 8),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(15),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.black.withOpacity(0.1),
                    //                 blurRadius: 5,
                    //               ),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Expanded(
                    //                 child: ClipRRect(
                    //                   borderRadius: const BorderRadius.vertical(
                    //                       top: Radius.circular(15)),
                    //                   child: Image.asset(
                    //                     'assets/images/quran.png',
                    //                     fit: BoxFit.cover,
                    //                     width: double.infinity,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Text(
                    //                   "Related Video ${index + 1}",
                    //                   style: const TextStyle(
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
