import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:nabandeja/service/util.dart';
import 'package:signalr_netcore/signalr_client.dart';

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
      String companyId, void Function(SocketMsg message) callback) async {
    await _initialize();
    await _callInvoke(companyId);

    hubConnection.on("ReceiveUpdateOrderStatusKdsAsync", (arguments) {
      try {
        SocketMsg message = Util.convertObjectTo(arguments);
        callback(message);
        print(message.kdsMessageType);
      } catch (error) {
        print(error);
      }
    });
  }
}
/*
void main(List<String> arguments) async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  final hubProtLogger = Logger("SignalR - hub");
  final transportProtLogger = Logger("SignalR - transport");
  final httpOptions = HttpConnectionOptions(
    logger: transportProtLogger,
    skipNegotiation: true,
    transport: HttpTransportType.WebSockets,
  );

  final hubConnection = HubConnectionBuilder()
      .withUrl(
        "https://stg.thexpos.net/signalrserver/poskds",
        options: httpOptions,
      )
      .configureLogging(hubProtLogger)
      .build();

  await hubConnection.start();

  final result = await hubConnection.invoke("AddToGroupAsync", args: <Object>[
    "KDS_ff31e5b7-25b1-4849-865f-8546f21b20a5",
  ]).catchError((err) {
    print(err);
  });

  hubConnection.on("ReceiveUpdateOrderStatusKdsAsync", (arguments) {
    print(arguments);
  });

  Logger.root.log(Level.INFO, "Result: '$result");



        _notificationService.showLocalNotification(
        CustomNotification(
          id: 10,
          title: "Está na mesa pessoal...",
          body: "",
          payload: "",
        ),
      );
}*/
