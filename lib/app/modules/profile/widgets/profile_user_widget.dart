import 'package:macrame_app/app/common/extensions/app_size_extension.dart';
import 'package:macrame_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

class ProfileUserWidget extends StatelessWidget {
  const ProfileUserWidget({
    super.key,
    this.imageUrl = "https://i.ibb.co/PGv8ZzG/me.jpg",
    this.name = 'Jhon Doe',
    this.email = 'jhondoe@gmail.com',
  });

  final String imageUrl;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: NetworkImage(imageUrl),
        ),
        20.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name.asTitleNormal(
              fontWeight: FontWeight.w700,
            ),
            6.height,
            email.asSubtitleBig(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
