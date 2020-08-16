import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musixmatch/models/lyrics.g.dart';

import 'package:musixmatch/musixmatch.dart';

class MockApi extends Mock implements MusixmatchApi {}
void main() {
  
  test('Gets a song', () async {
    MusixmatchApi api = MusixmatchApi('1ae20278a4068889effe93f46beabbad');
    var mock = MockApi();
    //when(mock.getLyricsRaw('Back in Black', 'AC/DS')).thenAnswer((realInvocation) async => Future.value(LyricSong(message: Message.)))

  });
}
