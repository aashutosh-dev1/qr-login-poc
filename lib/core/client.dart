import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomClient {
  late Client cl;

  static Future<Client> initializeClient([bool isSubscription = false]) async {
    await Hive.initFlutter();

    final box = await Hive.openBox("graphql");

    final store = HiveStore(box);

    final cache = Cache(store: store);

    final dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Authorization"] =
            "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkUyQjAwMUMzQjI4RkEyQkQyMzkyNTQ0MDdCNUVFM0VEMTA2MDI4NDEiLCJ4NXQiOiI0ckFCdzdLUG9yMGprbFJBZTE3ajdSQmdLRUUiLCJ0eXAiOiJhdCtqd3QifQ.eyJpc3MiOiJodHRwczovL2NwYW5lbC5hbHBoYS5lZ3doaXRlLm5ldC8iLCJleHAiOjE3MzkxNjU2MTEsImlhdCI6MTczOTE2MzgxMSwic2NvcGUiOiJ3cml0aW5ncyBzZWFyY2ggc3R1ZHljZW50ZXIgc3Vic2NyaXB0aW9ucyB1c2VyX2luZm8gbWVkaWEgb2ZmbGluZV9hY2Nlc3MiLCJqdGkiOiI0YTJmNTU0OS0yNTMzLTQyZjYtYmNhZi1iMDA4Yzg2NjI3OWIiLCJzdWIiOiI0MDMiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJrYWkuZW5lemh1QGdtYWlsLmNvbSIsIm9pX3Byc3QiOiJodEVrZkpVc2VNWDFzSHpUbnBSejMxZGk0MXdKM3ZXZCIsIm9pX2F1X2lkIjoiMDhkZDQxYmUtM2ZmYy00NzkwLTgzMzAtNzRhMjIyNjI3YjQ0IiwiY2xpZW50X2lkIjoiaHRFa2ZKVXNlTVgxc0h6VG5wUnozMWRpNDF3SjN2V2QiLCJvaV90a25faWQiOiIwOGRkNDk5MC00M2E1LTRjZGMtOGI3OC0zY2EyOTQzNTRhZjYifQ.fBGpzdH-6xxcyMPiRkwXTCYA0eMFtvqzzk5Z5hs7CcDTKDcYlVJ18xzx6jkNTxBgPVGE3DohE7_petaG_sZjh4GXyS7qrrphKtqwvg9GqM0TPqMZQi6O69eCHdCGBC-cV5nftUggNAombookv8JTIUmJ4YeettpBaL4aQiaSNQK0swmfKn1GwiZmE-RsT54TQc2LrqUcm8wTpnJ0rOOqh6DGCNk79ansMLgO19lZ8pdO2v18wYHvPsfj1DfrNwKxWvBUmZWl0okRQ7UAkb2F9Y0QbvsxRcQ3jRwzRN9mKgNnTh5qasE18GCT1XBhJUBnfgvukHUrKZ-NriDmViyKMg";
        return handler.next(options);
      },
    ));

    final link = isSubscription
        ? TransportWebSocketLink(
            TransportWsClientOptions(
              socketMaker: WebSocketMaker.url(
                  () => 'ws://cpanel.alpha.egwhite.net/graphql'),
            ),
          )
        : DioLink(
            "https://cpanel.alpha.egwhite.net/graphql/",
            client: dio,
          );

    //   Link.split(
    //   (request) => isSubscription,
    //   TransportWebSocketLink(
    //     TransportWsClientOptions(
    //       socketMaker:
    //           WebSocketMaker.url(() => 'ws://cpanel.alpha.egwhite.net/graphql'),
    //     ),
    //   ),
    //   DioLink(
    //     "https://cpanel.alpha.egwhite.net/graphql/",
    //     client: dio,
    //   ),
    // );

    final client = Client(
      link: link,
      cache: cache,
    );

    return client;
  }
}
