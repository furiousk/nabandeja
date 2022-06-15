import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:nabandeja/service/util.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../model/custom_notification.dart';
import '../model/socket_msg.dart';
import 'notification_service.dart';

class IoSocket {
  HubConnection hubConnection = HubConnectionBuilder()
      .withUrl("https://stg.thexpos.net/signalrserver/poskds",
          options: HttpConnectionOptions(
            logger: Logger("SignalR - transport"),
            skipNegotiation: true,
            transport: HttpTransportType.WebSockets,
          ))
      .withAutomaticReconnect()
      .configureLogging(Logger("SignalR - hub"))
      .build();

  final NotificationService _notificationService;

  IoSocket(this._notificationService);

  T? cast<T>(x) => x is T ? x : null;

  Future<void> _initialize() async {
    Logger.root.level = Level.ALL;
    if (hubConnection.state == HubConnectionState.Disconnected) {
      Logger.root.onRecord.listen((LogRecord rec) {
        if (kDebugMode) {
          print('${rec.level.name}: ${rec.time}: ${rec.message}');
        }
      });
      await hubConnection.start();
    }
  }

  Future<void> _callInvoke(String companyId) async {
    var result = await hubConnection.invoke("AddToGroupAsync", args: <Object>[
      "KDS_$companyId",
    ]).catchError((err) {
      if (kDebugMode) {
        print(err);
      }
    });
    Logger.root.log(Level.INFO, "Result: '$result");
  }

  Future<void> onMessage(
      String companyId, void Function(Object message) callback) async {
    await _initialize();
    await _callInvoke(companyId);

    hubConnection.on("ReceiveUpdateOrderStatusKdsAsync", (arguments) {
      try {
        SocketMsg message = Util.convertObjectTo(arguments);
        callback(message);
        if(message.kdsList?[0].status == 2) {
          _notificationService.showLocalNotification(
            CustomNotification(
              id: 10,
              title: "Está na mesa pessoal...",
              body: "Pedido Pronto!",
              payload: "",
            ),
          );
        }
      } catch (error) {
        print(error);
      }
    });

    hubConnection.on("ReceiveAddOrderKdsAsync", (arguments) {
      try {
        callback({});
      } catch (error) {
        print(error);
      }
    });

    hubConnection.on("ReceiveCancelOrderKdsAsync", (arguments) {
      try {
        callback({});
      } catch (error) {
        print(error);
      }
    });
  }
}
