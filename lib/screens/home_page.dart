import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/token_model.dart';
import 'package:flutter_application_1/screens/details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // stores our token list
  List<TokenInfo>? _tokenData;

  // loading
  bool? _isLoading = false;

  // function to fetch our token data
  fetchTokenInfo() async {
    try {
      var res = await http.get(
          Uri.parse('http://149.28.119.165/arbvolume/live/price/v1/api/ftx'));

      final tokenData = tokenDataFromJson(res.body);

      _tokenData = tokenData.data;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    fetchTokenInfo();
    super.initState();
  }

  static const spinkit = SpinKitCircle(
    color: Colors.green,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    log('_tokenData $_tokenData');
    return Scaffold(
      appBar: AppBar(
        title: Text('Equator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text('Our first app'),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text('Our lkjsdlkmd app'),
            ),
            Row(
              children: [
                Text('Something'),
                SizedBox(
                  width: 210,
                ),
                Text('two'),
                Text('three'),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = false;
                });
              },
              child: Text('Stop loading'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
              },
              child: Text('Load'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            (_isLoading == true) ? spinkit : Container(),
            Container(
              height: 200,
              width: 200,
              color: Colors.white,
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('OUTLINED BUTTON'),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsScreen())),
                    child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            'Details',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tokenData!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _tokenData![index].symbol.toString(),
                    ),
                    trailing: Text('${_tokenData![index].price}'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
