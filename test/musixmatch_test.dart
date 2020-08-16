import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musixmatch/models/track.g.dart';

import 'package:musixmatch/musixmatch.dart';

class MockApi extends Mock implements MusixmatchApi {}

void main() {
  test('get song call', () async {
    var mock = MockApi();
    var expectedValue = TrackData(trackName: 'Hello');
    when(mock.getTrack('Hello', 'Adelle'))
        .thenAnswer((realInvocation) async => Future.value(expectedValue));

    expect(await mock.getTrack('Hello', 'Adelle'), expectedValue);
  });

  test('search song call', () async {
    var mock = MockApi();
    var expectedValue = [TrackData(trackName: 'Hello')];
    when(mock.searchTrack('Hello', 'Adelle'))
        .thenAnswer((realInvocation) async => Future.value(expectedValue));

    expect(await mock.searchTrack('Hello', 'Adelle'), expectedValue);
  });

  test('error 404 call', () async {
    var mock = MockApi();
    when(mock.getTrackRaw('Contry roads, take me home', 'John Deniver'))
        .thenAnswer((realInvocation) async => Future.value(TrackDataRaw(message: Message(header: Header(statusCode: 404)))));

    expect(await mock.getTrackRaw('Contry roads, take me home', 'John Deniver'), throwsException);
  });
}
