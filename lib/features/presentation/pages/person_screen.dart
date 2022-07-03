import 'package:clean_arch/features/presentation/widgets/custom_search_delegate.dart';
import 'package:clean_arch/features/presentation/widgets/persons_list_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: (){
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: PersonsList(),
    );
  }
}
