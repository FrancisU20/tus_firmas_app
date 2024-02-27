// module model
import 'package:flutter/material.dart';
import 'package:tus_firmas_app/models/module_model.dart';

class CardModule extends ModuleModel {
  final String? title;
  final String? subtitle;
  final String? image;
  final String? route;

  CardModule({
    this.title,
    this.subtitle,
    this.image,
    this.route,
  }) : super(
          nombre: title ?? '',
          descripcion: subtitle ?? '',
          asset: image ?? '',
        );

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route!);
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
