import 'package:car_services_app/models/order.dart';
import 'package:car_services_app/screens/orders_page_model_view.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/services/firebase_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: OrdersPageModelView().takeOrderList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('There is an error.'));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Order> allOrders = [];

          allOrders = snapshot.data!.docs.map((doc) {
            return Order.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          String? currentEmail = Auth().takingCurrentUserEmail();

          List<Order> currentUserOrder = allOrders
              .where(
                  (order) => (order.email == currentEmail && !order.isFinished))
              .toList();
          print(currentUserOrder.length);

          List<Order> oldUserOrder = allOrders
              .where(
                  (order) => (order.email == currentEmail && order.isFinished))
              .toList();
          print(oldUserOrder.length);

          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: Text('Orders'),
                bottom: const TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text('Current'),
                    ),
                    Tab(
                      child: Text('Old'),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  orderListViewing(currentUserOrder),
                  orderListViewing(oldUserOrder),
                ],
              ),
            ),
          );
        });
  }

  ListView orderListViewing(List<Order> currentUserOrder) {
    return ListView.builder(
        itemCount: currentUserOrder.length,
        itemBuilder: (context, index) {
          List<String> detailInfo = currentUserOrder[index].detail.split('**');

          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.orange,
            ),
            child: Column(
              children: [
                Text(
                  'Type Of Service: ${currentUserOrder[index].orderType}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text(
                  'Car Brand: ${currentUserOrder[index].carBrand}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Car Model: ${currentUserOrder[index].carModel}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Car Year: ${currentUserOrder[index].carYear}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Car Gear Type: ${currentUserOrder[index].gearType}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Car Fuel Type: ${currentUserOrder[index].fuelType}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Car Plate: ${currentUserOrder[index].plate}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text(
                  'Details:',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: detailInfo.length,
                      itemBuilder: (context, index2) {
                        return Center(
                          child: Text(
                            detailInfo[index2],
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        );
                      }),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text(
                  'Price: ${currentUserOrder[index].cost}\$',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          );
        });
  }
}
