import 'package:flutter/material.dart';
import 'package:tamkeen_flu/api.dart';

import '../components/appbar.dart';
import '../components/globals.dart';
import '../helpers/const_text.dart';
import '../helpers/globalSnackbar.dart';

class AllPositions extends StatefulWidget {
  const AllPositions({super.key});

  @override
  State<AllPositions> createState() => _AllPositionsState();
}

class _AllPositionsState extends State<AllPositions> {
  List list = [];
  bool isLoading = false;
  getapplication() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await api.getAllPositions();
      print("res $res");
      if (res['codeStatus'] == true) {
        list = res['data'];
        setState(() {
          isLoading = false;
        });
      } else {
        showInSnackBar(res['message'], color: Colors.red);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapplication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: 'View Applications Status',
        back: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : list.isEmpty
              ? Center(
                  child: boldtext(Colors.red, 14, "No Applications Available"))
              : ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card();
                  }),
    );
  }
}
