import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/page_route.dart';
import '../models/menu_pages_info.dart';
import '../models/parent_model.dart';
import '../models/response_model.dart';
import '../ui/components/popup.dart';
import '../ui/components/toast.dart';

class NavigationState extends ChangeNotifier {
  NavigationState({required String initPageName}) {
    _init(initPageName);
  }

  void _init(String initPageName) {
    _menuPagesInfo.firstWhere((MenuPageInfo info) => info.name == initPageName).isActive = true;
    Future<void>.delayed(const Duration(seconds: 2), () => navigatePushReplace(CustomPageRoute.loginRoute));
  }

  final Map<String, Widget> _pages = createMainPages();
  Map<String, Widget> get pages => _pages;
  final List<MenuPageInfo> _menuPagesInfo = menuPages;
   List<MenuPageInfo> get menuPagesInfo => _menuPagesInfo;
  List<String> _pageRoutes = <String>[CustomPageRoute.splashRoute];
  List<String> get pageRoutes => _pageRoutes;

  void menuPageChange(String route) {
    if (_menuPagesInfo.map((MenuPageInfo e) => e.name).contains(route)) {
      for (final MenuPageInfo info in _menuPagesInfo) {
        info.isActive = false;
      }
      final int index = _menuPagesInfo.indexWhere((MenuPageInfo i) => i.name == route);
      _menuPagesInfo[index].isActive = true;
      controller.jumpToPage(index);
    }
    notifyListeners();
  }

  List<Widget> get buildActivePages {
    final List<Widget> activePages = <Widget>[];
    for (final String pageRoute in _pageRoutes) {
      activePages.add(_pages[pageRoute]!);
    }
    return activePages;
  }

  void navigatePush(String route) {
    _pageRoutes.add(route);
    notifyListeners();
  }

  void navigatePop() {
    if (_pageRoutes.length > 1) {
      _pageRoutes.removeLast();
    }
    notifyListeners();
  }

  void navigatePushReplace(String route) {
    _pageRoutes.last = route;
    notifyListeners();
  }

  void navigatePushReplaceAll(String route) {
    _pageRoutes = <String>[route];
    notifyListeners();
  }

  Future<bool> willPop() async {
    if (_popup.isNotEmpty) {
      removePopup(_popup.keys.last);
    } else if (_pageRoutes.length > 1) {
      navigatePop();
    } else {
      await SystemNavigator.pop();
    }
    return false;
  }

  final PageController _controller = PageController();

  PageController get controller => _controller;

  final Map<String, Popup> _popup = <String, Popup>{};

  final Map<String, Toast> _toast = <String, Toast>{};

  Map<String, Popup> get popup => _popup;

  Map<String, Toast> get toast => _toast;

  void showToast({ResponseModel? model}) {
    final String key = _toast.length.toString();
    _toast.addAll(
      <String, Toast>{
        key: Toast(
          key: Key(key),
          data: model ?? ResponseModel(data: EmptyModel(), type: PopupNotificationType.success),
          destroy: () => removeToast(key),
        ),
      },
    );
    notifyListeners();
  }

  void removeToast(String key) {
    _toast.remove(key);
    notifyListeners();
  }

  void showPopup({PopupConfig? config}) {
    final String key = _popup.length.toString();
    _popup.addAll(
      <String, Popup>{key: Popup(config: config ?? PopupConfig(child: const Text('Popup'), key: key))},
    );
    notifyListeners();
  }

  void removePopup(String key) {
    _popup.remove(key);
    notifyListeners();
  }
}
