import 'package:flutter/material.dart';
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // biblioteca para decodificar o json

class Cadastrousuario extends StatefulWidget {
  const Cadastrousuario({super.key});

  @override
  State<Cadastrousuario> createState() => _CadastrousuarioState();
}

class _CadastrousuarioState extends State<Cadastrousuario> {
  // Criando variaveis para usuario e senha

  TextEditingController user_n = TextEditingController();
  TextEditingController email_n = TextEditingController();
  TextEditingController senha_n = TextEditingController();
  // Variavel para exibir a senha

  bool exibir = false;

  // Funçao para realizar login

  _cadastrarusuario() async {
    // url com api dos usuarios
    String url = "http://192.168.56.1:3000/usuarios";
    // Cria dado para fazer o post cadastrando o usuario

    Map<String, dynamic> mensagem = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'user': user_n.text,
      'email': email_n.text,
      'senha': senha_n.text
    };

    // Criando a requisição post para cadastrar o usuario
    http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(mensagem));
    print('Usuario cadastrado');

    user_n.text = "";
    email_n.text = "";
    senha_n.text = "";

    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            content: Text('Usuario cadastrado com sucesso'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fechar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar usuario'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // tipo de teclado
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            icon: Icon(
                              Icons.people_alt_outlined,
                              color: AppColors.primary,
                            ),
                            hintText: 'Digite seu user'),
                        controller: user_n,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            icon: Icon(
                              Icons.email_outlined,
                              color: AppColors.primary,
                            ),
                            hintText: 'Digite seu e-mail'),
                        controller: email_n,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // tipo de teclado
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            icon: Icon(
                              Icons.key_off,
                              color: AppColors.primary,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    exibir = !exibir;
                                  });
                                },
                                icon: Icon(exibir
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            hintText: 'Digite sua senha '),
                        controller: senha_n,
                        obscureText: exibir,
                        obscuringCharacter: '*',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _cadastrarusuario, child: Text('Cadastrar'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
