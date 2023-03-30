// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:tamkeen_flu/src/company/dashboard.dart';
import '../../api.dart';
import '../components/globals.dart';
import '../components/sharePrefs.dart';
import '../settings.dart';
import 'allpositions.dart';
import 'aplication_status.dart';
import 'mycompany/my_companies.dart';
import 'profile.dart';
import 'searchcompany/search_company.dart';

class studentDashboard extends StatefulWidget {
  const studentDashboard({Key? key}) : super(key: key);

  @override
  State<studentDashboard> createState() => _studentDashboardState();
}

class _studentDashboardState extends State<studentDashboard> {
  //   Future _getdata() async{

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? values= prefs.getStringList("profile",);
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {

  //     var res =
  //     await api.StudentLogin(values![0],values[1]);
  //      if(res['codeStatus'] == true){
  //       print(res['data']);
  //       setState(() {
  //         ACCOUNT_TYPE=res['data']['account_type'];
  //       });
  //         // print(res['data']['degree_level'].runtimeType);
  //      }
  //   } catch (e) {
  //   }
  // }
  // String? user_id = '';
  // String? user_name = '';
  // String? user_email = '';
  // String? user_phone = '';
  Map userDetails = {};
  bool isLoading = false;
  Future _requestForVip() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await api.StudentRequestVip(USER_ID.toString());
      if (res['codeStatus'] == true) {
        _showSnack(res['message']);
      } else {
        _showSnack(res['message']);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnack('HTTP ERROR');
    }
  }

  Future _check_is_vip() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await api.getStudentByid(USER_ID.toString());
      print(res);
      if (res['codeStatus'] == true) {
        userDetails = res['data'];
        setState(() {
          ACCOUNT_TYPE = res['data']['account_type'];
        });
        // print(userDetails);
      } else {
        _showSnack('NO User Found');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnack('HTTP ERROR');
      return false;
    }
  }

  DateTime? currentBackPressTime;
  @override
  void initState() {
    // getdata();

    _check_is_vip();
  }

  @override
  Widget build(BuildContext context) {
    print(ACCOUNT_TYPE);
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 3)) {
          currentBackPressTime = now;
          const snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LANGUAGE == 'ENGLISH' ? 'Dashboard' : 'لوحة القيادة'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  delete_prefs(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        LANGUAGE == 'ENGLISH'
                            ? 'Welcome back!'
                            : 'مرحبًا بعودتك!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        USER_NAME.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ACCOUNT_TYPE == "1"
                          ? const SizedBox.shrink()
                          : _buildRequestButton()
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        LANGUAGE == 'ENGLISH'
                            ? 'Quick Access'
                            : "الوصول السريع",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: <Widget>[
                            _buildQuickAccessCard(
                              LANGUAGE == 'ENGLISH' ? 'My Profile' : 'ملفي',
                              Icons.person,
                              Colors.orange,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const profile()))),
                            ),
                            _buildQuickAccessCard(
                                LANGUAGE == 'ENGLISH' ? 'My Company' : 'شركتي',
                                Icons.shopping_cart,
                                Colors.green, () {
                              if (ACCOUNT_TYPE != '1') {
                                _check_is_vip();
                              }
                              (ACCOUNT_TYPE == '1')
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const myCompanies())))
                                  : _showSnack('Need VIP ACCOUNT');
                            }),
                            _buildQuickAccessCard(
                                LANGUAGE == 'ENGLISH'
                                    ? 'Search Company'
                                    : "البحث عن شركة",
                                Icons.message,
                                Colors.blue, () {
                              if (ACCOUNT_TYPE != '1') {
                                _check_is_vip();
                              }
                              (ACCOUNT_TYPE == '1')
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const SearchCompany())))
                                  : _showSnack('Need VIP ACCOUNT');
                            }),
                            _buildQuickAccessCard(
                              LANGUAGE == 'ENGLISH'
                                  ? 'View Position'
                                  : "مشاهدة الوظيفة",
                              Icons.add_box_sharp,
                              Colors.lime,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const AllPositions()))),
                            ),
                            _buildQuickAccessCard(
                              LANGUAGE == 'ENGLISH'
                                  ? 'Applications'
                                  : "التطبيقات",
                              Icons.format_list_bulleted_outlined,
                              Colors.blueGrey,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const ApplicationStatus()))),
                            ),
                            _buildQuickAccessCard(
                              LANGUAGE == 'ENGLISH' ? 'Settings' : 'إعدادات',
                              Icons.settings,
                              Colors.purple,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const SettingsScreen()))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestButton() {
    return MaterialButton(
      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed: _requestForVip,
      child: Text(
        LANGUAGE == 'ENGLISH' ? 'Request For VIP' : 'طلب VIP',
        style: const TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void getdata() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   user_id = prefs.getString('user_id');
  //   user_name = prefs.getString('user_name');
  //   user_email = prefs.getString('user_email');
  //   user_phone = prefs.getString('user_phone');
  //   setState(() {});
  // }

  _showSnack(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
