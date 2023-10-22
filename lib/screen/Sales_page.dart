import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';

class TileWithCircle extends StatelessWidget {
  final double percentage;

  TileWithCircle({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        width: 222.0,
        height: 89.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              Text(
                'Sale',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20.0),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: CustomPaint(
                    painter: CirclePainter(percentage),
                    child: Center(
                      child: Text(
                        '$percentage%',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double percentage;

  CirclePainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double arcAngle = 2 * 3.14 * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _TileWithCircleHeader extends SliverPersistentHeaderDelegate {
  final double percentage;

  _TileWithCircleHeader({required this.percentage});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TileWithCircle(percentage: percentage);
  }

  @override
  double get maxExtent => 89.0;

  @override
  double get minExtent => 89.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class UserListTile extends StatelessWidget {
  final String name;
  final String saleText;
  final String imageUrl;

  UserListTile({
    required this.name,
    required this.saleText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 86.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          saleText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              delegate: _TileWithCircleHeader(percentage: 20.10),
              floating: false,
              pinned: true,
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      UserListTile(
                        name: 'John Doe',
                        saleText: '100 units sold',
                        imageUrl: 'https://example.com/john_doe.jpg',
                      ),
                      UserListTile(
                        name: 'Jane Smith',
                        saleText: '150 units sold',
                        imageUrl: 'https://example.com/jane_smith.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      UserListTile(
                        name: 'Bob Johnson',
                        saleText: '80 units sold',
                        imageUrl: 'https://example.com/bob_johnson.jpg',
                      ),
                      // Add more UserListTile widgets as needed
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}