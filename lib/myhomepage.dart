import 'package:bloc_test/myhomepage_bloc.dart';
import 'package:flutter/material.dart';

import 'endereco_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MyHomePageBloc bloc = MyHomePageBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (value){
                bloc.input.add(value);
              },
              decoration: InputDecoration(
                hintText: "Digite seu CEP",
                border: OutlineInputBorder()
              ),
            ),
            Center(
              child: StreamBuilder<EnderecoModel>(
                stream: bloc.output,
                initialData: EnderecoModel(bairro: "Sem bairro"),
                builder: (context, snapshot) {

                  if(snapshot.hasError){
                    return Text("Erro na pesquisa",
                        style: TextStyle(color: Colors.red));
                  }

                  EnderecoModel model = snapshot.data;

                  return Text("Bairro: ${model?.bairro}");
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
