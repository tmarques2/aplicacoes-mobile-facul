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
  bool _carregando = false;

  @override
  void dispose() {
    user_n.dispose();
    email_n.dispose();
    senha_n.dispose();
    super.dispose();
  }

  // Funçao para realizar login

  _cadastrarusuario() async {
    if (user_n.text.trim().isEmpty ||
        email_n.text.trim().isEmpty ||
        senha_n.text.isEmpty) {
      _mostrarMensagem('Preencha todos os campos para criar sua conta.');
      return;
    }
    setState(() => _carregando = true);
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
    try {
      final resposta = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(mensagem),
      );
      if (resposta.statusCode < 200 || resposta.statusCode >= 300) {
        if (mounted) setState(() => _carregando = false);
        _mostrarMensagem('A API não aceitou o cadastro.');
        return;
      }
    } catch (_) {
      if (mounted) setState(() => _carregando = false);
      _mostrarMensagem('Não foi possível concluir o cadastro.');
      return;
    }
    print('Usuario cadastrado');
    if (mounted) setState(() => _carregando = false);

    user_n.text = "";
    email_n.text = "";
    senha_n.text = "";

    if (!mounted) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cadastro concluído'),
        content: const Text('Sua conta foi criada com sucesso.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
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
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                children: [
                  const _RegisterHeader(),
                  const SizedBox(height: 30),
                  TextField(
                    controller: user_n,
                    textInputAction: TextInputAction.next,
                    decoration: _inputDecoration(
                      label: 'Nome de usuário',
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: email_n,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: _inputDecoration(
                      label: 'E-mail',
                      icon: Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: senha_n,
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
                    child: FilledButton.icon(
                      onPressed: _carregando ? null : _cadastrarusuario,
                      icon: _carregando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.person_add_outlined),
                      label: Text(_carregando ? 'Enviando...' : 'Criar conta'),
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

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68,
          width: 68,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.hotel,
            color: AppColors.onPrimary,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Comece sua jornada',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Crie sua conta para explorar destinos incríveis.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
