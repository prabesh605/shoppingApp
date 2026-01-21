import 'package:flutter/material.dart';
import 'package:shopping_app/constant/order_status.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key, required this.status});
  final OrderStatus status;

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  int getStepIndex(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.processing:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.completed:
        return 3;
      case OrderStatus.cancelled:
        return 0;
    }
  }

  StepState getStateState(int stepIndex) {
    final currentIndex = getStepIndex(widget.status);
    if (stepIndex < currentIndex) {
      return StepState.complete;
    } else if (stepIndex == currentIndex) {
      return StepState.editing;
    } else {
      return StepState.indexed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Status")),
      body: Column(
        children: [
          SizedBox(
            // height: 200,
            width: double.infinity,
            child: Stepper(
              controlsBuilder: (context, details) => SizedBox(),
              currentStep: getStepIndex(widget.status),

              steps: [
                //
                Step(
                  title: Text("Pending"),
                  content: SizedBox(),
                  state: getStateState(0),
                  isActive: getStepIndex(widget.status) >= 0,
                ),
                Step(
                  title: Text("Processing"),
                  content: SizedBox(),
                  state: getStateState(0),
                  isActive: getStepIndex(widget.status) >= 1,
                ),
                Step(
                  title: Text("Shipped"),
                  content: SizedBox(),
                  state: getStateState(0),
                  isActive: getStepIndex(widget.status) >= 2,
                ),
                Step(
                  title: Text("Completed"),
                  content: SizedBox(),
                  state: getStateState(0),
                  isActive: getStepIndex(widget.status) >= 3,
                ),
                Step(
                  title: Text("Cancelled"),
                  content: SizedBox(),
                  state: widget.status == OrderStatus.cancelled
                      ? StepState.error
                      : StepState.indexed,
                  isActive: widget.status == OrderStatus.cancelled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
