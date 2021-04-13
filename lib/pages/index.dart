import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sample_api/theme/colors.dart';
import 'package:http/http.dart' as http;


class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() { 
    super.initState();
    fetchUser();
  }

  fetchUser() async{
    setState(() {
      isLoading = true;
    });
    // print('fetching...');
    // var url = "https://randomuser.me/api/?results=10";
    var url = Uri.parse("https://randomuser.me/api/?results=50");
    var response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200 ) {
      var items = jsonDecode(response.body)['results'];
      setState(() {
        users = items;
        isLoading = false;
      });
      // print(items);
    }else {
      setState(() {
        users = [];
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('RandomUserApi'),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(primary)),
      );
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
        return getCard(users[index]);
      }
    );
  }
  Widget getCard(item){
    var fullName = item['name']['title']+" "+
        item['name']['first']+" "+
        item['name']['last'];
    var email = item['email'];
    var profileUrl = item['picture']['large'];
    print(profileUrl);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(60/2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(profileUrl.toString())
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName.toString(), 
                    style: TextStyle(
                      fontSize: 17
                    ),),
                  SizedBox(height: 10,),
                  Text(
                    email.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}