import 'dart:async';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:qr_login_poc/__generated__/qr_login.req.gql.dart';
import 'package:qr_login_poc/core/client.dart';

class AuthRepository {
  Future<String?> loginReq(String deviceId) async {
    final client = await CustomClient.initializeClient(true);
    final completer = Completer<String?>();

    try {
      log("🔄 Starting subscription for deviceId: $deviceId");

      final subscription = client.request(GDeviceAuthReq((builder) {
        builder.vars.deviceId = deviceId;
      })).listen(
        (result) {
          log("✅ Received data: ${result.data}");

          if (result.hasErrors) {
            log("❌ GraphQL Errors: ${result.graphqlErrors}");
          }

          final token = result.data?.deviceAuth?.accessToken;
          if (token != null) {
            log("🔑 Access Token: $token");
            if (!completer.isCompleted) {
              completer.complete(token);
            }

            client.dispose(); // ✅ Dispose client
          }
        },
        onError: (e) {
          log("⚠️ Subscription error: $e");
          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },
      );

      return completer.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          log("⌛ Subscription timed out!");
          subscription.cancel();
          client.dispose();
          return null;
        },
      );
    } on Exception catch (e) {
      log("❌ Exception in loginReq: $e");
      rethrow;
    }
  }

  Future<bool> login(String deviceId) async {
    try {
      final client = await CustomClient.initializeClient();

      final res = await client.request(GaddDeviceReq((builder) {
        builder.vars.accessToken =
            "eyJhbGciOiJSUzI1NiIsImtpZCI6IkUyQjAwMUMzQjI4RkEyQkQyMzkyNTQ0MDdCNUVFM0VEMTA2MDI4NDEiLCJ4NXQiOiI0ckFCdzdLUG9yMGprbFJBZTE3ajdSQmdLRUUiLCJ0eXAiOiJhdCtqd3QifQ.eyJpc3MiOiJodHRwczovL2NwYW5lbC5hbHBoYS5lZ3doaXRlLm5ldC8iLCJleHAiOjE3MzkxNjU2MTEsImlhdCI6MTczOTE2MzgxMSwic2NvcGUiOiJ3cml0aW5ncyBzZWFyY2ggc3R1ZHljZW50ZXIgc3Vic2NyaXB0aW9ucyB1c2VyX2luZm8gbWVkaWEgb2ZmbGluZV9hY2Nlc3MiLCJqdGkiOiI0YTJmNTU0OS0yNTMzLTQyZjYtYmNhZi1iMDA4Yzg2NjI3OWIiLCJzdWIiOiI0MDMiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJrYWkuZW5lemh1QGdtYWlsLmNvbSIsIm9pX3Byc3QiOiJodEVrZkpVc2VNWDFzSHpUbnBSejMxZGk0MXdKM3ZXZCIsIm9pX2F1X2lkIjoiMDhkZDQxYmUtM2ZmYy00NzkwLTgzMzAtNzRhMjIyNjI3YjQ0IiwiY2xpZW50X2lkIjoiaHRFa2ZKVXNlTVgxc0h6VG5wUnozMWRpNDF3SjN2V2QiLCJvaV90a25faWQiOiIwOGRkNDk5MC00M2E1LTRjZGMtOGI3OC0zY2EyOTQzNTRhZjYifQ.fBGpzdH-6xxcyMPiRkwXTCYA0eMFtvqzzk5Z5hs7CcDTKDcYlVJ18xzx6jkNTxBgPVGE3DohE7_petaG_sZjh4GXyS7qrrphKtqwvg9GqM0TPqMZQi6O69eCHdCGBC-cV5nftUggNAombookv8JTIUmJ4YeettpBaL4aQiaSNQK0swmfKn1GwiZmE-RsT54TQc2LrqUcm8wTpnJ0rOOqh6DGCNk79ansMLgO19lZ8pdO2v18wYHvPsfj1DfrNwKxWvBUmZWl0okRQ7UAkb2F9Y0QbvsxRcQ3jRwzRN9mKgNnTh5qasE18GCT1XBhJUBnfgvukHUrKZ-NriDmViyKMg";
        builder.vars.refreshToken =
            "eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiJFMkIwMDFDM0IyOEZBMkJEMjM5MjU0NDA3QjVFRTNFRDEwNjAyODQxIiwidHlwIjoib2lfcmVmdCtqd3QiLCJjdHkiOiJKV1QifQ.Y2jpkjqNpfdaJw8_9kZJxZiW8IOu8Qbem1ViSXud72Nc7d-SxCcrEANVfTHniT7rcfmF5bXTSw7vHlGU9mG8OVdSg3tRpZkWWEq70TL-dqq9dxPhLCeoO78iGgNy7P9qWqXOJIYiDlbAU_yh6rWqLTX-xyQhQfkc1kCZNd78H_lBFoeZxoWvIXzFzGNfDSTeoJBfPKphgF0n6QVhNNLsy81Om5OJ17_qNEYr4gSwE7kHCJZgixB3KLE_eo25rP3908uN4COy-AJJglr1Qe3MAdI5lAZqs9UCzzej-SXcyyjdzyZTFKZGh5cMjvEuJ8zwWDealjuQJo0bztP743CvNQ.h5dIPy0LAvNvuQZjUCnJng.fyhMQRJXoMHpC3FJ-BkHd2mK4Dbh2GrmdnryMLa8d392Xh2rXTrZr7I8AYnNftGZLCkop35Ycl9wgeEet1BCkHVO2MyK6TK4ULEECSegZGbRIxmgSuL7fveb3AuvGw3o4e3wklh8Hj6R7DnCZqCc-fDnwyeSGuIPyfMb9IrR6pmrPQwzzTtdBJpQgkF8Ij4MQVN7v7ZvVxqU4yvotiegAaQDsfT-scW0I7PLp9E_3ZyOwLNyAfseBa4cE8IHG6mp13OedjyO_BhdMhdUUVa6yzVH9o3DbGZ5JlUHjo0prnxEQcyanjbyiZa6JhYj2eyVOGdAmgMTvoEyTbBHqhS8swYd-5C2FK0ifd0eaW6PZ18q9Wal521NfDUmF1XHmIoQ1fyW6qZAI1dtc5EbtgIF2TMbBI62Fww9H1VB2nhmUoIuM7dDHT13hMTT65dAYfNiOIldB8ccd6m6yhEBtF4Ktm0GQEs3u80DlH7iCERvIYUKWkgbI-XPcXGS-77m9tDL2461biQgmTeutQUX6IISIyRNDrCnRzYfMtRhcwPSy696fc3E7iwBAXUr3l40HXo7-BUOvj_gwfPdDifVt6H-1Dn3J9KSWqEbDeCfe-aDF7zuk-0oQUhSHUFJa37wCdYTjQ1d_5mrK1lYW4QwnQ9CkP5uaFMlQLExYUu2XvQts05blqjwG0QjsLFEBK82Djr-8UxVNT8wwjJwTGm1My37wl9B-uuU9FMvTIpMeo5GlgPcCESbP9pdetj9YdZOy6Ntevj-QQ0vfPcpPmxYcVS1cea8nBmC26UaM8jQptcxGxL44DKEfD1Zo17SHEuyQHigCLh2mAd2F9SfJzMq4NdeFJBNsLg1jZ77dikllH8H2qFQSr2RQHgVr2rOuOWd2aUW8jagaMC9VcZ27k4-fHv4LGgIZ6RwMUNfE4dWRmPPyTqHRs47RuQ8gmRXHKUGSYcVJBV0L2SZvd5AED1hZ7iqeezoRZkz_qn2RWJLwusxnBW0nIRwLnYpPnuKJQZgm5t0hLzm_lCOku0-ZTz7i8PLhEoGsPz1onuADeU_uPTU9EhXSKS3B1PQ3cWa6dbQGWRWi-pkGqvF9lOWRf3OGSsIY8VQ8IygAehLYr4_jT_gU1hdXt0yDCM0aB2J_haXnFOqILPlZ6pRT5fPeWEjQREI07oKRvmNEzvqL931XpxeKpaCUIACgaHQFpXOLuSzxp_m3OK4PmuNK3OfUeFWmnqkxhhsedK_cMwKIu6Hmup91ii8NC7Q7OPVX8BWmUgXNwZo4up8m1NFcr7TohrtQHaLDdQ2gN73aybHEsUnRm-i7LxxvXexR4zqz43NktdozY2kb30gqpZCPgbcD1UQ-VLRqrry9fsMAzGxeBkVRJ-YF0JTTzD-uKUvBRPjaejVtCbyMW5PAgzRJMtxpH-kEU5w-PjGDjeyEibcuA8gP5NpvQY.G3pHTsdud3M2jkGLiZVZMa9MxPti8gdlGLaop2DBtzY";
        builder.vars.username = null;
        builder.vars.deviceId = deviceId;
      })).map((result) {
        if (result.hasErrors) {
          throwIf(result.linkException != null, result.linkException!);
          throwIf(result.graphqlErrors != null,
              Exception(result.graphqlErrors?.first.message));
        }
        return result.data;
      }).first;

      if (res?.addDevice.openIddictResponseDto?.deviceId != null) {
        log("✅ Login successful");
        return true;
      } else {
        log("❌ Login failed");
        return false;
      }
    } catch (e) {
      log("❌ Exception in login: $e");
      rethrow;
    }
  }
}
