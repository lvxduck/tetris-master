import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomImageProvider = AutoDisposeProvider<String>((ref) {
  final images = [
    'http://chiase24.com/wp-content/uploads/2022/02/Tong-hop-cac-hinh-anh-background-dep-nhat-28.jpg',
    'http://chiase24.com/wp-content/uploads/2022/02/Tong-hop-cac-hinh-anh-background-dep-nhat-25.jpg',
    'https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80',
    'http://chiase24.com/wp-content/uploads/2022/02/Tong-hop-cac-hinh-anh-background-dep-nhat-21.jpg',
  ];
  return images[Random().nextInt(images.length)];
});
