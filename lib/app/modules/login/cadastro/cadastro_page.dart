import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF414550),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF414550),
                              Color(0xFF18191E),
                            ]),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'lib/assets/images/logoGrandeBranca.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text("Preecha as informações para se registrar"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                      ]),
                  child: TextFormField(
                    controller: controller.nomeController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: 'Nome',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Nome é obrigatório!';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                      ]),
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      icon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: 'Email',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email é obrigatório!';
                      } else if (!value.contains("@")) {
                        return "Informe um Email válido!";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                      ]),
                  child: TextFormField(
                    controller: controller.cpfController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      icon: Icon(
                        Icons.library_books,
                        color: Colors.grey,
                      ),
                      hintText: 'CPF',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'CPF é obrigatório!';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, top: 24.0),
                      child: Text(
                        "Sexo",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                  ),
                  child: Observer(
                    builder: (_) {
                      return Row(
                        children: <Widget>[
                          Radio(
                            value: "feminino",
                            groupValue: controller.genero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (String value) {
                              controller.genero = value;
                            },
                          ),
                          Text(
                            "Feminino",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Radio(
                            value: "masculino",
                            groupValue: controller.genero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (String value) {
                              controller.genero = value;
                            },
                          ),
                          Text(
                            "Masculino",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                      ]),
                  child: TextFormField(
                    controller: controller.telefoneController,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      icon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      hintText: 'Telefone',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Telefone é obrigatório!';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Observer(
                    builder: (_) {
                      return TextFormField(
                        controller: controller.senhaController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.esconderSenha == true
                                  ? Icons.lock
                                  : Icons.lock_open,
                            ),
                            onPressed: () {
                              controller.mostrarSenha();
                            },
                          ),
                          enabledBorder: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey,
                          ),
                          hintText: 'Senha',
                        ),
                        autocorrect: false,
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Senha é obrigatória!';
                          } else if (pass.length < 6) {
                            return 'A senha deve ter no mínimo 6 caracteres!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: controller.esconderSenha,
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(
                    top: 4,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: Observer(
                    builder: (_) {
                      return TextFormField(
                        controller: controller.confirmaSenhaController,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey,
                          ),
                          hintText: 'Confirmar Senha',
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.esconderConfirmaSenha == true
                                  ? Icons.lock
                                  : Icons.lock_open,
                            ),
                            onPressed: () {
                              controller.mostrarConfirmaSenha();
                            },
                          ),
                        ),
                        autocorrect: false,
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Senha é obrigatória!';
                          } else if (pass.length < 6) {
                            return 'A senha deve ter no mínimo 6 caracteres!';
                          } else if (pass != controller.senhaController.text) {
                            return 'Os valores de senha e confirma senha não são iguais!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: controller.esconderConfirmaSenha,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 40.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xFF04959A),
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller.cadastrarUsuario();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 10.0),
                          Center(
                            child: Text(
                              'Registrar',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
