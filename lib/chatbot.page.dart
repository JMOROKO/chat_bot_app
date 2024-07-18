import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//
class ChatBotPage extends StatefulWidget {
  ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  List messages = [];

  TextEditingController queryController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Chat bot",
          style: TextStyle(
            color: Theme.of(context).indicatorColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            //permet de dire que l'élément enfant prend tous l'espace
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                controller: scrollController,
                itemCount:
                    messages.length, //recupérer le nombre d'élément de la liste

                itemBuilder: (context, index) {
                  bool isUser = messages[index]['type'] == "user";
                  return Column(
                    children: [
                      ListTile(
                        trailing: isUser ? Icon(Icons.person) : null,
                        leading: !isUser ? Icon(Icons.support_agent) : null,
                        title: Row(
                          children: [
                            SizedBox(
                              width: isUser ? 100 : 0,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  messages[index]['message'],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                color: isUser == true
                                    ? Color.fromARGB(100, 0, 200, 0)
                                    : Colors.grey,
                                padding: EdgeInsets.all(10),
                              ),
                            ),
                            SizedBox(
                              width: isUser ? 0 : 100,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: queryController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      String query = queryController.text;
                      var openAiLLMUri =
                          Uri.https("api.openai.com", "/v1/chat/completions");
                      Map<String, String> httpHeaders = {
                        "Content-type": "application/json",
                        "Authorization": "Bearer api_key"
                      };

                      var prompt = {
                        "model": "gpt-4o-mini",
                        "messages": [
                          {"role": "user", "content": query}
                        ],
                        "temperature": 0
                      };
                      http
                          .post(openAiLLMUri,
                              headers: httpHeaders, body: json.encode(prompt))
                          .then((resp) {
                        var responseBody = resp.body;
                        var llmResponse = json.decode(responseBody);
                        String responseContente =
                            llmResponse["choices"][0]["message"]["content"];

                        setState(() {
                          messages.add({"message": query, "type": "user"});
                          messages.add({
                            "message": responseContente,
                            "type": "assistant"
                          });
                        });
                        queryController.text = "";
                        //permet de scroller vers le bas
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 200);
                      }, onError: (err) {
                        print("+++++++++++++++++++++++++++++++++++");
                        print(err);
                        print("+++++++++++++++++++++++++++++++++++");
                      });
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
