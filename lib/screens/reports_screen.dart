import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../helpers/extensions.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              ReportItemWidget(
                imageUrl: 'https://placecats.com/300/200.png',
                title: 'Broken Main ',
                likes: '4.92',
                date: DateTime(2024, 10, 10),
                //onTap: () {},
              ),
               ReportItemWidget(
                imageUrl: 'https://placecats.com/300/200.png',
                title: 'Light post down',
                likes: '4.92',
                date: DateTime(2024, 10, 10),
                //onTap: () {},
              ),
               ReportItemWidget(
                imageUrl: 'https://placecats.com/300/200.png',
                title: 'Pothole',
                likes: '4.92',
                date: DateTime(2024, 10, 10),
                //onTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ReportItemWidget extends StatelessWidget {
  const ReportItemWidget({
    super.key,
    this.imageUrl,
    this.title,
    this.onTap,
    this.likes,
    this.date,
  });

  final String? imageUrl;
  final String? title;
  final String? likes;
  final VoidCallback? onTap;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
        final borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white // Color for dark mode
        : Colors.black; // Color for light mode
    BorderSide side =  BorderSide( color: borderColor, width: 3);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        border: Border(
                          top: side,
                          left: side,
                          right: side,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      height: 198,
                    ),
                    Positioned(
                        top: 18,
                        right: 18,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            LucideIcons.heart,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                  ],
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border(
                    bottom: side,
                    left: side,
                    right: side,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                   
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                  date != null?  Text(
                                date!.toFormattedDayCountdownShort(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ):
                              Text(
                                '2 days ago',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                           
                            const Spacer(),
                     
                             
                                Text(
                                  "Freetown",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                     
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              
                            
                          ]),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    this.color = Colors.grey,
    this.textColor = Colors.black,
  });
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor,
            ),
      ),
    );
  }
}
