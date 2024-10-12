import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart' as plugin;

class LocalIp {
  static Future<List<String>> getIp() async {
    final info = plugin.NetworkInfo();
    String? ip;
    try {
      ip = await info.getWifiIP();
    } catch (e) {
      // _logger.warning('Failed to get wifi IP', e);
    }

    List<String> nativeResult = [];
    if (!kIsWeb) {
      try {
        // fallback with dart:io NetworkInterface
        final result = (await NetworkInterface.list())
            .map((networkInterface) => networkInterface.addresses)
            .expand((ip) => ip);
        nativeResult = result
            .where((ip) => ip.type == InternetAddressType.IPv4)
            .map((address) => address.address)
            .toList();
      } catch (_) {
        // _logger.info('Failed to get IP from dart:io', e, st);
      }
    }

    final addresses = rankIpAddresses(nativeResult, ip);
    // _logger.info('Network state: $addresses');
    return addresses;
  }
}

List<String> rankIpAddresses(
    List<String> nativeResult, String? thirdPartyResult) {
  if (thirdPartyResult == null) {
    // only take the list
    return nativeResult._rankIpAddresses(null);
  } else if (nativeResult.isEmpty) {
    // only take the first IP from third party library
    return [thirdPartyResult];
  } else if (thirdPartyResult.endsWith('.1')) {
    // merge
    return {thirdPartyResult, ...nativeResult}.toList()._rankIpAddresses(null);
  } else {
    // merge but prefer result from third party library
    return {thirdPartyResult, ...nativeResult}
        .toList()
        ._rankIpAddresses(thirdPartyResult);
  }
}

/// Sorts Ip addresses with first being the most likely primary local address
/// Currently,
/// - sorts ending with ".1" last
/// - primary is always first
extension ListIpExt on List<String> {
  List<String> _rankIpAddresses(String? primary) {
    return sorted((a, b) {
      int scoreA = a == primary ? 10 : (a.endsWith('.1') ? 0 : 1);
      int scoreB = b == primary ? 10 : (b.endsWith('.1') ? 0 : 1);
      return scoreB.compareTo(scoreA);
    });
  }
}
