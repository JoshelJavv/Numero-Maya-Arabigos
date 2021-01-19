import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var rng = new Random();
int numeroAleatorio = rng.nextInt(401);
//int numeroAleatorio = 401;
int numInterfaz = (rng.nextInt(3) + 1);
String interfazEnTurno = "";
TextEditingController valorTextfield = new TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  bool accepted = false;
  bool calcular = false;
  String que = "";
  List<Widget> piso1 = List();
  List<Widget> piso2 = List();
  List<Widget> piso3 = List();
  List<Widget> mostrarNumeroMaya = List();

  Widget raya = Container(width: 75, height: 10, color: Colors.black);
  Widget gris = Container(width: 50, height: 50, color: Colors.grey);
  Widget punto = Container(
    width: 15,
    height: 15,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500), color: Colors.black),
  );

  Widget rayaBoton = Container(
    width: 70,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(width: 3),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 50,
        height: 10,
        color: Colors.black,
      )
    ]),
  );

  Widget puntoBoton = Container(
    width: 70,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(width: 3),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500), color: Colors.black),
      )
    ]),
  );

  Widget conchaBoton = Container(
    width: 70,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(width: 3),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 50,
        height: 30,
        child: new Image.asset(
          'assets/img/maya_blanca.png',
          width: 100,
          height: 50,
          fit: BoxFit.contain,
        ),
      )
    ]),
  );
  Widget secundario = Container(
    width: 70,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(width: 3),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
  );
  Widget concha = Container(
    width: 100,
    height: 50,
    child: new Image.asset(
      'assets/img/maya_blanca.png',
      width: 100,
      height: 50,
      fit: BoxFit.contain,
    ),
  );

  List<Widget> regresarLista(piso) {
    List<Widget> lista = piso;
    List<Widget> imprimir = List();
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] == punto) {
        print("posicion $i:  punto");
      }
      if (lista[i] == raya) {
        print("posicion $i:  raya");
      }
    }
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] == punto) {
        int contar = i;
        List<Widget> columna = List();

        while (contar < lista.length && lista[contar] == punto) {
          columna.add(Column(children: [lista[contar]]));
          columna.add(SizedBox(
            width: 5,
          ));
          contar++;
          //print("ok");
        }

        imprimir.insert(
            0,
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 50,
                height: 5,
                color: Colors.grey,
              )
            ]));
        imprimir.insert(
            0,
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: columna));
        i = contar - 1;
        //print("i: $i");
      } else if (lista[i] == raya) {
        imprimir.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [lista[i]],
        ));
        imprimir
            .add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 50,
            height: 5,
            color: Colors.grey,
          )
        ]));
      } else {
        imprimir.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [lista[i]],
        ));
        imprimir
            .add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 50,
            height: 5,
            color: Colors.grey,
          )
        ]));
      }
    }
    //print(lista.length);
    return imprimir;
  }

  void agregarWidgets(piso, data) {
    int numeroPuntos = 0;
    int numeroRayas = 0;
    piso.forEach((element) {
      if (element == punto) {
        numeroPuntos++;
      }
      if (element == raya) {
        numeroRayas++;
      }
    });

    if (piso.contains(punto) && (data == concha)) {
      print("no puedes poner conchas junto con puntos");
    } else if (piso.contains(raya) && data == concha) {
      print("no puedes poner conchas junto con rayas");
    } else if (numeroPuntos >= 4 && data == punto) {
      print("maximo 4 puntos por nivel");
    } else if (numeroRayas >= 3 && data == raya) {
      print("maximo 3 rayas por nivel");
    } else if (piso.contains(concha) && (data == punto || data == raya)) {
      print("no puedes poner rayas o puntos encima de la concha en este nivel");
    } else if (piso.contains(concha) && data == concha) {
      print("Solo una concha por nivel");
    } else {
      if (data == raya) {
        piso.insert(0, raya);
      } else if (data == punto) {
        piso.add(punto);
      } else if (data == concha) {
        piso.add(concha);
      }
    }
  }

  List<Widget> pintarNumeroMaya(int numero) {
    print("numero aleatorio: $numero");
    int resultado = 0;
    int longitudNumero = numero.toString().length;
    int numeroEntero = numero;
    int posibleMultiplicador = 1;
    int multiplicador = 0;
    if (numeroEntero != 0) {
      for (int i = 1; i < longitudNumero; i++) {
        posibleMultiplicador = posibleMultiplicador * 20;
      }
      int descifrar = (numeroEntero / posibleMultiplicador).toInt();
      if (descifrar < 1) {
        multiplicador = (posibleMultiplicador / 20).toInt();
      } else {
        multiplicador = posibleMultiplicador;
      }
      //print("nivel: $multiplicador");
      Color distinguirNivel = Colors.grey;
      while (multiplicador >= 1) {
        List<Widget> separador = List();
        int valorDeNivel = (numeroEntero / multiplicador).toInt();
        int residuo = (numeroEntero % multiplicador);
        numeroEntero = residuo;
        //print("valor: $valorDeNivel - - - residuo: $residuo ---- multiplicador: $multiplicador");
        multiplicador = (multiplicador / 20).toInt();
        // insertar conchas
        int alto = 5;
        if (valorDeNivel == 0) {
          /*mostrarNumeroMaya.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [concha],
        ));*/
          separador.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 10,
              )
            ],
          ));
          separador.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [concha],
          ));
          separador.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 10,
              )
            ],
          ));
        }
        //detectar si se pueden formar rayas
        int num_rayas = (valorDeNivel / 5).toInt();
        //print("num_rayas: $num_rayas");
        if (num_rayas >= 1) {
          for (int i = 0; i < num_rayas; i++) {
            separador.add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 5,
                )
              ],
            ));
            separador.add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [raya],
            ));
            separador.add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 5,
                )
              ],
            ));
          }
          valorDeNivel = (valorDeNivel % 5);
          //print("residuo-rayas: $valorDeNivel");
        }
        //insertar puntos
        int num_puntos = valorDeNivel;
        //print("num_puntos: $num_puntos");
        if (num_puntos >= 1) {
          List<Widget> columna = List();
          for (int i = 0; i < num_puntos; i++) {
            columna.add(Column(
              children: [punto],
            ));
            columna.add(SizedBox(
              width: 5,
            ));
          }
          separador.insert(
              0,
              Container(
                width: 50,
                height: 5,
              ));
          separador.insert(
              0,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: columna,
              ));
          separador.insert(
              0,
              Container(
                width: 50,
                height: 5,
              ));
        }
        if (distinguirNivel == Colors.grey) {
          distinguirNivel = Colors.black26;
        } else {
          distinguirNivel = Colors.black12;
        }

        mostrarNumeroMaya.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              color: distinguirNivel,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: separador,
              ),
            ),
          ],
        ));
      }
    } else {
      mostrarNumeroMaya.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [concha],
            ),
          ),
        ],
      ));
    }
    return mostrarNumeroMaya;
  }

  int numeroRandom() {
    numeroAleatorio = rng.nextInt(401);
    //numeroAleatorio = 401;
    //pintarNumeroMaya(numero);
    return numeroAleatorio;
  }

  int interfazRandom() {
    numInterfaz = (rng.nextInt(3) + 1);
    print("numero interfaz: $numInterfaz");
    return numInterfaz;
  }

  int valorPiso1 = 0;
  int valorPiso2 = 0;
  int valorPiso3 = 0;
  int calcularPisos() {
    int resultado = 0;

    for (int i = 0; i < piso1.length; i++) {
      if (piso1[i] == raya) {
        resultado = resultado + 5;
      } else if (piso1[i] == punto) {
        resultado = resultado + 1;
      } else if (piso1[i] == concha) {
        resultado = resultado;
      }
    }
    valorPiso1 = resultado;
    print("valor piso 1: $valorPiso1");
    for (int i = 0; i < piso2.length; i++) {
      if (piso2[i] == raya) {
        resultado = resultado + (5 * 20);
      } else if (piso2[i] == punto) {
        resultado = resultado + (1 * 20);
      } else if (piso2[i] == concha) {
        resultado = resultado;
      }
    }
    valorPiso2 = (resultado - valorPiso1);
    print("valor piso 2: $valorPiso2");
    for (int i = 0; i < piso3.length; i++) {
      if (piso3[i] == raya) {
        resultado = resultado + (5 * 400);
      } else if (piso3[i] == punto) {
        resultado = resultado + (1 * 400);
      } else if (piso3[i] == concha) {
        resultado = resultado;
      }
    }
    valorPiso3 = (resultado - valorPiso2);
    print("valor piso 3: $valorPiso3");
    print("resultado: $resultado");
    return resultado;
  }

  Widget mostrarMensaje = Container();
  void compararNumeroRespuesta() {
    int valorMaya = 0;
    int valorArabigo = 0;
    bool resultado = false;
    if (interfazEnTurno == "maya") {
      valorMaya = calcularPisos();
      valorArabigo = numeroAleatorio;
    } else {
      valorMaya = numeroAleatorio;
      try {
        valorArabigo = int.parse(valorTextfield.text);
      } catch (e) {
        print("ingresa un numero");
        valorArabigo = -1;
      }
    }
    if (valorMaya == valorArabigo) {
      resultado = true;
      mostrarMensaje = mostrarResultado(resultado);
      print(
          "Numero Maya: $valorMaya  -  Numero Arabigo: $valorArabigo  - Correcto");
    } else {
      resultado = false;
      mostrarMensaje = mostrarResultado(resultado);
      print("tu respuesta es incorrecta");
    }
  }

  Widget mostrarResultado(resultado) {
    Widget mostrarInformacion;
    if (resultado) {
      if (interfazEnTurno == "maya" &&
          ((piso1.length <= 0) ||
              (piso3.length >= 1 && (piso2.length <= 0 || piso1.length <= 0)) ||
              (piso2.length >= 1 && piso1.length <= 0) ||
              (numeroAleatorio < 20 &&
                  (piso2.length >= 1 || piso3.length >= 1)) ||
              (numeroAleatorio < 400 &&
                  (piso3.contains(concha) || piso3.length >= 1)))) {
        mostrarInformacion = Container(
          width: 300,
          height: 70,
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                size: 40,
                color: Colors.white,
                semanticLabel: 'Cercas',
              ),
              Text(
                'Casi lo tienes',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        );
      } else {
        mostrarInformacion = Container(
          width: 300,
          height: 70,
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
                semanticLabel: 'Correcto',
              ),
              Text(
                'Correcto',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        );
      }
    } else {
      mostrarInformacion = Container(
        width: 300,
        height: 70,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 40,
              color: Colors.white,
              semanticLabel: 'Incorrecto',
            ),
            Text(
              'Incorrecto',
              style: TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      );
    }
    return mostrarInformacion;
  }

  @override
  Widget build(BuildContext context) {
    Widget draggableStatus = Container(
      width: 700,
      height: 150,
      color: Colors.grey,
      child: accepted == true
          ? new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: regresarLista(piso1))
          : Container(),
    );
    Widget draggableStatus2 = Container(
      width: 700,
      height: 150,
      color: Colors.grey,
      child: accepted == true
          ? new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: regresarLista(piso2))
          : Container(),
    );
    Widget draggableStatus3 = Container(
      width: 700,
      height: 150,
      color: Colors.grey,
      child: accepted == true
          ? new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: regresarLista(piso3))
          : Container(),
    );
    void borrar() {
      draggableStatus = Container(
        width: 700,
        height: 150,
        color: Colors.grey,
        child: Container(),
      );
      draggableStatus2 = Container(
        width: 700,
        height: 150,
        color: Colors.grey,
        child: Container(),
      );
      draggableStatus3 = Container(
        width: 700,
        height: 150,
        color: Colors.grey,
        child: Container(),
      );
      piso1 = List();
      piso2 = List();
      piso3 = List();
    }

    Widget interfazMaya = Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 10,
                  ),
                  Text(
                    'Escribe el número Arábigo en Maya',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    numeroAleatorio.toString(),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 50,
                    height: 10,
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  DragTarget<Widget>(
                    builder: (context, data, rejected) {
                      return draggableStatus3;
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      setState(() {
                        accepted = true;
                        agregarWidgets(piso3, data);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 50,
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  DragTarget<Widget>(
                    builder: (context, data, rejected) {
                      return draggableStatus2;
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      setState(() {
                        accepted = true;
                        agregarWidgets(piso2, data);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 50,
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  DragTarget<Widget>(
                    builder: (context, data, rejected) {
                      return draggableStatus;
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      setState(() {
                        accepted = true;
                        agregarWidgets(piso1, data);
                        //pintarNumeroMaya("333");
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 50,
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable<Widget>(
                data: raya,
                child: rayaBoton,
                childWhenDragging: secundario,
                feedback: raya,
              ),
              SizedBox(
                width: 10,
              ),
              Draggable<Widget>(
                data: punto,
                child: puntoBoton,
                childWhenDragging: secundario,
                feedback: punto,
              ),
              SizedBox(
                width: 10,
              ),
              Draggable<Widget>(
                data: concha,
                child: conchaBoton,
                childWhenDragging: secundario,
                feedback: concha,
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [mostrarMensaje],
          ),
        ],
      ),
    );
    Widget interfazArabiga = Container(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 20,
          ),
          Text(
            "Escribe el número Maya en Arábigo",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Container(
            width: 100,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: mostrarNumeroMaya,
              ),
            ],
          ),
          Container(
            width: 50,
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  controller: valorTextfield,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingresa el número arábigo'),
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              )
            ],
          ),
          Container(
            width: 50,
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [mostrarMensaje],
          ),
        ],
      ),
    );
    Widget seleccionarInterfaz() {
      if (numInterfaz != 3) {
        print("modo maya");
        interfazEnTurno = "maya";
        return interfazMaya;
      } else {
        print("modo arabigo");
        interfazEnTurno = "arabiga";
        pintarNumeroMaya(numeroAleatorio);
        return interfazArabiga;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Números Maya - Arábigos'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[seleccionarInterfaz()],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                accepted = false;
                borrar();
              });
            },
            label: Text('Borrar'),
            icon: Icon(Icons.delete),
            backgroundColor: Colors.red,
          ),
          Container(
            width: 50,
            height: 50,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                //accepted = false;
                compararNumeroRespuesta();
                //borrar();
                mostrarNumeroMaya = List();
              });
            },
            label: Text('Calcular'),
            icon: Icon(Icons.check),
            backgroundColor: Colors.blue,
          ),
          Container(
            width: 50,
            height: 50,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                //accepted = true;
                accepted = false;
                borrar();
                numeroRandom();
                interfazRandom();
                mostrarMensaje = Container();
                mostrarNumeroMaya = List();
                valorTextfield.text = "";
              });
            },
            label: Text('Continuar'),
            icon: Icon(Icons.arrow_right_outlined),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
