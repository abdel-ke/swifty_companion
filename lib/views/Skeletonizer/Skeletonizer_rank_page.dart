import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonizerRankPage extends StatelessWidget {
  const SkeletonizerRankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Change this value as needed
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 230,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const SkeletonizerCardUser();
          },
        ),
      // ),
    );
  }
}

class SkeletonizerCardUser extends StatelessWidget {
  const SkeletonizerCardUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(radius: 50),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'login',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text('level: 0.00}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.green.shade500)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text('Location'),
              const SizedBox(height: 5),
              const Text(
                'BH  days left',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0), // Adjust as needed
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
            ],
          )),
    );
  }
}
