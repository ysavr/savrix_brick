import 'dart:convert';
import 'dart:developer';

import 'package:{{project_name.snakeCase()}}/core/shared_preferences/shared_preference_service.dart';
import 'package:{{project_name.snakeCase()}}/core/static_constants/app_constant.dart';

class JWTExpirationUtils {

  /// Make the current JWT token expired by modifying its expiration time
  static String? makeTokenExpired(String? currentToken) {
    if (currentToken == null || currentToken.isEmpty) {
      log('No current token to expire');
      return null;
    }

    try {
      final parts = currentToken.split('.');
      if (parts.length != 3) {
        log('Invalid JWT format - not 3 parts');
        return null;
      }

      // Decode the payload (second part)
      final header = parts[0];
      final payload = parts[1];
      final signature = parts[2];

      // Decode payload
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = json.decode(decodedPayload) as Map<String, dynamic>;

      log('Original payload: $payloadMap');

      // Modify the expiration time to be in the past
      // Set expiration to 1 hour ago
      final expiredTime = DateTime.now().subtract(Duration(hours: 1));
      final expiredTimestamp = expiredTime.millisecondsSinceEpoch ~/ 1000;

      // Update the exp field
      payloadMap['exp'] = expiredTimestamp;

      log('Modified payload with exp: ${payloadMap['exp']} (${DateTime.fromMillisecondsSinceEpoch(expiredTimestamp * 1000)})');

      // Encode the modified payload
      final modifiedPayloadJson = json.encode(payloadMap);
      final modifiedPayloadBytes = utf8.encode(modifiedPayloadJson);
      final modifiedPayloadBase64 = base64Url.encode(modifiedPayloadBytes);

      // Create new token with modified payload
      // Note: The signature will be invalid, but that's fine for testing
      // because the server will reject it due to expiration before checking signature
      final expiredToken = '$header.$modifiedPayloadBase64.$signature';

      log('Created expired token');
      return expiredToken;

    } catch (e) {
      log('Error creating expired token: $e');
      return null;
    }
  }

  /// Make token expired and update SharedPreferences
  static Future<bool> expireCurrentToken(SharedPreferenceService sharedPreferences) async {
    final currentToken = await sharedPreferences.getString(AppConstant.prefAccessToken);

    if (currentToken == null) {
      log('❌ No current access token found');
      return false;
    }

    log('🔍 Current token: ${currentToken.substring(0, 50)}...');

    final expiredToken = makeTokenExpired(currentToken);

    if (expiredToken != null) {
      sharedPreferences.writeValue(AppConstant.prefAccessToken, expiredToken);
      log('✅ Token expired successfully');
      log('🕐 New expired token: ${expiredToken.substring(0, 50)}...');
      return true;
    } else {
      log('❌ Failed to expire token');
      return false;
    }
  }

  /// Create an expired token with specific expiration time
  static String? createExpiredTokenWithTime(String? currentToken, DateTime expirationTime) {    
    if (currentToken == null || currentToken.isEmpty) return null;

    try {
      final parts = currentToken.split('.');
      if (parts.length != 3) return null;

      final header = parts[0];
      final payload = parts[1];
      final signature = parts[2];

      // Decode payload
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = json.decode(decodedPayload) as Map<String, dynamic>;

      // Set custom expiration time
      final customTimestamp = expirationTime.millisecondsSinceEpoch ~/ 1000;
      payloadMap['exp'] = customTimestamp;

      // Encode modified payload
      final modifiedPayloadJson = json.encode(payloadMap);
      final modifiedPayloadBytes = utf8.encode(modifiedPayloadJson);
      final modifiedPayloadBase64 = base64Url.encode(modifiedPayloadBytes);

      return '$header.$modifiedPayloadBase64.$signature';

    } catch (e) {
      log('Error creating token with custom expiration: $e');
      return null;
    }
  }

  /// Get token expiration info for debugging
  static Map<String, dynamic>? getTokenInfo(String? token) {
    if (token == null || token.isEmpty) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = json.decode(decodedPayload) as Map<String, dynamic>;

      final exp = payloadMap['exp'] as int?;
      final iat = payloadMap['iat'] as int?; // issued at
      final sub = payloadMap['sub'] as String?; // subject

      if (exp != null) {
        final expirationTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        final now = DateTime.now();
        final isExpired = expirationTime.isBefore(now);
        final timeUntilExpiration = expirationTime.difference(now);

        return {
          'exp_timestamp': exp,
          'exp_datetime': expirationTime.toString(),
          'iat_timestamp': iat,
          'iat_datetime': iat != null ? DateTime.fromMillisecondsSinceEpoch(iat * 1000).toString() : null,
          'subject': sub,
          'is_expired': isExpired,
          'time_until_expiration': timeUntilExpiration.toString(),
          'expires_in_minutes': timeUntilExpiration.inMinutes,
          'full_payload': payloadMap,
        };
      }

      return payloadMap;
    } catch (e) {
      log('Error getting token info: $e');
      return null;
    }
  }

  /// Test different expiration scenarios
  static void runExpirationTests(SharedPreferenceService sharedPreferences) async{
    final currentToken = await sharedPreferences.getString(AppConstant.prefAccessToken);

    if (currentToken == null) {
      log('❌ No token available for testing');
      return;
    }

    log('🧪 Starting JWT Expiration Tests');
    log('📋 Current token info:');
    final currentInfo = getTokenInfo(currentToken);
    log('$currentInfo');

    // Test 1: Token expired 1 hour ago
    log('\n🧪 Test 1: Token expired 1 hour ago');
    final expired1h = createExpiredTokenWithTime(
        currentToken,
        DateTime.now().subtract(Duration(hours: 1))
    );
    if (expired1h != null) {
      log('✅ Created token expired 1 hour ago');
      final info1h = getTokenInfo(expired1h);
      log('📋 Expired token info: $info1h');
    }

    // Test 2: Token expired 1 minute ago
    log('\n🧪 Test 2: Token expired 1 minute ago');
    final expired1m = createExpiredTokenWithTime(
        currentToken,
        DateTime.now().subtract(Duration(minutes: 1))
    );
    if (expired1m != null) {
      log('✅ Created token expired 1 minute ago');
      final info1m = getTokenInfo(expired1m);
      log('📋 Expired token info: $info1m');
    }

    // Test 3: Token expires in 30 seconds (for testing "expiring soon" logic)
    log('\n🧪 Test 3: Token expires in 30 seconds');
    final expiringSoon = createExpiredTokenWithTime(
        currentToken,
        DateTime.now().add(Duration(seconds: 30))
    );
    if (expiringSoon != null) {
      log('✅ Created token expiring in 30 seconds');
      final infoSoon = getTokenInfo(expiringSoon);
      log('📋 Expiring soon token info: $infoSoon');
    }
  }
}