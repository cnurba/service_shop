import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/basket_screen.dart';
import 'package:service_shop/app/favs/favs_screen.dart';
import 'package:service_shop/app/profile/profile_screen.dart';
import 'package:service_shop/app/profile/unregistered_profile_screen.dart';
import 'package:service_shop/app/search/search_screen.dart';
import 'package:service_shop/app/shop/application/shops/shops_provider.dart';
import 'package:service_shop/app/shop/shop_screen.dart';
import 'package:service_shop/auth/presentation/screens/resign_withnumber.dart';
import 'package:service_shop/core/presentation/navs/nav_bar.dart';
import 'package:service_shop/core/presentation/navs/tab_holder.dart';

import 'core/presentation/navs/toast.dart';

class ServiceShopAppScreen extends ConsumerStatefulWidget {
  const ServiceShopAppScreen({super.key});

  @override
  ConsumerState<ServiceShopAppScreen> createState() =>
      _ServiceShopAppScreenState();
}

class _ServiceShopAppScreenState extends ConsumerState<ServiceShopAppScreen> {
  final _tabController = CupertinoTabController();
  final _toastKey = GlobalKey<ToastState>();

  @override
  void initState() {
    Future.microtask(() {
      ref.read(shopsProvider.notifier).loadShops();
    });
    super.initState();
  }

  /// System back button tap count.
  var _backTapCount = 0;
  final _tabHistory = [0];
  final _tabHolders = {
    0: GlobalKey<TabNavigatorHolderState>(),
    1: GlobalKey<TabNavigatorHolderState>(),
    2: GlobalKey<TabNavigatorHolderState>(),
    3: GlobalKey<TabNavigatorHolderState>(),
    4: GlobalKey<TabNavigatorHolderState>(),
  };

  void _onTabChanged(int newTab) {
    final previous = _tabHistory.last;
    _tabHistory.add(newTab);
    if (_tabHistory.length > 2) {
      _tabHistory.removeAt(0);
    }
    if (previous == newTab) {
      // go to the tab's root
      _tabHolders[previous]?.currentState?.navigator.popUntil(
        ModalRoute.withName('/'),
      );
    }
  }

  Future<bool> _onTabPopped() {
    const backTapLimit = 2;
    final currentTab = _tabHistory.last;
    final currentTabNavigator =
        _tabHolders[currentTab]?.currentState?.navigator;
    if (currentTabNavigator!.canPop()) {
      _backTapCount = 0;
      currentTabNavigator.pop();
    } else if (currentTab != 0) {
      _backTapCount = 0;
      _tabController.index = 0;
      _tabHistory.add(0);
      if (_tabHistory.length > 2) {
        _tabHistory.removeAt(0);
      }
    } else {
      _backTapCount++;
      if (_backTapCount < backTapLimit) {
        _toastKey.currentState!.showToast(
          child: const Text("Чтобы выйти нажмите еще раз"),
        );
      }
    }
    return Future.value(_backTapCount == backTapLimit);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onTabPopped,
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBuilder: (context, tab) {
          return CupertinoTabView(
            builder: (context) {
              switch (tab) {
                case 0:
                  return TabNavigatorHolder(
                    key: _tabHolders[0],
                    child: const ShopScreen(),
                  );
                case 1:
                  return TabNavigatorHolder(
                    key: _tabHolders[1],
                    child: const SearchScreen(),
                  );
                case 2:
                  return TabNavigatorHolder(
                    key: _tabHolders[2],
                    child: const FavsScreen(),
                  );
                case 3:
                  return TabNavigatorHolder(
                    key: _tabHolders[3],
                    child: const BasketScreen(),
                  );
                case 4:
                  return TabNavigatorHolder(
                    key: _tabHolders[4],
                    child: const ResignWithnumberScreen(),
                  );
                default:
                  return TabNavigatorHolder(
                    key: _tabHolders[2],
                    child: Scaffold(
                      body: Column(
                        children: [
                          const Spacer(),
                          Center(child: Text('Tab $tab')),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
              }
            },
          );
        },
        tabBar: NavBar(
          onTab: (newTab) {
            if (newTab == 0) {
              //context.read<DeliveryListCubit>().load(status: 0);
            } else {
              // context.read<DeliveryListCubit>().load(status: 1);
            }
            _onTabChanged(newTab);
          },
        ),
      ),
    );
  }
}
