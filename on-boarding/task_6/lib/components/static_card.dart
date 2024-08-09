import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaticCard extends StatefulWidget {
  const StaticCard({super.key});

  @override
  State<StaticCard> createState() => _StaticCardState();
}

class _StaticCardState extends State<StaticCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: () {
          debugPrint("Go to the details page");
        },
        child: Card(
          color: const Color(0XFFFFFFFF),
          // clipBehavior: Clip.antiAlias,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "images/shoe.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Derby Leather Shoes",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3E3E3E),
                      ),
                    ),
                    Text(
                      "\$120",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3E3E3E),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Men's shoe",
                      style: TextStyle(
                        color: Color(0XFFAAAAAA),
                        fontSize: 12.0,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0XFFFFD700),
                          size: 25,
                        ),
                        Text(
                          "(4.0)",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0XFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
