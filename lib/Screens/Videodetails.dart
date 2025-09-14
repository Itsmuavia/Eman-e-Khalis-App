import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';

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
  Uint8List? thumbnail;
  Duration? _hoverPosition;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video['url']!)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        _controller.play();
      });
    _controller.addListener(() {
      if (mounted) setState(() {});
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
    _controller.seekTo(newPos < _controller.value.duration ? newPos : _controller.value.duration);
  }

  void _skipBackward() {
    if (!_controller.value.isInitialized) return;
    final newPos = _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(newPos > Duration.zero ? newPos : Duration.zero);
  }

  Future<void> _generateThumbnail(Duration position) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: widget.video['url']!,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 25,
      timeMs: position.inMilliseconds,
    );
    setState(() => thumbnail = uint8list);
  }

  void _showCommentPopup() {
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Add Comment"),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(
            hintText: "Write your comment here...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (commentController.text.trim().isEmpty) return;
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
      ),
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
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: Colors.blue.shade700),
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
      backgroundColor: Colors.blue.shade50,
      appBar: isFullscreen
          ? null
          : AppBar(
        backgroundColor: Colors.blue.shade200,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        elevation: 0,
        title: Text(
          'اِيمَانٌ خَالِص',
          style: GoogleFonts.scheherazadeNew(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.isInitialized ? _controller.value.aspectRatio : 16 / 9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _controller.value.isInitialized
                    ? ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
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
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onHorizontalDragUpdate: (details) async {
                            final box = context.findRenderObject() as RenderBox;
                            final localDx = details.localPosition.dx.clamp(0, box.size.width);
                            final relative = localDx / box.size.width;
                            final seekPos = _controller.value.duration * relative;
                            _controller.seekTo(seekPos);
                            await _generateThumbnail(seekPos);
                            setState(() => _hoverPosition = seekPos);
                          },
                          child: Stack(
                            children: [
                              VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                  playedColor: Colors.blue.shade700,
                                  backgroundColor: Colors.white30,
                                ),
                              ),
                              if (thumbnail != null && _hoverPosition != null)
                                Positioned(
                                  bottom: 30,
                                  left: MediaQuery.of(context).size.width *
                                      (_hoverPosition!.inMilliseconds / _controller.value.duration.inMilliseconds) -
                                      40,
                                  child: Container(
                                    width: 80,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                            image: MemoryImage(thumbnail!), fit: BoxFit.cover)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white),
                              onPressed: () => setState(() {
                                _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              }),
                            ),
                            IconButton(icon: const Icon(Icons.replay_10, color: Colors.white), onPressed: _skipBackward),
                            IconButton(icon: const Icon(Icons.forward_10, color: Colors.white), onPressed: _skipForward),
                            Text(
                              "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            IconButton(icon: Icon(isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white), onPressed: _toggleFullscreen),
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
              child: Container(
                padding: const EdgeInsets.all(14),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.video['title']!,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(
                        "By: ${widget.video['writer']} • ${widget.video['duration']}",
                        style: TextStyle(color: Colors.blueGrey.shade700),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _actionButton(Icons.thumb_up_alt_outlined, "Like", () {}),
                          _actionButton(Icons.thumb_down_alt_outlined, "Dislike", () {}),
                          _actionButton(Icons.message, "Comment", _showCommentPopup),
                          _actionButton(Icons.download, "Download", (){}),
                          _actionButton(Icons.share, "Share", () {}),
                        ],
                      ),
                      const Divider(height: 30, color: Colors.blueGrey),
                      const Text("Comments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (comments.isEmpty)
                        Center(child: Text("No comments yet", style: TextStyle(color: Colors.blueGrey.shade400))),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final c = comments[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(c['user']),
                              subtitle: Text("${c['text']} • ${timeAgo(c['time'])}"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
