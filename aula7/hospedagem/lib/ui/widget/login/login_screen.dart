import 'package:flutter/material.dart'; // biblioteca de design do Flutter
import 'package:hospedagem/ui/_core/app_colors.dart';
import 'package:hospedagem/data/session_storage.dart';
import 'package:hospedagem/ui/widget/cadastro/cadastro_screen.dart';
import 'package:hospedagem/ui/widget/home/home_screen.dart';
import 'package:http/http.dart'
    as http; // biblioteca que permite realizar as requisições http
import 'dart:convert'; // biblioteca que permite fazer os parses para tratamento do json

// Cria classe  chamada login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Cria variaveis para usuario e senha
  TextEditingController user = TextEditingController();
  TextEditingController senha = TextEditingController();
  // variavel para exibir a senha
  bool exibir = false;

  // função para realizar o login
  _verificaLogin() async {
    // Cria variavel Flag para quando encontrar o login
    bool encuser = false;
    // url com a api dos usuarios
    String url = "http://192.168.56.1:3000/usuarios";
    // Cria a variavel para armazenar a resposta da api
    http.Response resposta =
        await http.get(Uri.parse(url)); // Resposta assincrona

    print(resposta.statusCode);

    // Cria uma variavel para armazenar os dados

    var dados = json.decode(resposta.body)
        as List; // armazena os dados na forma de lista
    if (dados.isNotEmpty) {
      print("${dados[0]["user"]} ${dados[0]["email"]} ${dados[0]["senha"]}");
    }

    // cria laço de repetição para exibir mais de um usuario cadastrado na api
    for (int i = 0; i < dados.length; i++) {
      print(
          "${dados[i]["user"]} | ${dados[i]["email"]} | ${dados[i]["senha"]}");

      if ((user.text == dados[i]["user"] || user.text == dados[i]["email"]) &&
          senha.text == dados[i]["senha"]) {
        // variavel encuser muda para true
        encuser = true;
      }
    }
    if (encuser == true) {
      print("Usuario ${user.text} encontrado");
      encuser = false;
      await SessionStorage.saveLogin();
      // Vai para outra tela

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
      user.text = "";
      senha.text = "";
    } else {
      print('Usuario não encontrado');
      user.text = "";
      senha.text = "";
      // Cria um showdialog

      showDialog(
          context: context,
          builder: (BuildContext) {
            return AlertDialog(
              content: Text('Usuário não encontrado'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              // Tipo de teclado
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  icon: Icon(
                    Icons.people_alt_outlined,
                    color: AppColors.primary,
                  ),
                  hintText: 'Digite seu user ou email'),
              controller: user,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                icon: Icon(
                  Icons.key_off_outlined,
                  color: AppColors.primary,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        exibir = !exibir;
                      });
                    },
                    icon:
                        Icon(exibir ? Icons.visibility_off : Icons.visibility)),
                hintText: 'Digite sua senha',
              ),
              obscureText: exibir,
              obscuringCharacter: '*',
              controller: senha,
            ),
            ElevatedButton(onPressed: _verificaLogin, child: Text('Entrar')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cadastrousuario()));
                },
                child: Text('Cadastrar'))
          ],
        ),
      ),
    );
  }
}
