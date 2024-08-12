import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/products.dart';

class StaticCard extends StatefulWidget {
  final Product product;
  final VoidCallback onProductChanged;
  const StaticCard(
      {required this.product, required this.onProductChanged, super.key});

  @override
  State<StaticCard> createState() => _StaticCardState();
}

class _StaticCardState extends State<StaticCard> {
  final eApp = ECommerce();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: () {
          debugPrint('Go to the details of ${widget.product.getId}');
          Navigator.pushNamed(context, '/details', arguments: widget.product)
              .then((result) {
            if (result == true) {
              widget.onProductChanged();
            }
          });
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
                  'images/shoe.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.product.getName}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3E3E3E),
                      ),
                    ),
                    Text(
                      '\$ ${widget.product.getPrice}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3E3E3E),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.product.getCatagory}',
                      style: const TextStyle(
                        color: Color(0XFFAAAAAA),
                        fontSize: 12.0,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0XFFFFD700),
                          size: 25,
                        ),
                        Text(
                          '(4.0)',
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
