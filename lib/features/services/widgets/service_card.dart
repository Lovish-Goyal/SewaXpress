import 'package:flutter/material.dart';
import 'package:sewaxpress/features/services/models/service_model.dart';

import '../../service_providers/widgets/service_providers.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceProvidersScreen(service: service),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: service.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(service.icon, size: 30, color: service.color),
                ),
                SizedBox(height: 15),
                Text(
                  service.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  service.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 119, 119, 119),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
