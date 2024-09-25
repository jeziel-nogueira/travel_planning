import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).appBarTheme.backgroundColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0, // Ajusta a distância entre o FAB e a BottomAppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => onItemTapped(0),
            icon: Icon(
              Icons.home,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
          ),
          const SizedBox(width: 40), // Espaço para o FAB no centro
          IconButton(
            onPressed: () => onItemTapped(2),
            icon: Icon(
              Icons.travel_explore_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}


//Container(

    // padding: const EdgeInsets.symmetric(vertical: 10), // Adicionando padding vertical
    // decoration: const BoxDecoration(
    //   color: Colors.white, // Cor de fundo
    //   boxShadow: [
    //     BoxShadow(
    //       color: Colors.black26,
    //       offset: Offset(0, -2),
    //       blurRadius: 8,
    //       spreadRadius: 2,
    //     ),
    //   ],
    // ),
    // child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     // Botão Home à esquerda
    //     IconButton(
    //       icon: Icon(
    //         Icons.home,
    //         color: selectedIndex == 0 ? Colors.blue : Colors.grey, // Azul se selecionado
    //         size: 30,
    //       ),
    //       onPressed: () => onItemTapped(0),
    //     ),
    //
    //     // Botão More no centro, destacado
    //     Container(
    //       padding: const EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         color: Colors.blueAccent,
    //         shape: BoxShape.circle,
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.blueAccent.withOpacity(0.5),
    //             blurRadius: 10,
    //             spreadRadius: 5,
    //           )
    //         ],
    //       ),
    //       child: IconButton(
    //         icon: const Icon(
    //           Icons.add_circle_outline_rounded,
    //           color: Colors.white,
    //           size: 20, // Tamanho maior para destacar
    //         ),
    //         onPressed: () => onItemTapped(1),
    //       ),
    //     ),
    //
    //     // Botão Account à direita
    //     IconButton(
    //       icon: Icon(
    //         Icons.account_circle,
    //         color: selectedIndex == 2 ? Colors.blue : Colors.grey, // Azul se selecionado
    //         size: 30,
    //       ),
    //       onPressed: () => onItemTapped(2),
    //     ),
    //   ],
    // ),
    //);
