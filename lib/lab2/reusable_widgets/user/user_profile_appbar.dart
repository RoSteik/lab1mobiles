import 'package:flutter/material.dart';

AppBar userProfileAppBar() => AppBar(
      title: const Text('User Profile'),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
      ],
    );
