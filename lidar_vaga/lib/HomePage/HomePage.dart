import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lidarvaga/API/Api.dart';
import 'package:lidarvaga/API/Produto.dart';
import 'package:lidarvaga/HomePage/Componentes/ContainerProdutos.dart';
import 'Componentes/Cards.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Variavel que controla o textFielf de pesquisa de produto
  TextEditingController pesquisa = TextEditingController();

  //Variaveis para controlar a busca de dados da API
  var produtos = List<Produtos>();
  final _streamController = StreamController<List>();

  //Variavel com o valor inicial do DropdownValue
  String dropdownValue = 'Selecione';


  //Metodo que pega dados de API
  _getProdutos() {
    API.getProdutos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        produtos = lista.map((e) => Produtos.fromJson(e)).toList();
        _streamController.add(lista);
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _getProdutos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace:Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.only(bottom: 8,left: 45),
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage(
                  'imagens/magazan.png',))
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blue[900]),
        actions: [
          IconButton(
            icon: Icon(Icons.home_rounded), 
            onPressed: (){}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined), 
            onPressed: (){}),
        ],
      ),
      drawer: Drawer(),
      body: StreamBuilder<Object>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                    ));

            default:
              if(snapshot.hasError){
                  return Center(
                    child: Text(
                      "Erro inesperado :(",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  );
              }else
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        color: Colors.blue[900],
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          color: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.redAccent,
                                primaryColorDark: Colors.red,
                              ),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.clear),
                                    suffixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder()
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Seu nome aqui',style: TextStyle(fontSize: 18),),
                        )),
                      Row(
                        children: [
                          Icon(Icons.room),
                          Text('Você está no Magazan Humaitá'),
                          Spacer(),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.dehaze_rounded,color: Colors.white,),
                                Expanded(child: Text('Buscar categorias',textAlign: TextAlign.left,style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          )
                        ],
                      ),

                      Container(
                        color: Colors.transparent,
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CardInfo(texto: 'Voltar',),
                            CardInfo(texto: 'Condicionador de ar',),
                            CardInfo(texto: 'Imagem',),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text('Ordenar por:'),
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>['Selecione', 'Nome', 'Preço', 'Categoria']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        itemCount: produtos.length,
                        itemBuilder: (context,int index){
                          return ContainerProdutos(
                            foto: produtos[index].image,
                            nome: produtos[index].title,
                            preco: '300',
                          );
                        },
                      )
                    ],
                  ),
                );
          }
        }
      )
    );
  }
}
