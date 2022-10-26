import 'package:flutter/material.dart';

import '../models/menu_pages_info.dart';
import '../state/data_state.dart';
import '../ui/pages/home_wrapper_page.dart';
import '../ui/pages/login_page.dart';
import '../ui/pages/menu_pages/page_1.dart';
import '../ui/pages/menu_pages/page_2.dart';
import '../ui/pages/menu_pages/page_3.dart';
import '../ui/pages/menu_pages/page_4.dart';
import '../ui/pages/register_page.dart';
import '../ui/pages/splash_page.dart';
import '../ui/pages/test_page.dart';

class CustomPageRoute {
  static const String splashRoute = 'splash_route';
  static const String loginRoute = 'login_route';
  static const String registerRoute = 'register_route';
  static const String homeWrapperRoute = 'home_wrapper_route';
  static const String testRoute = 'test_route';
  static const List<String> pageNames = <String>['page 1', 'page 2', 'page 3', 'page 4'];
}

Map<String, Widget> createMainPages() {
  final DataState state = DataState();
  return <String, Widget>{
    CustomPageRoute.loginRoute: LoginPage(loginModel: state.loginModel),
    CustomPageRoute.registerRoute: RegisterPage(registerModel: state.registerModel),
    CustomPageRoute.splashRoute: const SplashPage(),
    CustomPageRoute.testRoute: const TestPage(),
    CustomPageRoute.homeWrapperRoute: const HomeWrapperPage(),
  };
}

List<MenuPageInfo> menuPages = <MenuPageInfo>[
  MenuPageInfo(
    name: CustomPageRoute.pageNames[0],
    title: 'Page 1',
    icon: const Icon(Icons.h_mobiledata, color: Colors.grey),
    activeIcon: const Icon(Icons.h_mobiledata, color: Colors.white),
    page: const Page1(),
  ),
  MenuPageInfo(
    name: CustomPageRoute.pageNames[1],
    title: 'Page 2',
    icon: const Icon(Icons.h_mobiledata, color: Colors.grey),
    activeIcon: const Icon(Icons.h_mobiledata, color: Colors.white),
    page: const Page2(),
  ),
  MenuPageInfo(
    name: CustomPageRoute.pageNames[2],
    title: 'Page 3',
    icon: const Icon(Icons.h_mobiledata, color: Colors.grey),
    activeIcon: const Icon(Icons.h_mobiledata, color: Colors.white),
    page: const Page3(),
  ),
  MenuPageInfo(
    name: CustomPageRoute.pageNames[3],
    title: 'Page 4',
    icon: const Icon(Icons.h_mobiledata, color: Colors.grey),
    activeIcon: const Icon(Icons.h_mobiledata, color: Colors.white),
    page: const Page4(),
  ),
];
