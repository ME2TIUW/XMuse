import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xmuse/viewmodels/music/music_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    //fetch music as soon as the screen is built, only if the list is empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Perform your action here
      final musicVM = context.read<MusicViewModel>();
      if (musicVM.songs.isEmpty) {
        musicVM.fetchChristmasMusic();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MusicViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Christmas Hits')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          // ignore: unnecessary_null_comparison
          : (viewModel.errorMessage != null && viewModel.songs.isEmpty)
          // 1. Only show the error if we actually have NO songs to show
          ? Center(child: Text(viewModel.errorMessage))
          : viewModel.songs.isEmpty
          // 2. Handle the "Empty State" gracefully
          ? const Center(child: Text("No Christmas songs found!"))
          // 3. Success State
          : ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                final song = viewModel.songs[index];
                return ListTile(
                  leading: Image.network(
                    song.artworkUrl,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Icon(Icons.music_note),
                  ),
                  title: Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(song.artist),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                    onPressed: () {
                      // TODO: Wire up AudioPlayer here
                    },
                  ),
                );
              },
            ),
    );
  }
}
