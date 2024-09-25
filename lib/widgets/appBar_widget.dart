import 'package:flutter/material.dart';

import '../screens/trip_plan_page.dart';

AppBar buildCustomAppBar(BuildContext context, bool isLightTheme, VoidCallback toggleTheme) {

  return AppBar(
    title: Text(
      'My App Trip',
      style: TextStyle(
        color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
      ),
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        _showPopupMenu(context);
        //print('ops');
      },
      color: Theme.of(context).iconTheme.color,
    ),
    actions: [
      GestureDetector(
        onTap: (){
          print('User Acc');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Icon(Icons.account_circle,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Switch(
          value: isLightTheme,
          onChanged: (value) => toggleTheme(),
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ],
  );
}

// Função para mostrar o menu popup
void _showPopupMenu(BuildContext context) {
  showMenu(
    context: context,
    shadowColor: Theme.of(context).colorScheme.tertiary,
    position: const RelativeRect.fromLTRB(0, kToolbarHeight, 0, 0),
    items: [
      const PopupMenuItem(
        value: 1,
        child: Text('Opção 1'),
      ),
      const PopupMenuItem(
        value: 2,
        child: Text('Opção 2'),
      ),
      const PopupMenuItem(
        value: 3,
        child: Text('Opção 3'),
      ),
    ],
    elevation: 8.0,
    color: Theme.of(context).colorScheme.secondary,
  ).then((value) {
    switch (value) {
      case 1:
        print('Opção 1 selecionada');
        break;
      case 2:
        print('Opção 2 selecionada');
        break;
      case 3:
        print('Opção 3 selecionada');
        break;
      default:
        print('Nenhuma opção selecionada');
        break;
    }
  });
}