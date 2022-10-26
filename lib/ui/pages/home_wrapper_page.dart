import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/size_constants.dart';
import '../../models/menu_pages_info.dart';
import '../../state/navigation_state.dart';
import '../components/ink_well_without_glow.dart';
import '../components/scroll_without_glow.dart';

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          const Header(),
          SizedBox(
            height:
                MediaQuery.of(context).size.height - SizeConstants.headerHeight - SizeConstants.menuHeight,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: context.watch<NavigationState>().controller,
              children: context
                  .watch<NavigationState>()
                  .menuPagesInfo
                  .map((MenuPageInfo i) => ScrollWithoutGlow(child: i.page))
                  .toList(),
            ),
          ),
          const BottomNavigation(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF6592B9),
            Color(0xFF125998),
            Color(0xFF04447B),
          ],
          stops: <double>[1, 0.5, 0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      alignment: Alignment.center,
      height: SizeConstants.headerHeight,
      child: const Text('Header'),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: SizeConstants.menuHeight,
      padding: SizeConstants.menuPadding,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF04447B),
            Color(0xFF125998),
            Color(0xFF6592B9),
            Color(0xFFB4CBDD),
            Color(0xFFE1E9EF),
          ],
          stops: <double>[0.035, 0.35, 0.62, 0.88, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: context
            .watch<NavigationState>()
            .menuPagesInfo
            .map((MenuPageInfo i) => _buildButton(pageInfo: i, context: context))
            .toList(),
      ),
    );
  }

  Widget _buildButton({
    required MenuPageInfo pageInfo,
    required BuildContext context,
  }) {
    return InkWellWithoutGlow(
      onTap: () => context.read<NavigationState>().menuPageChange(pageInfo.name),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 100, minWidth: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            pageInfo.currentIcon,
            Text(
              pageInfo.title,
              style: TextStyle(
                color: pageInfo.isActive ? Colors.white : Colors.grey,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
