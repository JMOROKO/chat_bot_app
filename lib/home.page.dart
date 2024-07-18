import 'package:flutter/material.dart';
import 'package:alert_dialog/alert_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage(
      {super.key}); //lorsqu'on ajoute des attribut pour un statless on supprime le mot clé const

  TextEditingController loginController =
      new TextEditingController(); //attribut, qui sera utilisé pour récupérer les valeurs saisie dans les champs de texte
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login : admin | password : 1234",
          style: TextStyle(
            color: Theme.of(context).indicatorColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 400,
          height: 500,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 250,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller:
                        loginController, //permet de récupérer la valeur saisi dans le champs de texte
                    decoration: InputDecoration(
                      /*icon: Icon(
                        Icons.lock,
                      ),*/
                      suffix: Icon(
                        Icons.lock,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:
                        passwordController, //permet de récupérer la valeur saisi dans le champs de texte
                    //pour ajouter un champs de texte
                    obscureText: true, //pour cacher le texte saisi
                    decoration: InputDecoration(
                      suffix: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity, //la largeur maximum
                    child: ElevatedButton(
                      onPressed: () {
                        String username = loginController.text;
                        String password = passwordController.text;
                        if (username == "admin" && password == "1234") {
                          Navigator.of(context)
                              .pop(); //supprimer l'historique de la page actuel afin de ne plus pouvoir revenir dessus une fois sur la page suivante
                          Navigator.pushNamed(context,
                              "/chat"); //permet d'accéder à la route créé
                        } else {
                          alert(
                            context,
                            title: Text(
                                "Le login ou le mot de passe est incorrect"),
                          );
                        }
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Theme.of(context).indicatorColor,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
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
