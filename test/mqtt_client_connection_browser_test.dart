/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 24/01/2020
 * Copyright :  S.Hamblett
 */

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:test/test.dart';

@TestOn('browser')
void main() {
  const mockBrokerAddressWsNoScheme = 'localhost.com';
  const mockBrokerAddressWsBad = '://localhost.com';
  const testClientId = 'syncMqttTests';

  group('Connection parameters', () {
    test('Invalid URL', () async {
      try {
        final client = MqttBrowserClient(mockBrokerAddressWsBad, testClientId);
        client.logging(on: true);
        await client.connect();
      } on Exception catch (e) {
        expect(e is NoConnectionException, true);
        expect(
            e.toString(),
            'mqtt-client::NoConnectionException: '
            'MqttBrowserWsConnection::The URI supplied for the WS connection is not valid - ://localhost.com');
      }
    });

    test('Invalid URL - bad scheme', () async {
      try {
        final client =
            MqttBrowserClient(mockBrokerAddressWsNoScheme, testClientId);
        client.logging(on: true);
        await client.connect();
      } on Exception catch (e) {
        expect(e is NoConnectionException, true);
        expect(
            e.toString(),
            'mqtt-client::NoConnectionException: '
            'MqttBrowserWsConnection::The URI supplied for the WS has an incorrect scheme - $mockBrokerAddressWsNoScheme');
      }
    });
  });
}
