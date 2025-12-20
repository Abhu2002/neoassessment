import 'dart:io';

import 'package:neoassessment_server/src/web/widgets/default_page_widget.dart';
import 'package:serverpod/serverpod.dart';

class RouteRoot extends WidgetRoute {
  @override
  Future<Widget> build(Session session, HttpRequest request) async {
    var res = await session.db.query("SELECT * FROM role");
    print("roles: $res");
    return DefaultPageWidget();
  }
}
