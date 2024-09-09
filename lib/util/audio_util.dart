import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _player.onPlayerStateChanged.listen((state) {
      playbackState.add(playbackStateFromPlayerState(state));
    });
  }

  @override
  Future<void> play() async {
    // Play method must be overridden but no URL passed directly here
    // Just an example of starting playback
    await _player.resume();
  }

  Future<void> playUrl(String url) async {
    // Set the audio URL and start playback
    await _player.play(AssetSource(url)); // Updated for audioplayers API
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }
}

PlaybackState playbackStateFromPlayerState(PlayerState state) {
  return PlaybackState(
    controls: [MediaControl.stop],
    playing: state == PlayerState.playing, // Adjusting for audioplayers API
    processingState: AudioProcessingState
        .idle, // Using a default state as audioplayers doesn't have this
  );
}
