import 'package:flutter/material.dart';
import 'package:flutter_i18next/i18next.dart';
import 'package:marvel_characters/core/app_colors.dart';
import 'package:marvel_characters/domain/entities/url.dart';

class UrlsChip extends StatelessWidget {
  final List<Url> urls;
  final Function(String) onItemPressed;

  const UrlsChip({Key? key, required this.urls, required this.onItemPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t('common.links'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4.0,
          children: List<GestureDetector>.from(
            urls.map(
              (e) => GestureDetector(
                  onTap: () => onItemPressed(e.url),
                  child: Chip(
                    label: Text(
                      e.type,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    backgroundColor: AppColors.blue,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
