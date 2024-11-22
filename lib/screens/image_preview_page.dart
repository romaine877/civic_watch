import 'dart:io';

import 'package:animated_reorderable/animated_reorderable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({super.key, this.mapSnap, required this.images});
  final List<XFile> images;
  final File? mapSnap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        //minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (mapSnap != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox.square(
                            dimension: 200,
                            child: Image.file(
                              mapSnap!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      AnimatedReorderable.grid(
                        // Configure the keyGetter using a function that
                        // takes the index of the item and must return its unique key.
                        keyGetter: (index) => ValueKey(images[index]),
                      
                        // Define the onReorder callback to synchronize the order
                        // of items. The callback takes permutations that need to be
                        // applied to the collection of items.
                        onReorder: (permutations) => permutations.apply(images),
                      
                        gridView: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.file(
                              File(images[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            MainButton(
              text: 'Submit',
              onPressed: () {
                context.pop(true);
              },
            )
          ],
        ),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.onPressed,
    this.text = '',
  });

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
