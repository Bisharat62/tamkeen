import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamkeen_flu/src/components/globals.dart';
import 'package:tamkeen_flu/src/settings.dart';

import '../components/sharePrefs.dart';
import 'my_students.dart';
import 'profile.dart';
import 'search_student.dart';
import 'package:flutter/cupertino.dart';
class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({Key? key}) : super(key: key);

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  // String? user_id = '';
  // String? user_name = '';
  // String? user_email = '';
  // String? user_phone = '';
  Map userDetails = {};
  bool isLoading = false;
   DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
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
          title:  Text(LANGUAGE=='ENGLISH'?'CompanyDashboard':'الشركة'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){delete_prefs(context);}, icon:const Icon(Icons.logout_outlined,color: Colors.white,))
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
                       LANGUAGE=='ENGLISH'? 'Welcome back!':'مرحبًا بعودتك!',
                        style:const TextStyle(
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
                        LANGUAGE=='ENGLISH'? 'Quick Access':'الوصول السريع',
                        style:const TextStyle(
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
                               LANGUAGE=='ENGLISH'?'My Profile':'ملفي',
                              Icons.person,
                              Colors.orange,
                                  () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const ProfileCompany()))),
                            ),
                            _buildQuickAccessCard(
                              LANGUAGE=='ENGLISH'?'My Students':'طلابي',
                              Icons.shopping_cart,
                              Colors.green,
                                  () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const MyStudents()))),
                            ),
                            _buildQuickAccessCard(
                             LANGUAGE=='ENGLISH'? 'Search Students':'البحث عن الطلاب',
                              Icons.message,
                              Colors.blue,
                                  () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const SearchStudent()))),
                            ),
                            _buildQuickAccessCard(
                             LANGUAGE=='ENGLISH'?  'Settings':'إعدادات',
                              Icons.settings,
                              Colors.purple,
                                  () => Navigator.push(context, MaterialPageRoute(builder: ((context) => const SettingsScreen()))).then((value) => setState(() {})),
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
      onPressed: () => {},
      child: const Text(
        'Request For VIP',
        style: TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget _buildQuickAccessCard(String title, IconData icon, Color color, VoidCallback onTap) {
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

  _showSnack(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
