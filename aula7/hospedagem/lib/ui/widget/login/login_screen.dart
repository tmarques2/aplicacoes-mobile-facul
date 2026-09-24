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
  bool _carregando = false;

  @override
  void dispose() {
    user.dispose();
    senha.dispose();
    super.dispose();
  }

  // função para realizar o login
  _verificaLogin() async {
    if (user.text.trim().isEmpty || senha.text.isEmpty) {
      _mostrarMensagem('Preencha usuário e senha para continuar.');
      return;
    }
    setState(() => _carregando = true);
    // Cria variavel Flag para quando encontrar o login
    bool encuser = false;
    // url com a api dos usuarios
    String url = "http://192.168.56.1:3000/usuarios";
    // Cria a variavel para armazenar a resposta da api
    http.Response resposta;
    try {
      resposta = await http.get(Uri.parse(url));
    } catch (_) {
      if (mounted) setState(() => _carregando = false);
      _mostrarMensagem('Não foi possível conectar à API.');
      return;
    }

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
      setState(() => _carregando = false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
      user.text = "";
      senha.text = "";
    } else {
      if (mounted) setState(() => _carregando = false);
      print('Usuario não encontrado');
      user.text = "";
      senha.text = "";
      // Cria um showdialog

      _mostrarMensagem('Usuário ou senha incorretos.');
    }
  }

  void _mostrarMensagem(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                children: [
                  _AuthHeader(
                    title: 'Bem-vindo ao S&M Hotel',
                    subtitle: 'Planeje uma estadia inesquecível.',
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: user,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration(
                      label: 'Usuário ou e-mail',
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: senha,
                    obscureText: !exibir,
                    obscuringCharacter: '*',
                    decoration: _inputDecoration(
                      label: 'Senha',
                      icon: Icons.lock_outline,
                    ).copyWith(
                      suffixIcon: IconButton(
                        tooltip: exibir ? 'Ocultar senha' : 'Mostrar senha',
                        onPressed: () => setState(() => exibir = !exibir),
                        icon: Icon(
                          exibir ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _carregando ? null : _verificaLogin,
                      child: _carregando
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Entrar'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Cadastrousuario(),
                        ),
                      ),
                      child: const Text('Criar uma conta'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration(
    {required String label, required IconData icon}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
  );
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 78,
          width: 78,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.hotel,
            color: AppColors.onPrimary,
            size: 38,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(subtitle, textAlign: TextAlign.center),
      ],
    );
  }
}
