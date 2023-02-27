import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class viewMyCompany extends StatefulWidget {
  final application_id;
  const viewMyCompany({Key? key, required this.application_id}) : super(key: key);

  @override
  State<viewMyCompany> createState() => _viewMyCompanyState();
}

class _viewMyCompanyState extends State<viewMyCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children:const [
                 Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Positioned(
                  top: 150,
                  left: 20,
                  child: Text(
                    'Software Developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse finibus euismod lectus. Integer venenatis magna vel arcu maximus, eu aliquam sapien fringilla. Nam in ex in felis bibendum vestibulum. Sed fermentum convallis bibendum. Sed pharetra elementum urna id tristique. Sed feugiat orci ac eros egestas, ut mattis eros pellentesque. In tristique dui ac mauris tincidunt, at consequat magna bibendum. Aliquam scelerisque augue sit amet nulla maximus, ac rhoncus lectus vehicula.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Contact Me',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 10),
                      const Text(
                        'johndoe@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 10),
                      const Text(
                        '+1 (555) 123-4567',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: 200.0,
                    height: 50.0,
                    color: Colors.white,
                    onPressed: () => {

                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
