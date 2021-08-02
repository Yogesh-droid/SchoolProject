import 'package:flutter/material.dart';
import 'package:app/utils/modal/Fee.dart';

// ignore: must_be_immutable
class FeePaymentRow extends StatelessWidget {

  Fee fee;
  FeePaymentRow(this.fee);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  fee.title,
                  style: Theme.of(context).textTheme.headline,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Due Date',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        fee.dueDate,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Amount',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        '\$'+fee.amount,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Paid',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        '\$'+fee.paid,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Balance',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        '\$'+fee.balance,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
