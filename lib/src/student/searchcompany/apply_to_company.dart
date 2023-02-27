import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class applyToCompany extends StatefulWidget {
  final companyId;
  const applyToCompany({Key? key, required this.companyId}) : super(key: key);

  @override
  State<applyToCompany> createState() => _applyToCompanyState();
}

class _applyToCompanyState extends State<applyToCompany> {
  bool isLoading = false;
  TextEditingController _NameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Application Section'),
      //   automaticallyImplyLeading: true,
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Apply To Company',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                _buildTextField('First Name', Icons.email, _NameController),
                SizedBox(height: 10.0),
                _buildTextField('Email', Icons.email, _emailController),
                SizedBox(height: 10.0),
                _buildTextField('Phone', Icons.email, _phoneController),
                SizedBox(height: 10.0),
                _buildTextField('Address', Icons.email, _addressController),
                SizedBox(height: 10.0),
                (isLoading) ? CircularProgressIndicator() : _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSnack(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(

      minWidth: 200.0,
      height: 50.0,
      color: Colors.white,
      onPressed: () => {},
      child: Text(
        'Apply',
        style: TextStyle(
          color: Colors.teal,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
