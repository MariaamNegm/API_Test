import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:testapi/attributes.dart';
 class posts extends StatefulWidget {
   @override
   _postsState createState() => _postsState();
 }

 class _postsState extends State<posts> {

   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       backgroundColor: Colors.teal,
        appBar: AppBar(
          centerTitle: true,
          //title at center
          backgroundColor: Colors.deepOrangeAccent,
          title:Text("Posts",style:TextStyle(fontSize: 28,color: Colors.black87),)
        ),
       body:
           //A widget for building a listview of the recieved data from the url used in the function below
       FutureBuilder(
         future: getposts(),
     //calling the function that responsible for getting the data from server
     builder: (BuildContext context, AsyncSnapshot snapshot) {
       if (snapshot.hasData) {
         //checking if there is data or not
           return Padding(
             padding: const EdgeInsets.all(10.0),
             //builder a listview by widget listview.builder
             child: ListView.builder(
               //the length it depends on how much data handled
                   itemCount:snapshot.data.length,
                 //context is where you are in the code instantly and i is the index
                 itemBuilder:(context,i)
                 {
                   return Card(
                     // save the data to be shown as a card
                     shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(20),
                   topLeft:  Radius.circular(20),
                   bottomRight:  Radius.circular(20),
                   topRight:  Radius.circular(20),
                   ),
                   ),
                       //shape of card it is edged shape
                       elevation: 20.0,
                       //elevation to feel as the card it out of screen
                       margin:EdgeInsets.all(8),child:
                   Container(
                     padding: EdgeInsets.all(10),
                       child: Column(
                         //to have the text from left to right
                         crossAxisAlignment:CrossAxisAlignment.start,
                         children: [
                           //these are the data which is going to be displayed
                           Text("ID:${snapshot.data[i].id }",style:TextStyle(fontSize: 22,color: Colors.black87),),
                           Text("USER_ID:${snapshot.data[i].userid }",style:TextStyle(fontSize: 22,color: Colors.black87),),
                           Text("Title:${snapshot.data[i].title }",style:TextStyle(fontSize: 22,color: Colors.black87),),
                           Text("Body:${snapshot.data[i].body }",style:TextStyle(fontSize: 22,color: Colors.black87),),
                         ],
                       ))
                   );
                 }
                  ),
           );
       }

       else {
         return Center(
           //if the data is not found so the progress indicator will be displayed
           child: CircularProgressIndicator(
             backgroundColor: Colors.black87,

           ),
         );
       };
     },
       ),
     );
   }

   Future<List<attributes>> getposts() async {
     //this function is for recieving the data from the server with the address the url
     var url=Uri.parse("https://jsonplaceholder.typicode.com/posts");
     var response= await http.get(url);
     // define a list to carry the data
     List<attributes> listposts=[];
     if(response.statusCode==200){
// status code 200 means that the data is responding and found
         var responsebody=jsonDecode(response.body) ;

         for(var i in responsebody)
           {
             //looping for saving the data in the list
             attributes post=attributes(id:i["id"],body:i["body"],title: i["title"], userid: i["userId"]);
             listposts.add(post);
           }
         return  listposts;

     }
     return  listposts;
   }
 }

