import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout365app/app/modules/loja/listaTreinosPopulares.dart';
import 'package:workout365app/app/modules/loja/titulo_botaoMais.dart';
import 'package:workout365app/app/modules/loja/treinoTabs.dart';
import 'cabecalhoCaixaPesquisa.dart';

class Loja_Page extends StatefulWidget {
  @override
  _Loja_PageState createState() => _Loja_PageState();
}

class _Loja_PageState extends State<Loja_Page>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    //Define o tamanho total de altura e largura da pagina
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CabecalhoComCaixaPesquisa(size: size),
            TituloComBotaoMais(
              titulo: "Treinos Populares",
              press: () {},
            ),
            Container(
              padding: EdgeInsets.only(
                left: 15,
                top: 15.0,
                right: 15,
              ),
              height: 150.0,
              width: double.infinity,
              child: Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ListaTreinosPopulares(
                      size: size,
                      image: 'lib/assets/images/Abdominal.jpg',
                      titulo: 'Abdominal',
                      modulo: '8 Exercícios',
                      preco: 15,
                      press: () {},
                    ),
                    ListaTreinosPopulares(
                      size: size,
                      image: 'lib/assets/images/Abdominal.jpg',
                      titulo: 'Abdominal',
                      modulo: '8 Exercícios',
                      preco: 15,
                      press: () {},
                    ),
                    ListaTreinosPopulares(
                      size: size,
                      image: 'lib/assets/images/Abdominal.jpg',
                      titulo: 'Abdominal',
                      modulo: '8 Exercícios',
                      preco: 15,
                      press: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.5),
                labelStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(child: Text('Musculação')),
                  Tab(child: Text('Funcional')),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 450.0,
              child: TabBarView(
                controller: tabController,
                children: [
                  TreinoTab(),
                  TreinoTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildListItem(
      String foodName, String imgPath, Color bgColor, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 175.0,
          width: 150.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), color: bgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: foodName,
                child: Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      imgPath,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                foodName,
                style: TextStyle(
                  fontSize: 17.0,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
