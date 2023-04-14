import 'package:conexion/widgets/drawer/CustomDrawer.dart';
import 'package:conexion/widgets/gallery/model/itemModel.dart';
import 'package:conexion/widgets/gallery/widget/GalleryItem.dart';
import 'package:conexion/widgets/gallery/widget/StaggeredGridView.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('BEER DELIVERY'),
      ),
      drawer: const CustomDrawer(),
      body: StaggeredGridView(itemBuilder: (context, index) => GalleryItem(item: items[index]), itemCount: items.length   ),
    );
  }
}