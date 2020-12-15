import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({@required String url, @required String method}) async {
    client.post(url);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('Should ansure values', () async {
      //Arrange
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();
      await sut.request(url: url, method: 'post');
      verify(client.post(url));
    });
  });
}
