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
          setState(() {}); // Timeline ko sync rakhne ke liye
        }
      })
      ..initialize().then((_) {
        if (mounted) {
          setState(() {}); // Video initialize hone ke baad rebuild
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
    setState(() {
      isFullscreen = !isFullscreen;
    });
  }

  void _skipForward() {
    if (!_controller.value.isInitialized) return;
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(
      newPosition < _controller.value.duration
          ? newPosition
          : _controller.value.duration,
    );
  }

  void _skipBackward() {
    if (!_controller.value.isInitialized) return;
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    _controller.seekTo(
      newPosition > Duration.zero ? newPosition : Duration.zero,
    );
  }

  void _showCommentPopup() {
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [
      if (hours > 0) twoDigits(hours),
      twoDigits(minutes),
      twoDigits(seconds),
    ].join(":");
  }

  String timeAgo(DateTime commentTime) {
    final diff = DateTime.now().difference(commentTime);
    if (diff.inSeconds < 60) return "${diff.inSeconds}s ago";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";
    return DateFormat('dd MMM yyyy').format(commentTime);
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green.shade50,
          child: IconButton(
            icon: Icon(icon, color: Colors.green.shade800),
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isFullscreen
          ? null
          : AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: const Color(0xFF006A4E),
        title: Text(
          'اِيمَانٌ خَالِصٌ',
          style: GoogleFonts.scheherazadeNew(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
                    ? VideoPlayer(_controller)
                    : const Center(child: CircularProgressIndicator()),
                if (_controller.value.isInitialized)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
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
                              "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video['title']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By: ${widget.video['writer']} • ${widget.video['duration']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _actionButton(
                            Icons.thumb_up_alt_outlined, "Like", () {}),
                        _actionButton(
                            Icons.thumb_down_alt_outlined, "Dislike", () {}),
                        _actionButton(Icons.message, "Comment", _showCommentPopup),
                        _actionButton(Icons.download, "Download", () {}),
                        _actionButton(Icons.share, "Share", () {}),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final c = comments[index];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(c['user']),
                          subtitle:
                          Text("${c['text']} • ${timeAgo(c['time'])}"),
                        );
                      },
                    ),
                    // const Divider(),
                    // const Text(
                    //   "Related Videos",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // SizedBox(
                    //   height: 160,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 5,
                    //     itemBuilder: (context, index) => Container(
                    //       width: 200,
                    //       margin: const EdgeInsets.symmetric(horizontal: 8),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(15),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black.withOpacity(0.1),
                    //             blurRadius: 5,
                    //           ),
                    //         ],
                    //       ),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Expanded(
                    //             child: ClipRRect(
                    //               borderRadius: const BorderRadius.vertical(
                    //                 top: Radius.circular(15),
                    //               ),
                    //               child: Image.asset(
                    //                 'assets/images/quran.png',
                    //                 fit: BoxFit.cover,
                    //                 width: double.infinity,
                    //               ),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //               "Related Video ${index + 1}",
                    //               style: const TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
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
