import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: FutureBuilder<List<Contact>>(
          initialData: List(),
          //para iniciar ja com uma lista para nao ter problema

          //ele espera devolver um widghet
          future: _dao.findALl(),
          //chamo o future que é o metodo  do banco de dados
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              //estados da feature

              case ConnectionState
                  .none: //nao foi executado aí eu posso colorcar um botao
                break;
              case ConnectionState
                  .waiting: //ainda esta carregando aí eu posso colocar o widtget de reload
                return Progress();
                break;
              case ConnectionState
                  .active: //tem o dado disponivel so que nao foi finalizado, como um download
                // TODO: Handle this case.
                break;
              case ConnectionState.done: //é o q acabou
                //com o snapshot eu consigo acessar o future builder
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return _ContactItem(contact, onclick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    }); //retorna um contact item, ques esta escrito em baixo
                  },
                  itemCount: contacts.length, //por meio de uma lista
                );
                break; //ContactForm
            }

            return Text('Unknown error');
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ContactForm();
              },
            )).then((value) {
              setState(() {});
            });
          },
        ));
  }
}

//para fazer uma lista dinamica
class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onclick;

  _ContactItem(
    this.contact, {
    @required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () => onclick(),
      title: Text(
        contact.name,
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      subtitle: Text(contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          )),
    ));
  }
}
