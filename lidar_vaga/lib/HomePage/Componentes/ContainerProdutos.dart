import 'package:flutter/material.dart';

class ContainerProdutos extends StatefulWidget {
  String nome;
  String preco;
  String foto;
  ContainerProdutos({this.foto,this.nome,this.preco});
  @override
  _ContainerProdutosState createState() => _ContainerProdutosState();
}

class _ContainerProdutosState extends State<ContainerProdutos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.foto)
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Expanded(
              child: Text(widget.nome,style: TextStyle(color: Colors.grey[600]),)),
          ),
          Expanded(child: Text('R\$'+widget.preco))
        ],
      ),
    );
  }
}