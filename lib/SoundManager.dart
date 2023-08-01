import 'MySharedPreference.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundManager{
  static void playCorrect() async {
    bool soundable = await MySharedPreference.getPrefsSound();

    if(soundable){
      AudioCache audioCache = AudioCache();
      audioCache.play('sounds/correct.mp3');
    }
  }

  static void playSelect() async {
    bool soundable = await MySharedPreference.getPrefsSound();

    if(soundable){
      AudioCache audioCache = AudioCache();
      audioCache.play('sounds/select.wav');
    }
  }

  static void playWrong() async {
    bool soundable = await MySharedPreference.getPrefsSound();

    if(soundable){
      AudioCache audioCache = AudioCache();
      audioCache.play('sounds/wrong.mp3');
    }
  }

  static void playArchive() async {
    bool soundable = await MySharedPreference.getPrefsSound();

    if(soundable){
      AudioCache audioCache = AudioCache();
      audioCache.play('sounds/archive.mp3');
    }
  }
}