import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_store_web/views/Side_screens/Categories_screen.dart';
import 'package:multi_store_web/views/Side_screens/Vendor_screen.dart';

import 'Side_screens/Products_screen.dart';
import 'Side_screens/Upload_banner_screen.dart';
import 'Side_screens/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget _selectedScreen = const DashboardScreen();

  screenSelector(item) {

    switch(item.route) {
      case DashboardScreen.screenRoute:
        setState(() {
          _selectedScreen = const DashboardScreen();
        });
        break;
      case UploadBannerScreen.screenRoute:
        setState(() {
          _selectedScreen = const UploadBannerScreen();
        });
        break;
      case VendorScreen.screenRoute:
        setState(() {
          _selectedScreen = const VendorScreen();
        });
        break;
      case CategoryScreen.screenRoute:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('MultiStore Admin Panel'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: UploadBannerScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendor',
            route: VendorScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoryScreen.screenRoute,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Products',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            route: UploadBannerScreen.screenRoute,
            icon: Icons.dashboard,
          ),

        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Made By me',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedScreen,
    );
  }
}
