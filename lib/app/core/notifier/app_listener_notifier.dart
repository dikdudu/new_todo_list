import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:todo_list/app/core/notifier/app_change_notifier.dart';
import 'package:todo_list/app/core/ui/app_messages.dart';

class AppListenerNotifier {
  AppChangeNotifier changeNotifier;

  AppListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallBack successCallBack,
    EverVoidCallBack? everCallBack,
    ErrorVoidCallBack? errorCallBack,
  }) {
    changeNotifier.addListener(() {
      if (everCallBack != null) {
        everCallBack(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallBack != null) {
          errorCallBack(changeNotifier, this);
        }
        AppMessages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        successCallBack(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallBack = void Function(AppChangeNotifier notifier, AppListenerNotifier listenerInstance);

typedef ErrorVoidCallBack = void Function(AppChangeNotifier notifier, AppListenerNotifier listenerInstance);

typedef EverVoidCallBack = void Function(AppChangeNotifier notifier, AppListenerNotifier listenerInstance);
