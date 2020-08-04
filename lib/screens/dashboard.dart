import 'package:bytebank/screens/contact_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:AppBar (title:Text('Dashboard')),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network('https://images.unsplash.com/photo-1553835973-dec43bfddbeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color:Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ContactsList()));
                  },
                  child: Container(
                      padding:EdgeInsets.all(8.0),
                      height:100,
                      width: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.people,color:Colors.white,size:24.0),
                            Text('Contacts',style:TextStyle(color:Colors.white,fontSize: 16.0))
                          ]
                      )
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}